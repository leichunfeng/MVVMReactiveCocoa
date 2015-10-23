//
//  MRCTrendingViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/10/20.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import "MRCTrendingViewModel.h"

@interface MRCTrendingViewModel ()

@property (nonatomic, strong) RACSignal *optionsSignal;

@end

@implementation MRCTrendingViewModel

- (void)initialize {
    [super initialize];

    self.shouldRequestRemoteDataOnViewDidLoad = NO;
    self.requestRemoteDataCommand.allowsConcurrentExecution = YES;

    NSDictionary *since    = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"since"];
    NSDictionary *language = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"language"];

    self.since    = since ?: MRCTrendingSinces().firstObject;
    self.language = language ?: MRCTrendingLanguages().firstObject;

    self.titleViewType = MRCTitleViewTypeDoubleTitle;

    RAC(self, title) = [RACObserve(self, language) map:^(NSDictionary *language) {
        return language[@"name"];
    }];
    
    RAC(self, subtitle) = [RACObserve(self, since) map:^(NSDictionary *since) {
        return since[@"name"];
    }];

    self.optionsSignal = [RACSignal combineLatest:@[ RACObserve(self, since).distinctUntilChanged,
                                                     RACObserve(self, language).distinctUntilChanged ]];

    @weakify(self)
    [self.optionsSignal subscribeNext:^(id x) {
        @strongify(self)
        self.dataSource = nil;
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
    return [[[self.services
        repositoryService]
        requestTrendingRepositoriesSince:self.since[@"slug"] language:self.language[@"slug"]]
        takeUntil:[self.optionsSignal skip:1]];
}

@end
