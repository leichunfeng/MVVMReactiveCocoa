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
        
        MRCUserDetailViewModel *viewModel = [[MRCUserDetailViewModel alloc] initWithServices:self.services params:@{ @"user": itemViewModel.user }];
        [self.services pushViewModel:viewModel animated:YES];
       
        return [RACSignal empty];
    }];
    
    RACCommand *operationCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(MRCUserListItemViewModel *viewModel) {
        if (viewModel.followingStatus == OCTUserFollowingStatusYES) {
            return [[self.services client] followUser:viewModel.user];
        } else if (viewModel.followingStatus == OCTUserFollowingStatusNO) {
            return [[self.services client] unfollowUser:viewModel.user];
        }
        return [RACSignal empty];
    }];
    operationCommand.allowsConcurrentExecution = YES;
    
    [[RACObserve(self, users)
        ignore:nil]
        subscribeNext:^(NSArray *users) {
            @strongify(self)
            self.dataSource = @[ [users.rac_sequence map:^(OCTUser *user) {
                @strongify(self)

                MRCUserListItemViewModel *viewModel = [[MRCUserListItemViewModel alloc] initWithUser:user];
                
                if (user.followingStatus == OCTUserFollowingStatusUnknown) {
                    @weakify(viewModel)
                    [[[[self.services
                        client]
                        hasFollowUser:user]
                     	takeUntil:viewModel.rac_willDeallocSignal]
                        subscribeNext:^(NSNumber *isFollowing) {
                            @strongify(viewModel)
                            if (isFollowing.boolValue) {
                                user.followingStatus = OCTUserFollowingStatusYES;
                                viewModel.followingStatus = OCTUserFollowingStatusYES;
                            } else {
                                user.followingStatus = OCTUserFollowingStatusNO;
                                viewModel.followingStatus = OCTUserFollowingStatusNO;
                            }
                        }];
                }
                
                viewModel.operationCommand = operationCommand;
                
                return viewModel;
            }].array ];
        }];

    if (self.isCurrentUser) {
        if (self.type == MRCUserListViewModelTypeFollowers) {
            self.users = [OCTUser mrc_fetchFollowersWithPage:1 perPage:self.perPage];
        } else if (self.type == MRCUserListViewModelTypeFollowing) {
            self.users = [OCTUser mrc_fetchFollowingWithPage:1 perPage:self.perPage];
        }
    }
}

- (BOOL)isCurrentUser {
    return [self.user.objectID isEqualToString:[OCTUser mrc_currentUserId]];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    if (self.type == MRCUserListViewModelTypeFollowers) {
        return [[[[self.services
        	client]
            fetchFollowersWithUser:self.user page:page perPage:self.perPage]
            collect]
        	doNext:^(NSArray *users) {
                if (users != nil && users.count > 0) {
                    for (OCTUser *user in users) {
                        if (self.isCurrentUser) user.followerStatus = OCTUserFollowerStatusYES;
                    }
                    
                    if (page == 1) {
                        for (OCTUser *user in users) {
                            for (OCTUser *preUser in self.users) {
                                if ([user.objectID isEqualToString:preUser.objectID]) {
                                    user.followingStatus = preUser.followingStatus;
                                    break;
                                }
                            }
                        }
                        self.users = users;
                    } else {
                        self.users = @[ (self.users ?: @[]).rac_sequence, users.rac_sequence ].rac_sequence.flatten.array;
                    }
                    
                    if (self.isCurrentUser) {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            [OCTUser mrc_saveOrUpdateUsers:self.users];
                            [OCTUser mrc_saveOrUpdateFollowerStatusWithUsers:self.users];
                        });
                    }
                }
            }];
    } else if (self.type == MRCUserListViewModelTypeFollowing) {
        return [[[[self.services
            client]
            fetchFollowingWithUser:self.user page:page perPage:self.perPage]
            collect]
            doNext:^(NSArray *users) {
                if (users != nil && users.count > 0) {
                    for (OCTUser *user in users) {
                        if (self.isCurrentUser) user.followingStatus = OCTUserFollowingStatusYES;
                    }
                    
                    if (page == 1) {
                        self.users = users;
                    } else {
                        self.users = @[ (self.users ?: @[]).rac_sequence, users.rac_sequence ].rac_sequence.flatten.array;
                    }
                    
                    if (self.isCurrentUser) {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            [OCTUser mrc_saveOrUpdateUsers:self.users];
                            [OCTUser mrc_saveOrUpdateFollowingStatusWithUsers:self.users];
                        });
                    }
                }
            }];
    }
    return [RACSignal empty];
}

@end
