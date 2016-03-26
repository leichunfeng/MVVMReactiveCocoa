//
//  MRCReposSearchResultsViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCReposSearchResultsViewModel.h"
#import "MRCReposSearchResultsItemViewModel.h"

@implementation MRCReposSearchResultsViewModel

- (void)initialize {
    [super initialize];
    
    self.shouldPullToRefresh = NO;
    self.shouldRequestRemoteDataOnViewDidLoad = NO;
}

- (MRCReposViewModelType)type {
    return MRCReposViewModelTypeSearch;
}

- (id)fetchLocalData {
    return nil;
}

- (MRCReposViewModelOptions)options {
    MRCReposViewModelOptions options = 0;
    
//    options = options | MRCReposViewModelOptionsObserveStarredReposChange;
//    options = options | MRCReposViewModelOptionsSaveOrUpdateRepos;
//    options = options | MRCReposViewModelOptionsSaveOrUpdateStarredStatus;
//    options = options | MRCReposViewModelOptionsPagination;
//    options = options | MRCReposViewModelOptionsSectionIndex;
    options = options | MRCReposViewModelOptionsShowOwnerLogin;
    options = options | MRCReposViewModelOptionsMarkStarredStatus;
    
    return options;
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MRCSearch *search = [MRCSearch modelWithDictionary:@{ @"keyword": self.query, @"dateSearched": [NSDate date] } error:nil];
        if ([search mrc_saveOrUpdate]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:MRCRecentSearchesDidChangeNotification object:nil];
        }
    });
    
    return [[[[self.services
        client]
        searchRepositoriesWithQuery:self.query orderBy:nil ascending:NO]
        map:^(OCTRepositoriesSearchResult *searchResult) {
            return searchResult.repositories;
        }]
    	takeUntil:[RACObserve(self, query) skip:1]];
}

- (RACSignal *)dataSourceSignalWithRepositories:(NSArray *)repositories {
    if (repositories.count == 0) return [RACSignal empty];
    
    NSArray *viewModels = [repositories.rac_sequence map:^(OCTRepository *repository) {
        return [[MRCReposSearchResultsItemViewModel alloc] initWithRepository:repository options:self.options];
    }].array;
    
    return [RACSignal return:@[ viewModels ]];
}

@end
