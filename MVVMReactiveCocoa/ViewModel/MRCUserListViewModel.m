//
//  MRCUserListViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/8.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCUserListViewModel.h"
#import "MRCUsersItemViewModel.h"
#import "MRCUserDetailViewModel.h"

@interface MRCUserListViewModel ()

@property (strong, nonatomic) OCTUser *user;
@property (assign, nonatomic, readwrite) MRCUserListViewModelType type;
@property (assign, nonatomic, readwrite) BOOL isCurrentUser;

@end

@implementation MRCUserListViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.user = params[@"user"];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.isCurrentUser = [self.user.objectID isEqualToString:[OCTUser mrc_currentUserId]];
    
    self.type = [self.params[@"type"] unsignedIntegerValue];
    
    if (self.type == MRCUserListViewModelTypeFollowers) {
        self.title = @"Followers";
    } else if (self.type == MRCUserListViewModelTypeFollowing) {
        self.title = @"Following";
    }
    
    self.shouldPullToRefresh = YES;
    self.shouldInfiniteScrolling = YES;
    
    @weakify(self)
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self)
        MRCUsersItemViewModel *itemViewModel = self.dataSource[indexPath.section][indexPath.row];
        MRCUserDetailViewModel *viewModel = [[MRCUserDetailViewModel alloc] initWithServices:self.services params:@{ @"user": itemViewModel.user }];
        [self.services pushViewModel:viewModel animated:YES];
        return [RACSignal empty];
    }];
    
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
    if (self.type == MRCUserListViewModelTypeFollowers) {
        return [[[[self.services
        	client]
            fetchFollowersWithUser:self.user page:currentPage perPage:self.pageSize]
            collect]
        	doNext:^(NSArray *users) {
                if (users != nil && users.count > 0) {
                    for (OCTUser *user in users) {
                        user.userId = [OCTUser mrc_currentUserId];
                    }
                    
                    if (self.isCurrentUser) {
                        for (OCTUser *user in users) {
                            user.isFollower = YES;
                        }
                    } else {
                        NSArray *followers = [OCTUser mrc_fetchFollowersWithPage:0 perPage:0];
                        for (OCTUser *user in users) {
                            for (OCTUser *follower in followers) {
                                if ([user.objectID isEqualToString:follower.objectID]) {
                                    user.isFollower = YES;
                                    break;
                                }
                            }
                        }
                    }
                    
                    if (currentPage == 1) {
                        self.users = users;
                    } else {
                        self.users = @[ (self.users ?: @[]).rac_sequence, users.rac_sequence ].rac_sequence.flatten.array;
                    }
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [OCTUser mrc_saveOrUpdateFollowers:users];
                    });
                }
            }];
    } else if (self.type == MRCUserListViewModelTypeFollowing) {
        return [[[[self.services
            client]
            fetchFollowingWithPage:currentPage]
            collect]
            doNext:^(NSArray *users) {
                if (users != nil && users.count > 0) {
                    for (OCTUser *user in users) {
                        user.userId = [OCTUser mrc_currentUserId];
                    }
                    
                    if (self.isCurrentUser) {
                        for (OCTUser *user in users) {
                            user.isFollowing = YES;
                        }
                    } else {
                        NSArray *followings = [OCTUser mrc_fetchFollowingWithPage:0 perPage:0];
                        for (OCTUser *user in users) {
                            for (OCTUser *following in followings) {
                                if ([user.objectID isEqualToString:following.objectID]) {
                                    user.isFollowing = YES;
                                    break;
                                }
                            }
                        }
                    }
                    
                    if (currentPage == 1) {
                        self.users = users;
                    } else {
                        self.users = @[ (self.users ?: @[]).rac_sequence, users.rac_sequence ].rac_sequence.flatten.array;
                    }
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        if (self.isCurrentUser) {
                            [OCTUser mrc_saveOrUpdateFollowing:users];
                        } else {
                            [OCTUser mrc_saveOrUpdateFollowers:users];
                        }
                    });
                }
            }];
    }
    return [RACSignal empty];
}

@end
