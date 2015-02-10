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
    self.shouldPullToRefresh = YES;
}

- (RACSignal *)fetchRepositoriesSignal {
    return [OCTRepository fetchUserStarredRepositories];
}

- (RACSignal *)requestRemoteDataSignal {
    return [[[[RACSignal
    	combineLatest:@[ [OCTRepository fetchUserStarredRepositories], [[self.services.client fetchUserStarredRepositories] collect] ]]
        doNext:^(RACTuple *tuple) {
            [[tuple.second rac_sequence].signal subscribeNext:^(OCTRepository *repository) {
                repository.starred = YES;
            }];
        }]
        flattenMap:^RACStream *(RACTuple *tuple) {
            return [OCTRepository updateLocalObjects:tuple.first withRemoteObjects:tuple.second];
        }]
    	takeUntil:self.willDisappearSignal];
}

@end
