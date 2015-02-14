//
//  MRCAvatarHeaderViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCAvatarHeaderViewModel.h"

@implementation MRCAvatarHeaderViewModel

- (instancetype)initWithUser:(OCTUser *)user {
    self = [super init];
    if (self) {
        RAC(self, avatarURL) = RACObserve(user, avatarURL);
        RAC(self, name) = RACObserve(user, name);
        RAC(self, followers) = [RACObserve(user, followers) map:^id(NSNumber *followers) {
            return followers.stringValue;
        }];
        RAC(self, repositories) = [RACObserve(user, publicRepoCount) map:^id(NSNumber *publicRepoCount) {
            return publicRepoCount.stringValue;
        }];
        RAC(self, following) = [RACObserve(user, following) map:^id(NSNumber *following) {
            return following.stringValue;
        }];
    }
    return self;
}

@end
