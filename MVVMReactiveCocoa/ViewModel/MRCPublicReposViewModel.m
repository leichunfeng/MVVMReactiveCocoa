//
//  MRCPublicReposViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/19.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCPublicReposViewModel.h"

@implementation MRCPublicReposViewModel

- (void)initialize {
    [super initialize];
    
    self.title = @"Public Repos";
}

- (MRCReposViewModelType)type {
    return MRCReposViewModelTypePublic;
}

- (MRCReposViewModelOptions)options {
    MRCReposViewModelOptions options = 0;
    
    if (self.isCurrentUser) {
//        options = options | MRCReposViewModelOptionsFetchLocalDataOnInitialize;
//        options = options | MRCReposViewModelOptionsObserveStarredReposChange;
        options = options | MRCReposViewModelOptionsSaveOrUpdateRepos;
//        options = options | MRCReposViewModelOptionsSaveOrUpdateStarredStatus;
        options = options | MRCReposViewModelOptionsPagination;
//        options = options | MRCReposViewModelOptionsSectionIndex;
//        options = options | MRCReposViewModelOptionsShowOwnerLogin;
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
    return [OCTRepository mrc_fetchUserPublicRepositoriesWithPage:1 perPage:self.perPage];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    @weakify(self)
    return [[[self.services
    	client]
    	fetchRepositoriesWithUser:self.user page:page perPage:self.perPage].collect
    	map:^(NSArray *repositories) {
            @strongify(self)
            if (page != 1) {
                repositories = @[ (self.repositories ?: @[]).rac_sequence, repositories.rac_sequence ].rac_sequence.flatten.array;
            }
            return repositories;
        }];
}

@end
