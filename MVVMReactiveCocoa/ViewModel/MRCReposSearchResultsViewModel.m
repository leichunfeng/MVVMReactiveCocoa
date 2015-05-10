//
//  MRCReposSearchResultsViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCReposSearchResultsViewModel.h"

@implementation MRCReposSearchResultsViewModel

- (void)initialize {
    [super initialize];
    
    self.shouldPullToRefresh = NO;
}

- (NSArray *)fetchLocalRepositories {
    return nil;
}

- (RACSignal *)requestRemoteDataSignal {
    if (self.query.length == 0) return [RACSignal empty];
    
    return [[[self.services
        client]
        searchRepositoriesWithQuery:self.query sort:nil order:nil]
        doNext:^(OCTRepositoriesSearchResult *searchResult) {
            self.repositories = searchResult.repositories;
        }];
}

- (NSArray *)sectionIndexTitlesWithRepositories:(NSArray *)repositories {
    return nil;
}

@end
