//
//  MRCOwnedReposViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCOwnedReposViewModel.h"
#import "MRCRepoDetailViewModel.h"
#import "MRCReposItemViewModel.h"

@interface MRCOwnedReposViewModel ()

@property (nonatomic, strong, readwrite) OCTUser *user;
@property (nonatomic, assign, readwrite) BOOL isCurrentUser;
@property (nonatomic, copy, readwrite) NSArray *repositories;

@end

@implementation MRCOwnedReposViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(NSDictionary *)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.user = params[@"user"] ?: [OCTUser mrc_currentUser];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.shouldPullToRefresh = YES;
    self.shouldInfiniteScrolling = self.options & MRCReposViewModelOptionsPagination;

    @weakify(self)
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^(NSIndexPath *indexPath) {
        @strongify(self)
        OCTRepository *repository = [self.dataSource[indexPath.section][indexPath.row] repository];

        MRCRepoDetailViewModel *detailViewModel = [[MRCRepoDetailViewModel alloc] initWithServices:self.services
                                                                                            params:@{ @"repository": repository }];
        [self.services pushViewModel:detailViewModel animated:YES];
        
        return [RACSignal empty];
    }];
    
    RACSignal *starredReposDidChangeSignal = [[[NSNotificationCenter defaultCenter]
        rac_addObserverForName:MRCStarredReposDidChangeNotification object:nil]
        filter:^(id value) {
           @strongify(self)
           return @(self.options & MRCReposViewModelOptionsObserveStarredReposChange).boolValue;
        }];

    RACSignal *keywordSignal = [[RACObserve(self, keyword)
        skip:1]
        throttle:0.5];

    // Represents the future value
    RACSignal *futureSignal = [starredReposDidChangeSignal merge:keywordSignal];

    // The nil as the initial value
    RACSignal *fetchLocalDataSignal = [[futureSignal
    	startWith:nil]
        map:^(id value) {
            @strongify(self)
            return [self fetchLocalData];
        }];
    
    RACSignal *requestRemoteDataSignal = [[self.requestRemoteDataCommand.executionSignals.switchToLatest
    	doNext:^(NSArray *repositories) {
            @strongify(self)
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                if (self.options & MRCReposViewModelOptionsSaveOrUpdateRepos) {
                    [OCTRepository mrc_saveOrUpdateRepositories:repositories];
                }
                if (self.options & MRCReposViewModelOptionsSaveOrUpdateStarredStatus) {
                    [OCTRepository mrc_saveOrUpdateStarredStatusWithRepositories:repositories];
                }
            });
        }]
        map:^(NSArray *repositories) {
        	@strongify(self)
        	if (self.options & MRCReposViewModelOptionsSectionIndex) {
            	repositories = [repositories sortedArrayUsingComparator:^(OCTRepository *repo1, OCTRepository *repo2) {
                	return [repo1.name caseInsensitiveCompare:repo2.name];
            	}];
            }
            return repositories;
        }];
    
    RAC(self, repositories) = [fetchLocalDataSignal merge:requestRemoteDataSignal];
    
    RAC(self, dataSource) = [[[RACObserve(self, repositories)
		map:^(NSArray *repositories) {
            return [OCTRepository mrc_matchStarredStatusForRepositories:repositories];
        }]
    	doNext:^(NSArray *repositories) {
            @strongify(self)
            self.sectionIndexTitles = [self sectionIndexTitlesWithRepositories:repositories];
        }]
    	flattenMap:^(NSArray *repositories) {
            @strongify(self)
            return [self dataSourceSignalWithRepositories:repositories];
        }];
}

- (BOOL)isCurrentUser {
    return [self.user.objectID isEqualToString:[OCTUser mrc_currentUserId]];
}

- (MRCReposViewModelType)type {
    return MRCReposViewModelTypeOwned;
}

- (MRCReposViewModelOptions)options {
    MRCReposViewModelOptions options = 0;
    
    options = options | MRCReposViewModelOptionsObserveStarredReposChange;
    options = options | MRCReposViewModelOptionsSaveOrUpdateRepos;
//    options = options | MRCReposViewModelOptionsSaveOrUpdateStarredStatus;
//    options = options | MRCReposViewModelOptionsPagination;
    options = options | MRCReposViewModelOptionsSectionIndex;
//    options = options | MRCReposViewModelOptionsShowOwnerLogin;
//    options = options | MRCReposViewModelOptionsMarkStarredStatus;
    
    return options;
}

- (NSArray *)fetchLocalData {
    return [OCTRepository mrc_fetchUserRepositoriesWithKeyword:self.keyword];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    return [[[self.services
    	client]
        fetchUserRepositories]
    	collect];
}

- (NSArray *)sectionIndexTitlesWithRepositories:(NSArray *)repositories {
    if (repositories.count == 0) return nil;
    
    if (self.options & MRCReposViewModelOptionsSectionIndex) {
        NSArray *firstLetters = [repositories.rac_sequence map:^(OCTRepository *repository) {
            return repository.name.firstLetter;
        }].array;
        
        return [[NSSet setWithArray:firstLetters].rac_sequence.array sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    }
    
    return nil;
}

- (RACSignal *)dataSourceSignalWithRepositories:(NSArray *)repositories {
    if (repositories.count == 0) return [RACSignal empty];
    
    if (self.options & MRCReposViewModelOptionsSectionIndex) {
        return [[[repositories.rac_sequence.signal
            groupBy:^(OCTRepository *repository) {
                return repository.name.firstLetter;
            }]
            flattenMap:^(RACSignal *signal) {
                return [[signal
                    map:^(OCTRepository *repository) {
                        return [[MRCReposItemViewModel alloc] initWithRepository:repository options:self.options];
                    }]
                    collect];
            }]
            collect];
    } else {
        NSArray *viewModels = [repositories.rac_sequence map:^(OCTRepository *repository) {
            return [[MRCReposItemViewModel alloc] initWithRepository:repository options:self.options];
        }].array;
        return [RACSignal return:@[ viewModels ]];
    }
}

@end
