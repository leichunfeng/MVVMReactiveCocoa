//
//  MRCUserDetailViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/16.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCUserDetailViewModel.h"

@implementation MRCUserDetailViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.user = params[@"user"];
    }
    return self;
}

- (RACSignal *)requestRemoteDataSignal {
    return [[self.services.client
        fetchUserInfoWithLogin:self.user.login]
        doNext:^(OCTUser *user) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.user mergeValuesForKeysFromModel:user];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self.user mrc_saveOrUpdate];
                });
            });
        }];
}

@end
