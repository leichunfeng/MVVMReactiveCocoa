//
//  MRCOwnedReposViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCTableViewModel.h"

typedef NS_ENUM(NSUInteger, MRCReposViewModelType) {
    MRCReposViewModelTypeOwned,
    MRCReposViewModelTypeStarred,
    MRCReposViewModelTypeSearch,
    MRCReposViewModelTypePublic
};

typedef NS_OPTIONS(NSUInteger, MRCReposViewModelOptions) {
    MRCReposViewModelOptionsObserveStarredReposChange = 1 << 0,
    MRCReposViewModelOptionsSaveOrUpdateRepos         = 1 << 1,
    MRCReposViewModelOptionsSaveOrUpdateStarredStatus = 1 << 2,
    MRCReposViewModelOptionsPagination                = 1 << 3,
    MRCReposViewModelOptionsSectionIndex              = 1 << 4,
    MRCReposViewModelOptionsShowOwnerLogin            = 1 << 5,
    MRCReposViewModelOptionsMarkStarredStatus         = 1 << 6
};

@interface MRCOwnedReposViewModel : MRCTableViewModel

@property (strong, nonatomic, readonly) OCTUser *user;
@property (assign, nonatomic, readonly) BOOL isCurrentUser;
@property (copy, nonatomic, readonly) NSArray *repositories;

@property (assign, nonatomic, readonly) MRCReposViewModelType type;
@property (assign, nonatomic, readonly) MRCReposViewModelOptions options;

@end
