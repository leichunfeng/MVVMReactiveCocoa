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
    
    NSString *since    = [[NSUserDefaults standardUserDefaults] stringForKey:@"since"];
    NSString *language = [[NSUserDefaults standardUserDefaults] stringForKey:@"language"];
    
    self.since    = since ?: @"Today";
    self.language = language ?: @"All languages";
    
    self.titleViewType = MRCTitleViewTypeDoubleTitle;
    
    RAC(self, title)    = RACObserve(self, language);
    RAC(self, subtitle) = RACObserve(self, since);
    
    @weakify(self)
    [[[RACSignal
    	combineLatest:@[
            RACObserve(self, since).distinctUntilChanged,
            RACObserve(self, language).distinctUntilChanged
        ]]
      	skip:1]
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
    return [[self.services
		repositoryService]
        requestTrendingRepositoriesSince:self.since language:self.language];
}

@end
