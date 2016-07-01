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
#import "MRCCountryAndLanguageViewModel.h"

@interface MRCUserListViewModel ()

@property (nonatomic, strong) OCTUser *user;

@property (nonatomic, assign, readwrite) MRCUserListViewModelType type;
@property (nonatomic, assign, readwrite) BOOL isCurrentUser;
@property (nonatomic, copy, readwrite) NSArray *users;

@property (nonatomic, strong) RACCommand *operationCommand;

@property (nonatomic, strong, readwrite) RACCommand *rightBarButtonItemCommand;

@end

@implementation MRCUserListViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(NSDictionary *)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.user = params[@"user"] ?: [OCTUser mrc_currentUser];
    }
    return self;
}

- (void)initialize {
    [super initialize];

    self.type = [self.params[@"type"] unsignedIntegerValue];
    
    @weakify(self)
    if (self.type == MRCUserListViewModelTypeFollowers) {
        self.title = @"Followers";
    } else if (self.type == MRCUserListViewModelTypeFollowing) {
        self.title = @"Following";
    } else if (self.type == MRCUserListViewModelTypePopularUsers) {
        self.titleViewType = MRCTitleViewTypeDoubleTitle;
        
        NSDictionary *country  = (NSDictionary *)[[YYCache sharedCache] objectForKey:MRCPopularUsersCountryCacheKey];
        NSDictionary *language = (NSDictionary *)[[YYCache sharedCache] objectForKey:MRCPopularUsersLanguageCacheKey];
        
        self.country = country ?: @{
            @"name": @"All Countries",
            @"slug": @"",
        };
        
        self.language = language ?: @{
            @"name": @"All Languages",
            @"slug": @"",
        };

        RAC(self, title) = [RACObserve(self, country) map:^(NSDictionary *country) {
            return country[@"name"];
        }];
        
        RAC(self, subtitle) = [RACObserve(self, language) map:^(NSDictionary *language) {
            return language[@"name"];
        }];
        
        self.rightBarButtonItemCommand = [[RACCommand alloc] initWithSignalBlock:^(id input) {
            @strongify(self)

            MRCCountryAndLanguageViewModel *viewModel = [[MRCCountryAndLanguageViewModel alloc] initWithServices:self.services
                                                                                                          params:@{ @"country": self.country ?: @{},
                                                                                                                    @"language": self.language ?: @{} }];
            [self.services pushViewModel:viewModel animated:YES];

            viewModel.callback = ^(NSDictionary *output) {
                @strongify(self)
                
                self.country  = output[@"country"];
                self.language = output[@"language"];
                
                [[YYCache sharedCache] setObject:output[@"country"] forKey:MRCPopularUsersCountryCacheKey withBlock:NULL];
                [[YYCache sharedCache] setObject:output[@"language"] forKey:MRCPopularUsersLanguageCacheKey withBlock:NULL];
            };

            return [RACSignal empty];
        }];
        
        self.requestRemoteDataCommand.allowsConcurrentExecution = YES;
    }

    self.shouldPullToRefresh = YES;
    self.shouldInfiniteScrolling = self.type != MRCUserListViewModelTypePopularUsers;

    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^(NSIndexPath *indexPath) {
        @strongify(self)
        MRCUserListItemViewModel *itemViewModel = self.dataSource[indexPath.section][indexPath.row];

        MRCUserDetailViewModel *viewModel = [[MRCUserDetailViewModel alloc] initWithServices:self.services
                                                                                      params:@{ @"user": itemViewModel.user }];
        [self.services pushViewModel:viewModel animated:YES];

        return [RACSignal empty];
    }];

    self.operationCommand = [[RACCommand alloc] initWithSignalBlock:^(MRCUserListItemViewModel *viewModel) {
        @strongify(self)
        if (viewModel.user.followingStatus == OCTUserFollowingStatusYES) {
            return [[self.services client] mrc_unfollowUser:viewModel.user];
        } else if (viewModel.user.followingStatus == OCTUserFollowingStatusNO) {
            return [[self.services client] mrc_followUser:viewModel.user];
        }
        return [RACSignal empty];
    }];

    self.operationCommand.allowsConcurrentExecution = YES;

    RACSignal *fetchLocalDataSignal = [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        @strongify(self)
        if (self.isCurrentUser) {
            if (self.type == MRCUserListViewModelTypeFollowers) {
                [subscriber sendNext:[OCTUser mrc_fetchFollowersWithPage:1 perPage:self.perPage]];
            } else if (self.type == MRCUserListViewModelTypeFollowing) {
                [subscriber sendNext:[OCTUser mrc_fetchFollowingWithPage:1 perPage:self.perPage]];
            }
        }
        return (RACDisposable *)nil;
    }];

    RACSignal *requestRemoteDataSignal = self.requestRemoteDataCommand.executionSignals.switchToLatest;

    RAC(self, users) = [fetchLocalDataSignal merge:requestRemoteDataSignal];

    RAC(self, dataSource) = [RACObserve(self, users) map:^(NSArray *users) {
        @strongify(self)
        return [self dataSourceWithUsers:users];
    }];
    
    if (self.type == MRCUserListViewModelTypePopularUsers) {
        self.shouldRequestRemoteDataOnViewDidLoad = NO;
        
        [[[[RACSignal
            zip:@[ RACObserve(self, country), RACObserve(self, language) ]
            reduce:^(NSDictionary *country, NSDictionary *language) {
                return [NSString stringWithFormat:@"%@:%@", country[@"slug"], language[@"slug"]];
            }]
            distinctUntilChanged]
            doNext:^(id x) {
                @strongify(self)
                self.dataSource = nil;
            }]
            subscribeNext:^(id x) {
                @strongify(self)
                [self.requestRemoteDataCommand execute:@1];
            }];
    }
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
        return [[[[[[[self.services client]
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
        return [[[[[[[self.services client]
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
    } else if (self.type == MRCUserListViewModelTypePopularUsers) {
        return [[[self.services client]
            fetchPopularUsersWithLocation:self.country[@"slug"] language:self.language[@"slug"]]
            map:mapFollowingStatus];
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

        if (![user.objectID isEqualToString:[OCTUser mrc_currentUserId]]) { // Exclude myself
            viewModel.operationCommand = self.operationCommand;
        }

        return viewModel;
    }].array;

    return @[ viewModels ?: @[] ];
}

@end
