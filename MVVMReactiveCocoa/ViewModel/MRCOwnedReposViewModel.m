//
//  MRCOwnedReposViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCOwnedReposViewModel.h"
#import "MRCReposItemViewModel.h"
#import "MRCRepoDetailViewModel.h"

@implementation MRCOwnedReposViewModel

- (void)initialize {
    [super initialize];
    
    self.shouldPullToRefresh = YES;

    @weakify(self)
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self)
        OCTRepository *repository = [self.dataSource[indexPath.section][indexPath.row] repository];

        MRCRepoDetailViewModel *detailViewModel = [[MRCRepoDetailViewModel alloc] initWithServices:self.services
                                                                                            params:@{ @"repository": repository }];
        [self.services pushViewModel:detailViewModel animated:YES];
        
        return [RACSignal empty];
    }];
    
    [RACObserve(self, repositories) subscribeNext:^(NSArray *repositories) {
        @strongify(self)
        self.sectionIndexTitles = [self sectionIndexTitlesWithRepositories:repositories];
        self.dataSource = [self dataSourceWithRepositories:repositories];
    }];
    
    self.repositories = [self fetchLocalRepositories];
}

- (NSArray *)fetchLocalRepositories {
    return [OCTRepository mrc_fetchUserRepositoriesWithPage:0 perPage:0];
}

- (RACSignal *)requestRemoteDataSignal {
    return [[[self.services
        client]
        fetchUserRepositories].collect
        doNext:^(NSArray *repositories) {
            self.repositories = [repositories sortedArrayUsingComparator:^NSComparisonResult(OCTRepository *repo1, OCTRepository *repo2) {
                return [repo1.name caseInsensitiveCompare:repo2.name];
            }];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [OCTRepository mrc_saveOrUpdateRepositories:repositories];
            });
        }];
}

- (NSArray *)sectionIndexTitlesWithRepositories:(NSArray *)repositories {
    if (!repositories) return nil;
    
    NSArray *firstLetters = [repositories.rac_sequence
    	map:^id(OCTRepository *repository) {
            return repository.name.firstLetter;
        }].array;
    
    return [[NSSet setWithArray:firstLetters].rac_sequence.array sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
}

- (NSArray *)dataSourceWithRepositories:(NSArray *)repositories {
    if (!repositories) return nil;
    
    NSMutableArray *repoOfRepos = [NSMutableArray new];
    
    NSString *firstLetter = [repositories.firstObject name].firstLetter;
    NSMutableArray *repos = [NSMutableArray new];
    
    for (OCTRepository *repository in repositories) {
        if ([[repository.name firstLetter] isEqualToString:firstLetter]) {
            [repos addObject:[[MRCReposItemViewModel alloc] initWithRepository:repository]];
        } else {
            [repoOfRepos addObject:repos];
            
            firstLetter = repository.name.firstLetter;
            repos = [NSMutableArray new];
            
            [repos addObject:[[MRCReposItemViewModel alloc] initWithRepository:repository]];
        }
    }
    [repoOfRepos addObject:repos];
    
    return repoOfRepos;
}

@end
