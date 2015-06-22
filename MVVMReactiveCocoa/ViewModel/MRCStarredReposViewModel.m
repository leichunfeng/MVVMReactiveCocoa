//
//  MRCStarredReposViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCStarredReposViewModel.h"

@implementation MRCStarredReposViewModel

- (void)initialize {
    [super initialize];
    
    self.title = @"Starred Repos";
}

- (MRCReposViewModelType)type {
    return MRCReposViewModelTypeStarred;
}

- (MRCReposViewModelOptions)options {
    MRCReposViewModelOptions options = 0;
    
    if (self.isCurrentUser) {
        options = options | MRCReposViewModelOptionsFetchLocalDataOnInitialize;
        options = options | MRCReposViewModelOptionsObserveStarredReposChange;
        options = options | MRCReposViewModelOptionsSaveOrUpdateRepos;
        options = options | MRCReposViewModelOptionsSaveOrUpdateStarredStatus;
//        options = options | MRCReposViewModelOptionsPagination;
        options = options | MRCReposViewModelOptionsSectionIndex;
        options = options | MRCReposViewModelOptionsShowOwnerLogin;
//        options = options | MRCReposViewModelOptionsMarkStarredStatus;
    } else {
//        options = options | MRCReposViewModelOptionsFetchLocalDataOnInitialize;
//        options = options | MRCReposViewModelOptionsObserveStarredReposChange;
//        options = options | MRCReposViewModelOptionsSaveOrUpdateRepos;
//        options = options | MRCReposViewModelOptionsSaveOrUpdateStarredStatus;
        options = options | MRCReposViewModelOptionsPagination;
//        options = options | MRCReposViewModelOptionsSectionIndex;
        options = options | MRCReposViewModelOptionsShowOwnerLogin;
        options = options | MRCReposViewModelOptionsMarkStarredStatus;
    }
    
    return options;
}

- (NSArray *)fetchLocalData {
    return [OCTRepository mrc_fetchUserStarredRepositories];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    if (self.isCurrentUser) {
        return [[[self.services
        	client]
        	fetchUserStarredRepositories].collect
            map:^(NSArray *repositories) {
                for (OCTRepository *repo in repositories) {
                    repo.starredStatus = OCTRepositoryStarredStatusYES;
                }
                return repositories;
            }];
    } else {
        return [[[self.services
        	client]
        	fetchStarredRepositoriesForUser:self.user page:page perPage:self.perPage].collect
        	map:^(NSArray *repositories) {
                if (page != 1) {
                    repositories = @[ (self.repositories ?: @[]).rac_sequence, repositories.rac_sequence ].rac_sequence.flatten.array;
                }
                return repositories;
            }];
    }
}

@end
