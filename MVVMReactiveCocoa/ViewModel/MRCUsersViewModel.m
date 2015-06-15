//
//  MRCUsersViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/8.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCUsersViewModel.h"
#import "MRCUsersItemViewModel.h"

@interface MRCUsersViewModel ()

@property (assign, nonatomic, readwrite) MRCUsersViewModelType type;

@end

@implementation MRCUsersViewModel

- (void)initialize {
    [super initialize];
    
    self.type = [self.params[@"type"] unsignedIntegerValue];
    
    if (self.type == MRCUsersViewModelTypeFollowers) {
        self.title = @"Followers";
    } else if (self.type == MRCUsersViewModelTypeFollowing) {
        self.title = @"Following";
    }
    
    self.shouldPullToRefresh = YES;
    self.shouldInfiniteScrolling = YES;
    
    @weakify(self)
    [[RACObserve(self, users)
        ignore:nil]
        subscribeNext:^(NSArray *users) {
            @strongify(self)
            self.dataSource = @[ [users.rac_sequence map:^(OCTUser *user) {
                return [[MRCUsersItemViewModel alloc] initWithUser:user];
            }].array ];
        }];
}

- (RACSignal *)requestRemoteDataSignalWithCurrentPage:(NSUInteger)currentPage {
    if (self.type == MRCUsersViewModelTypeFollowers) {
        return [[[[self.services
        	client]
            fetchFollowersWithPage:currentPage]
            collect]
        	doNext:^(NSArray *users) {
                if (users != nil && users.count > 0) {
                    for (OCTUser *user in users) {
                        user.userId = [OCTUser mrc_currentUserId];
                        user.isFollower = YES;
                    }
                    
                    if (currentPage == 1) {
                        self.users = users;
                    } else {
                        self.users = @[ (self.users ?: @[]).rac_sequence, users.rac_sequence ].rac_sequence.flatten.array;
                    }
                    
                    //                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    //                    [OCTUser mrc_saveOrUpdateFollowers:users];
                    //                });
                }
            }];
    } else if (self.type == MRCUsersViewModelTypeFollowing) {
        return [[[[self.services
            client]
            fetchFollowingWithPage:currentPage]
            collect]
            doNext:^(NSArray *users) {
                if (users != nil && users.count > 0) {
                    for (OCTUser *user in users) {
                        user.userId = [OCTUser mrc_currentUserId];
                        user.isFollower = YES;
                    }
                    
                    if (currentPage == 1) {
                        self.users = users;
                    } else {
                        self.users = @[ (self.users ?: @[]).rac_sequence, users.rac_sequence ].rac_sequence.flatten.array;
                    }
                    
                    //                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    //                    [OCTUser mrc_saveOrUpdateFollowers:users];
                    //                });
                }
            }];
    }
    return [RACSignal empty];
}

@end
