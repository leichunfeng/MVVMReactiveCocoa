//
//  OCTClient+MRCUser.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/19.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "OCTClient+MRCUser.h"

@implementation OCTClient (MRCUser)

- (RACSignal *)mrc_followUser:(OCTUser *)user {
    if (user.followingStatus == OCTUserFollowingStatusYES) return [RACSignal empty];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [OCTUser mrc_followUser:user];
    });
    
    return [self followUser:user];
}

- (RACSignal *)mrc_unfollowUser:(OCTUser *)user {
    if (user.followingStatus == OCTUserFollowingStatusNO) return [RACSignal empty];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [OCTUser mrc_unfollowUser:user];
    });
    
    return [self unfollowUser:user];
}

@end
