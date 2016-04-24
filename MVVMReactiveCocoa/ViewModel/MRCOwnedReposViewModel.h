//
//  MRCOwnedReposViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCTableViewModel.h"

typedef NS_ENUM(NSUInteger, MRCReposViewModelType) {
    MRCReposViewModelTypeOwned    = 0,
    MRCReposViewModelTypeStarred  = 1,
    MRCReposViewModelTypeSearch   = 2,
    MRCReposViewModelTypePublic   = 3,
    MRCReposViewModelTypeTrending = 4,
    MRCReposViewModelTypeShowcase = 5,
    MRCReposViewModelTypePopular  = 6,
};

typedef NS_OPTIONS(NSUInteger, MRCReposViewModelOptions) {
    MRCReposViewModelOptionsObserveStarredReposChange = 1 << 0,
    MRCReposViewModelOptionsSaveOrUpdateRepos         = 1 << 1,
    MRCReposViewModelOptionsSaveOrUpdateStarredStatus = 1 << 2,
    MRCReposViewModelOptionsPagination                = 1 << 3,
    MRCReposViewModelOptionsSectionIndex              = 1 << 4,
    MRCReposViewModelOptionsShowOwnerLogin            = 1 << 5,
    MRCReposViewModelOptionsMarkStarredStatus         = 1 << 6,
};

@interface MRCOwnedReposViewModel : MRCTableViewModel

@property (nonatomic, strong, readonly) OCTUser *user;
@property (nonatomic, assign, readonly) BOOL isCurrentUser;
@property (nonatomic, copy, readonly) NSArray *repositories;

@property (nonatomic, assign, readonly) MRCReposViewModelType type;
@property (nonatomic, assign, readonly) MRCReposViewModelOptions options;

- (RACSignal *)dataSourceSignalWithRepositories:(NSArray *)repositories;

@end
