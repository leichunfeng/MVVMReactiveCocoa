//
//  MRCAvatarHeaderViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCAvatarHeaderViewModel.h"

@interface MRCAvatarHeaderViewModel ()

@property (nonatomic, strong, readwrite) OCTUser *user;

@end

@implementation MRCAvatarHeaderViewModel

- (instancetype)initWithUser:(OCTUser *)user {
    self = [super init];
    if (self) {
        self.user = user;
    }
    return self;
}

@end
