//
//  OCTClient+MRCUser.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/19.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <OctoKit/OctoKit.h>

@interface OCTClient (MRCUser)

- (RACSignal *)mrc_followUser:(OCTUser *)user;
- (RACSignal *)mrc_unfollowUser:(OCTUser *)user;

@end
