//
//  MRCStarredReposViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCStarredReposViewModel.h"

@implementation MRCStarredReposViewModel

- (NSArray *)fetchLocalRepositories {
    return [OCTRepository mrc_fetchUserStarredRepositories];
}

- (RACSignal *)requestRemoteDataSignal {
    return [[[self.services
        client]
        fetchUserStarredRepositories].collect
        doNext:^(NSArray *repositories) {
            for (OCTRepository *repo in repositories) {
                repo.isStarred = YES;
            }
            [OCTRepository mrc_saveOrUpdateUserStarredRepositories:repositories];
        }];
}

@end
