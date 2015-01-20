//
//  MRCStarredReposViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCStarredReposViewModel.h"

@implementation MRCStarredReposViewModel

- (RACSignal *)fetchRepositoriesSignal {
    return [OCTRepository fetchUserStarredRepositories];
}

- (RACSignal *)requestRemoteDataSignal {
    return [[self.services.client
    	fetchUserStarredRepositories]
    	doNext:^(OCTRepository *repository) {
            [repository setStarred:YES];
            [repository save];
        }];
}

@end
