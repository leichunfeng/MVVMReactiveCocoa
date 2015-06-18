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
    
    if (self.isCurrentUser) {
        @weakify(self)
        RAC(self, repositories) = [[[NSNotificationCenter defaultCenter]
        	rac_addObserverForName:MRCStarredReposDidChangeNotification object:nil]
            map:^id(id value) {
                @strongify(self)
                return [self fetchLocalRepositories];
            }];
    }
}

- (NSArray *)fetchLocalRepositories {
    return [OCTRepository mrc_fetchUserStarredRepositoriesWithPage:0 perPage:0];
}

- (RACSignal *)requestRemoteDataSignalWithCurrentPage:(NSUInteger)currentPage {
    if (self.isCurrentUser) {
        return [[[[self.services
        	client]
        	fetchUserStarredRepositories]
            collect]
            doNext:^(NSArray *repositories) {
                for (OCTRepository *repo in repositories) {
                    repo.starredStatus = OCTRepositoryStarredStatusYES;
                }
                self.repositories = [repositories sortedArrayUsingComparator:^NSComparisonResult(OCTRepository *repo1, OCTRepository *repo2) {
                    return [repo1.name caseInsensitiveCompare:repo2.name];
                }];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [OCTRepository mrc_saveOrUpdateRepositories:repositories];
                    [OCTRepository mrc_saveOrUpdateStarredStatusWithRepositories:repositories];
                });
            }];
    } else {
        return [[[[self.services
        	client]
        	fetchStarredRepositoriesWithUser:self.user page:currentPage perPage:self.pageSize]
        	collect]
        	doNext:^(NSArray *repositories) {
                if (currentPage == 1) {
                    self.repositories = repositories;
                } else {
                    self.repositories = @[ (self.repositories ?: @[]).rac_sequence, repositories.rac_sequence ].rac_sequence.flatten.array;
                }
            }];
    }
}

@end
