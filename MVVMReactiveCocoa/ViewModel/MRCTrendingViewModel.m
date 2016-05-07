//
//  MRCTrendingViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/10/20.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import "MRCTrendingViewModel.h"

@implementation MRCTrendingViewModel

- (void)initialize {
    [super initialize];

    self.shouldRequestRemoteDataOnViewDidLoad = NO;
    self.requestRemoteDataCommand.allowsConcurrentExecution = YES;

    RACSignal *sinceSignal = [[RACObserve(self, since)
        map:^(NSDictionary *since) {
            return since[@"slug"];
        }]
        distinctUntilChanged];

    RACSignal *languageSignal = [[RACObserve(self, language)
        map:^(NSDictionary *language) {
            return language[@"slug"];
        }]
        distinctUntilChanged];
    
    @weakify(self)
    [[[RACSignal
        combineLatest:@[ sinceSignal, languageSignal ]]
        doNext:^(id x) {
            @strongify(self)
            self.dataSource = nil;
        }]
        subscribeNext:^(id x) {
            @strongify(self)
            [self.requestRemoteDataCommand execute:nil];
        }];
}

- (MRCReposViewModelType)type {
    return MRCReposViewModelTypeTrending;
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

- (id)fetchLocalData {
    return nil;
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    return [[self.services repositoryService] requestTrendingRepositoriesSince:self.since[@"slug"] language:self.language[@"slug"]];
}

@end
