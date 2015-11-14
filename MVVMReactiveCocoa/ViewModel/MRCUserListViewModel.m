//
//  MRCUserListViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/8.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCUserListViewModel.h"
#import "MRCUserListItemViewModel.h"
#import "MRCUserDetailViewModel.h"

@interface MRCUserListViewModel ()

@property (nonatomic, strong) OCTUser *user;

@property (nonatomic, assign, readwrite) MRCUserListViewModelType type;
@property (nonatomic, assign, readwrite) BOOL isCurrentUser;
@property (nonatomic, copy, readwrite) NSArray *users;

@property (nonatomic, strong) RACCommand *operationCommand;

@end

@implementation MRCUserListViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.user = params[@"user"] ?: [OCTUser mrc_currentUser];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
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
        MRCUserListItemViewModel *itemViewModel = self.dataSource[indexPath.section][indexPath.row];
        
        MRCUserDetailViewModel *viewModel = [[MRCUserDetailViewModel alloc] initWithServices:self.services
                                                                                      params:@{ @"user": itemViewModel.user }];
        [self.services pushViewModel:viewModel animated:YES];
       
        return [RACSignal empty];
    }];
    
    self.operationCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(MRCUserListItemViewModel *viewModel) {
        @strongify(self)
        if (viewModel.user.followingStatus == OCTUserFollowingStatusYES) {
            return [[self.services client] mrc_unfollowUser:viewModel.user];
        } else if (viewModel.user.followingStatus == OCTUserFollowingStatusNO) {
            return [[self.services client] mrc_followUser:viewModel.user];
        }
        return [RACSignal empty];
    }];

    self.operationCommand.allowsConcurrentExecution = YES;
    
    RACSignal *fetchLocalDataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        if (self.isCurrentUser) {
            if (self.type == MRCUserListViewModelTypeFollowers) {
                [subscriber sendNext:[OCTUser mrc_fetchFollowersWithPage:1 perPage:self.perPage]];
            } else if (self.type == MRCUserListViewModelTypeFollowing) {
                [subscriber sendNext:[OCTUser mrc_fetchFollowingWithPage:1 perPage:self.perPage]];
            }
        }
        return nil;
    }];
    
    RACSignal *requestRemoteDataSignal = self.requestRemoteDataCommand.executionSignals.switchToLatest;
    
    RAC(self, users) = [fetchLocalDataSignal merge:requestRemoteDataSignal];
    
    RAC(self, dataSource) = [RACObserve(self, users) map:^(NSArray *users) {
        @strongify(self)
        return [self dataSourceWithUsers:users];
    }];
}

- (BOOL)isCurrentUser {
    return [self.user.objectID isEqualToString:[OCTUser mrc_currentUserId]];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    NSArray * (^mapFollowingStatus)(NSArray *) = ^(NSArray *users) {
        if (page == 1) {
            for (OCTUser *user in users) {
                if (user.followingStatus == OCTUserFollowingStatusYES) continue;
                
                for (OCTUser *preUser in self.users) {
                    if ([user.objectID isEqualToString:preUser.objectID]) {
                        user.followingStatus = preUser.followingStatus;
                        break;
                    }
                }
            }
        } else {
            users = @[ (self.users ?: @[]).rac_sequence, users.rac_sequence ].rac_sequence.flatten.array;
        }
        return users;
    };
    
    if (self.type == MRCUserListViewModelTypeFollowers) {
        return [[[[[[[self.services
        	client]
            fetchFollowersForUser:self.user offset:[self offsetForPage:page] perPage:self.perPage]
            take:self.perPage]
            collect]
        	map:^(NSArray *users) {
                for (OCTUser *user in users) {
                    if (self.isCurrentUser) user.followerStatus = OCTUserFollowerStatusYES;
                }
                return users;
            }]
        	map:mapFollowingStatus]
        	doNext:^(NSArray *users) {
                if (self.isCurrentUser) {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [OCTUser mrc_saveOrUpdateUsers:users];
                        [OCTUser mrc_saveOrUpdateFollowerStatusWithUsers:users];
                    });
                }
            }];
    } else if (self.type == MRCUserListViewModelTypeFollowing) {
        return [[[[[[[self.services
            client]
            fetchFollowingForUser:self.user offset:[self offsetForPage:page] perPage:self.perPage]
        	take:self.perPage]
            collect]
            map:^(NSArray *users) {
                for (OCTUser *user in users) {
                    if (self.isCurrentUser) user.followingStatus = OCTUserFollowingStatusYES;
                }
                return users;
            }]
        	map:mapFollowingStatus]
        	doNext:^(NSArray *users) {
                if (self.isCurrentUser) {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [OCTUser mrc_saveOrUpdateUsers:users];
                        [OCTUser mrc_saveOrUpdateFollowingStatusWithUsers:users];
                    });
                }
            }];
    }
    return [RACSignal empty];
}

- (NSArray *)dataSourceWithUsers:(NSArray *)users {
    if (users.count == 0) return nil;
    
    @weakify(self)
    NSArray *viewModels = [users.rac_sequence map:^(OCTUser *user) {
        @strongify(self)
        MRCUserListItemViewModel *viewModel = [[MRCUserListItemViewModel alloc] initWithUser:user];
        
        if (user.followingStatus == OCTUserFollowingStatusUnknown) {
            [[[self.services
                client]
                doesFollowUser:user]
                subscribeNext:^(NSNumber *isFollowing) {
                    if (isFollowing.boolValue) {
                        user.followingStatus = OCTUserFollowingStatusYES;
                    } else {
                        user.followingStatus = OCTUserFollowingStatusNO;
                    }
             }];
        }
        viewModel.operationCommand = self.operationCommand;
        
        return viewModel;
    }].array;
    
    return @[ viewModels ];
}

@end
