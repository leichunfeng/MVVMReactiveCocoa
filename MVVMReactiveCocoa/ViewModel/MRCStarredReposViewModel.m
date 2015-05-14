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
    
    @weakify(self)
    RAC(self, repositories) = [[[NSNotificationCenter defaultCenter]
        rac_addObserverForName:MRCStarredReposDidChangeNotification object:nil]
        map:^id(id value) {
            @strongify(self)
            return [self fetchLocalRepositories];
        }];
}

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
            self.repositories = [repositories sortedArrayUsingComparator:^NSComparisonResult(OCTRepository *repo1, OCTRepository *repo2) {
                return [repo1.name caseInsensitiveCompare:repo2.name];
            }];
            [OCTRepository mrc_saveOrUpdateUserStarredRepositories:repositories];
        }];
}

@end
