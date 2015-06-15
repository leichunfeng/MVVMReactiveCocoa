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
    self.shouldDisplayEmptyDataSet = NO;
    self.shouldRequestRemoteDataOnViewDidLoad = NO;
}

- (NSArray *)fetchLocalRepositories {
    return nil;
}

- (RACSignal *)requestRemoteDataSignal {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MRCSearch *search = [MRCSearch modelWithDictionary:@{ @"keyword": self.query, @"dateSearched": [NSDate date] } error:nil];
        if ([search mrc_saveOrUpdate]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:MRCRecentSearchesDidChangeNotification object:nil];
        }
    });
    
    return [[[self.services
        client]
        searchRepositoriesWithQuery:self.query orderBy:nil ascending:NO]
        doNext:^(OCTRepositoriesSearchResult *searchResult) {
            self.shouldDisplayEmptyDataSet = YES;
            self.repositories = searchResult.repositories;
        }];
}

- (NSArray *)sectionIndexTitlesWithRepositories:(NSArray *)repositories {
    return nil;
}

- (NSArray *)dataSourceWithRepositories:(NSArray *)repositories {
    if (!repositories) return nil;
    
    NSArray *starredRepos = [OCTRepository mrc_fetchUserStarredRepositories];
    
    NSMutableArray *repos = [NSMutableArray new];
    for (OCTRepository *repository in repositories) {
        [repos addObject:[[MRCReposSearchResultsItemViewModel alloc] initWithRepository:repository]];
        
        if (![repository.ownerLogin isEqualToString:[OCTUser mrc_currentUser].login]) {
            for (OCTRepository *starredRepo in starredRepos) {
                if ([repository.objectID isEqualToString:starredRepo.objectID]) {
                    repository.isStarred = YES;
                    break;
                }
            }
        }
    }
    
    return @[ repos ];
}

@end
