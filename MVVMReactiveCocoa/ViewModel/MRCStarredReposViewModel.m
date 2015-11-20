//
//  MRCStarredReposViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCStarredReposViewModel.h"

@interface MRCStarredReposViewModel ()

@property (nonatomic, assign, readwrite) MRCStarredReposViewModelEntryPoint entryPoint;

@end

@implementation MRCStarredReposViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(NSDictionary *)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.entryPoint = [params[@"entryPoint"] unsignedIntegerValue];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.title = @"Starred Repos";
}

- (MRCReposViewModelType)type {
    return MRCReposViewModelTypeStarred;
}

- (MRCReposViewModelOptions)options {
    MRCReposViewModelOptions options = 0;
    
    if (self.isCurrentUser && self.entryPoint == MRCStarredReposViewModelEntryPointHomepage) {
        options = options | MRCReposViewModelOptionsObserveStarredReposChange;
    }
    
    if (self.isCurrentUser) {
        options = options | MRCReposViewModelOptionsSaveOrUpdateRepos;
    }
    
    if (self.isCurrentUser && self.entryPoint == MRCStarredReposViewModelEntryPointHomepage) {
        options = options | MRCReposViewModelOptionsSaveOrUpdateStarredStatus;
    }
    
    if ((self.isCurrentUser && self.entryPoint == MRCStarredReposViewModelEntryPointUserDetail) || !self.isCurrentUser) {
        options = options | MRCReposViewModelOptionsPagination;
    }
    
    if (self.isCurrentUser && self.entryPoint == MRCStarredReposViewModelEntryPointHomepage) {
        options = options | MRCReposViewModelOptionsSectionIndex;
    }
    
    options = options | MRCReposViewModelOptionsShowOwnerLogin;
    
    if (!self.isCurrentUser) {
        options = options | MRCReposViewModelOptionsMarkStarredStatus;
    }
    
    return options;
}

- (NSArray *)fetchLocalData {
    if (self.isCurrentUser) {
        if (self.entryPoint == MRCStarredReposViewModelEntryPointHomepage) {
            return [OCTRepository mrc_fetchUserStarredRepositoriesWithKeyword:self.keyword];
        } else if (self.entryPoint == MRCStarredReposViewModelEntryPointUserDetail) {
            return [OCTRepository mrc_fetchUserStarredRepositoriesWithPage:self.page perPage:self.perPage];
        }
    }
    return nil;
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    if (self.isCurrentUser && self.entryPoint == MRCStarredReposViewModelEntryPointHomepage) {
        return [[[[self.services
            client]
            fetchUserStarredRepositories]
        	collect]
            map:^(NSArray *repositories) {
                for (OCTRepository *repo in repositories) {
                    repo.starredStatus = OCTRepositoryStarredStatusYES;
                }
                return repositories;
            }];
    } else {
        return [[[[[[self.services
        	client]
            fetchStarredRepositoriesForUser:self.user offset:[self offsetForPage:page] perPage:self.perPage]
        	take:self.perPage]
            collect]
            doNext:^(NSArray *repositories) {
                if (self.isCurrentUser) {
                    for (OCTRepository *repo in repositories) {
                        repo.starredStatus = OCTRepositoryStarredStatusYES;
                    }
                }
            }]
        	map:^(NSArray *repositories) {
                if (page != 1) {
                    repositories = @[ (self.repositories ?: @[]).rac_sequence, repositories.rac_sequence ].rac_sequence.flatten.array;
                }
                return repositories;
            }];
    }
}

@end
