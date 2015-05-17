//
//  MRCMemoryCache.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/17.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCMemoryCache.h"

static MRCMemoryCache *_memoryCache = nil;

@interface MRCMemoryCache ()

@property (strong, nonatomic) NSMutableDictionary *dictionary;

@end

@implementation MRCMemoryCache

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _memoryCache = [[MRCMemoryCache alloc] init];
    });
    return _memoryCache;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dictionary = [NSMutableDictionary new];
    }
    return self;
}

- (id)objectForKey:(NSString *)key {
    return [self.dictionary objectForKey:key];
}

- (void)setObject:(id)object forKey:(NSString *)key {
    [self.dictionary setObject:object forKey:key];
}

- (void)removeObjectForKey:(NSString *)key {
    [self.dictionary removeObjectForKey:key];
}

@end
