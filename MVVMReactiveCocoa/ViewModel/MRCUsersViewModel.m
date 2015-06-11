//
//  MRCUsersViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/8.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCUsersViewModel.h"
#import "MRCUsersItemViewModel.h"

@implementation MRCUsersViewModel

- (RACSignal *)requestRemoteDataSignal {
    @weakify(self)
    return [[[[self.services
    	client]
    	fetchFollowers]
    	collect]
    	doNext:^(NSArray *users) {
            @strongify(self)
            if (users != nil && users.count > 0) {
                for (OCTUser *user in users) {
                    user.userId = [OCTUser mrc_currentUserId];
                    user.isFollower = YES;
                }
                
                self.dataSource = @[ [users.rac_sequence map:^(OCTUser *user) {
                    return [[MRCUsersItemViewModel alloc] initWithUser:user];
                }].array ];
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [OCTUser mrc_saveOrUpdateFollowers:users];
                });
            }
        }];
}

@end
