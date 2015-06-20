//
//  MRCOwnedReposViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCTableViewModel.h"
#import "MRCReposItemViewModel.h"

typedef NS_ENUM(NSUInteger, MRCReposViewModelType) {
    MRCReposViewModelTypeOwned,
    MRCReposViewModelTypeStarred,
    MRCReposViewModelTypeSearch,
    MRCReposViewModelTypePublic
};

typedef NS_OPTIONS(NSUInteger, MRCReposViewModelOptions) {
    MRCReposViewModelOptionsFetchLocalDataOnInitialize = 1 << 0,
    MRCReposViewModelOptionsObserveStarredReposChange = 1 << 1,
    MRCReposViewModelOptionsSaveOrUpdateRepos = 1 << 2,
    MRCReposViewModelOptionsSaveOrUpdateStarredStatus = 1 << 3,
    MRCReposViewModelOptionsPagination = 1 << 4,
    MRCReposViewModelOptionsSectionIndex = 1 << 5,
};

@interface MRCOwnedReposViewModel : MRCTableViewModel

@property (strong, nonatomic, readonly) OCTUser *user;
@property (assign, nonatomic, readonly) BOOL isCurrentUser;
@property (copy, nonatomic) NSArray *repositories;

@property (assign, nonatomic, readonly) MRCReposViewModelType type;
@property (assign, nonatomic, readonly) MRCReposViewModelOptions options;
@property (assign, nonatomic, readonly) MRCReposItemViewModelOptions itemOptions;

@end
