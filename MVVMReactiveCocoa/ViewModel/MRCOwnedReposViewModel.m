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
}

- (RACSignal *)fetchRepositoriesSignal {
    return [OCTRepository fetchUserRepositories];
}

- (RACSignal *)fetchLocalDataSignal {
    @weakify(self)
    return [[self
        fetchRepositoriesSignal]
    	doNext:^(NSArray *repositories) {
            @strongify(self)
            self.sectionIndexTitles = [self sectionIndexTitlesWithRepositories:repositories];
            self.dataSource = [self dataSourceWithRepositories:repositories];
        }];
}

- (RACSignal *)requestRemoteDataSignal {
    return [[[RACSignal
        combineLatest:@[ [OCTRepository fetchUserRepositories], [[self.services.client fetchUserRepositories] collect] ]]
    	flattenMap:^RACStream *(RACTuple *tuple) {
            return [OCTRepository updateLocalObjects:tuple.first withRemoteObjects:tuple.second];
        }]
    	takeUntil:self.willDisappearSignal];
}

- (NSArray *)sectionIndexTitlesWithRepositories:(NSArray *)repositories {
    NSArray *firstLetters = [repositories.rac_sequence
    	map:^id(NSDictionary *repository) {
            return [repository[@"name"] firstLetter];
        }].array;
    
    return [[NSSet setWithArray:firstLetters].rac_sequence.array sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
}

- (NSArray *)dataSourceWithRepositories:(NSArray *)repositories {
    NSMutableArray *repoOfRepos = NSMutableArray.new;
    
    NSString *firstLetter = [repositories.firstObject[@"name"] firstLetter];
    NSMutableArray *repos = NSMutableArray.new;
    
    for (NSDictionary *repository in repositories) {
        if ([[repository[@"name"] firstLetter] isEqualToString:firstLetter]) {
            [repos addObject:[[MRCReposItemViewModel alloc] initWithRepoDictionary:repository]];
        } else {
            [repoOfRepos addObject:repos];
            
            firstLetter = [repository[@"name"] firstLetter];
            repos = NSMutableArray.new;
            
            [repos addObject:[[MRCReposItemViewModel alloc] initWithRepoDictionary:repository]];
        }
    }
    [repoOfRepos addObject:repos];
    
    return repoOfRepos.copy;
}

@end
