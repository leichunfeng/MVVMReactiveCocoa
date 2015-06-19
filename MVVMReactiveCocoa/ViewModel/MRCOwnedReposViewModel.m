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

@interface MRCOwnedReposViewModel ()

@property (strong, nonatomic, readwrite) OCTUser *user;
@property (assign, nonatomic, readwrite) BOOL isCurrentUser;

@end

@implementation MRCOwnedReposViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.user = params[@"user"] ?: [OCTUser mrc_currentUser];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.isCurrentUser = [self.user.objectID isEqualToString:[OCTUser mrc_currentUserId]];
    
    self.shouldPullToRefresh = YES;
    self.shouldInfiniteScrolling = !self.isCurrentUser;

    @weakify(self)
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self)
        OCTRepository *repository = [self.dataSource[indexPath.section][indexPath.row] repository];

        MRCRepoDetailViewModel *detailViewModel = [[MRCRepoDetailViewModel alloc] initWithServices:self.services
                                                                                            params:@{ @"repository": repository }];
        [self.services pushViewModel:detailViewModel animated:YES];
        
        return [RACSignal empty];
    }];
    
    [[RACObserve(self, repositories)
        doNext:^(NSArray *repositories) {
            repositories = [OCTRepository matchStarredStatusForRepositories:repositories];
        }]
        subscribeNext:^(NSArray *repositories) {
            @strongify(self)
            self.sectionIndexTitles = [self sectionIndexTitlesWithRepositories:repositories];
            self.dataSource = [self dataSourceWithRepositories:repositories];
        }];
    
    if (self.isCurrentUser && self.type != MRCReposViewModelTypeSearch) {
        RAC(self, repositories) = [[[[NSNotificationCenter defaultCenter]
        	rac_addObserverForName:MRCStarredReposDidChangeNotification object:nil]
            startWith:nil]
       		map:^id(id value) {
           		@strongify(self)
           		return [self fetchLocalData];
       		}];
    }
}

- (MRCReposViewModelType)type {
    return MRCReposViewModelTypeOwned;
}

- (NSArray *)fetchLocalData {
    return [OCTRepository mrc_fetchUserRepositories];
}

- (RACSignal *)requestRemoteDataSignalWithCurrentPage:(NSUInteger)currentPage {
    if (self.isCurrentUser) {
        return [[[[self.services
        	client]
            fetchUserRepositories]
            collect]
            doNext:^(NSArray *repositories) {
                self.repositories = [repositories sortedArrayUsingComparator:^NSComparisonResult(OCTRepository *repo1, OCTRepository *repo2) {
                    return [repo1.name caseInsensitiveCompare:repo2.name];
                }];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [OCTRepository mrc_saveOrUpdateRepositories:repositories];
                });
            }];
    } else {
        return [[[[self.services
        	client]
            fetchRepositoriesWithUser:self.user page:currentPage perPage:self.pageSize]
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

- (NSArray *)sectionIndexTitlesWithRepositories:(NSArray *)repositories {
    if (repositories.count == 0) return nil;
    
    if (self.isCurrentUser) {
        NSArray *firstLetters = [repositories.rac_sequence
        	map:^id(OCTRepository *repository) {
                return repository.name.firstLetter;
            }].array;

        return [[NSSet setWithArray:firstLetters].rac_sequence.array sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    }
    
    return nil;
}

- (NSArray *)dataSourceWithRepositories:(NSArray *)repositories {
    if (repositories.count == 0) return nil;
    
    NSMutableArray *repoOfRepos = [NSMutableArray new];

    if (self.isCurrentUser) {
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
    } else {
        NSArray *repos = [repositories.rac_sequence map:^id(OCTRepository *repository) {
            return [[MRCReposItemViewModel alloc] initWithRepository:repository];
        }].array;
        [repoOfRepos addObject:repos];
    }
    
    return repoOfRepos;
}

@end
