//
//  MRCMemoryCache.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/17.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRCMemoryCache : NSObject

+ (instancetype)sharedInstance;

- (id)objectForKey:(NSString *)key;
- (void)setObject:(id)object forKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key;

@end
