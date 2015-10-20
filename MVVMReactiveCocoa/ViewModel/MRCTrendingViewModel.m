//
//  MRCTrendingViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/10/20.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import "MRCTrendingViewModel.h"

@interface MRCTrendingViewModel ()

@property (nonatomic, copy) NSString *since;
@property (nonatomic, copy) NSString *language;

@end

@implementation MRCTrendingViewModel

- (void)initialize {
    [super initialize];
    
    self.since = @"weekly";
    self.language = @"Objective-C";
    
    self.titleViewType = MRCTitleViewTypeDoubleTitle;
    
    RAC(self, title)    = RACObserve(self, language);
    RAC(self, subtitle) = RACObserve(self, since);
}

- (MRCReposViewModelType)type {
    return MRCReposViewModelTypeTrending;
}

- (MRCReposViewModelOptions)options {
    MRCReposViewModelOptions options = 0;
    
    options = options | MRCReposViewModelOptionsObserveStarredReposChange;
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
