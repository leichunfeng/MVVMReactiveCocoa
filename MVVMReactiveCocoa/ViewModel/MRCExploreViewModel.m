//
//  MRCExploreViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/3/26.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCExploreViewModel.h"
#import "MRCExploreCollectionViewCellViewModel.h"
#import "MRCRepoDetailViewModel.h"
#import "MRCUserDetailViewModel.h"

@interface MRCExploreViewModel ()

@property (nonatomic, copy, readwrite) NSArray *showcases;

@property (nonatomic, copy) NSArray<OCTRepository *> *trendingRepos;
@property (nonatomic, copy) NSArray<OCTRepository *> *popularRepos;
@property (nonatomic, copy) NSArray<OCTUser *> *popularUsers;

@property (nonatomic, strong, readwrite) RACCommand *requestShowcasesCommand;
@property (nonatomic, strong, readwrite) RACCommand *requestTrendingReposCommand;
@property (nonatomic, strong, readwrite) RACCommand *requestPopularReposCommand;
@property (nonatomic, strong, readwrite) RACCommand *requestPopularUsersCommand;

@property (nonatomic, strong, readwrite) MRCReposSearchResultsViewModel *searchResultsViewModel;

@end

@implementation MRCExploreViewModel

- (void)initialize {
    [super initialize];
    
    @weakify(self)
    self.requestShowcasesCommand = [[RACCommand alloc] initWithSignalBlock:^(id input) {
        @strongify(self)
        return [[self.services repositoryService] requestShowcases];
    }];
   
    self.requestTrendingReposCommand = [[RACCommand alloc] initWithSignalBlock:^(id input) {
        @strongify(self)
        return [[self.services repositoryService] requestTrendingRepositoriesSince:@"weekly" language:nil];
    }];
    
    self.requestPopularReposCommand = [[RACCommand alloc] initWithSignalBlock:^(id input) {
        @strongify(self)
        return [[self.services client] fetchPopularRepositoriesWithLanguage:nil];
    }];
    
    self.requestPopularUsersCommand = [[RACCommand alloc] initWithSignalBlock:^(id input) {
        @strongify(self)
        return [[self.services client] fetchPopularUsersWithLocation:nil language:nil];
    }];
    
    RAC(self, showcases)     = self.requestShowcasesCommand.executionSignals.switchToLatest;
    RAC(self, trendingRepos) = self.requestTrendingReposCommand.executionSignals.switchToLatest;
    RAC(self, popularRepos)  = self.requestPopularReposCommand.executionSignals.switchToLatest;
    RAC(self, popularUsers)  = self.requestPopularUsersCommand.executionSignals.switchToLatest;
    
    RACCommand *didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^(MRCExploreCollectionViewCellViewModel *viewModel) {
        @strongify(self)
        
        if ([viewModel.object isKindOfClass:[OCTRepository class]]) {
            MRCRepoDetailViewModel *detailViewModel = [[MRCRepoDetailViewModel alloc] initWithServices:self.services params:@{ @"repository": viewModel.object }];
            [self.services pushViewModel:detailViewModel animated:YES];
        } else if ([viewModel.object isKindOfClass:[OCTUser class]]) {
            MRCUserDetailViewModel *userViewModel = [[MRCUserDetailViewModel alloc] initWithServices:self.services params:@{ @"user": viewModel.object }];
            [self.services pushViewModel:userViewModel animated:YES];
        }
        
        return [RACSignal empty];
    }];
    
    RAC(self, dataSource) = [RACSignal
        combineLatest:@[ RACObserve(self, trendingRepos), RACObserve(self, popularRepos), RACObserve(self, popularUsers) ]
        reduce:^(NSArray *trendingRepos, NSArray *popularRepos, NSArray *popularUsers) {
            if (trendingRepos.count == 0 && popularRepos.count == 0 && popularUsers.count == 0) {
                return (NSArray *)nil;
            }
            
            NSMutableArray *rows = [[NSMutableArray alloc] init];
            
            if (trendingRepos.count > 0) {
                MRCExploreItemViewModel *viewModel = [[MRCExploreItemViewModel alloc] init];
                
                viewModel.title = @"Trending repositories this week";
                viewModel.dataSource = ({
                    NSArray *array = [[trendingRepos.rac_sequence
                        take:20]
                        map:^(OCTRepository *repository) {
                            MRCExploreCollectionViewCellViewModel *viewModel = [[MRCExploreCollectionViewCellViewModel alloc] init];
                            
                            viewModel.object = repository;
                            viewModel.avatarURL = repository.ownerAvatarURL;
                            viewModel.name = repository.name;
                            viewModel.didSelectCommand = didSelectCommand;
                            
                            return viewModel;
                        }].array;
                    array.count > 0 ? @[ array ] : nil;
                });
                
                [rows addObject:viewModel];
            }
            
            if (popularRepos.count > 0) {
                MRCExploreItemViewModel *viewModel = [[MRCExploreItemViewModel alloc] init];
                
                viewModel.title = @"Popular repositories";
                viewModel.dataSource = ({
                    NSArray *array = [[popularRepos.rac_sequence
                        take:20]
                        map:^(OCTRepository *repository) {
                            MRCExploreCollectionViewCellViewModel *viewModel = [[MRCExploreCollectionViewCellViewModel alloc] init];
                            
                            viewModel.object = repository;
                            viewModel.avatarURL = repository.ownerAvatarURL;
                            viewModel.name = repository.name;
                            viewModel.didSelectCommand = didSelectCommand;
                            
                            return viewModel;
                        }].array;
                    array.count > 0 ? @[ array ] : nil;
                });
                
                [rows addObject:viewModel];
            }
            
            if (popularUsers.count > 0) {
                MRCExploreItemViewModel *viewModel = [[MRCExploreItemViewModel alloc] init];
                
                viewModel.title = @"Popular users";
                viewModel.dataSource = ({
                    NSArray *array = [[popularUsers.rac_sequence
                        take:20]
                        map:^(OCTUser *user) {
                            MRCExploreCollectionViewCellViewModel *viewModel = [[MRCExploreCollectionViewCellViewModel alloc] init];
                            
                            viewModel.object = user;
                            viewModel.avatarURL = user.avatarURL;
                            viewModel.name = user.name;
                            viewModel.didSelectCommand = didSelectCommand;
                            
                            return viewModel;
                        }].array;
                    array.count > 0 ? @[ array ] : nil;
                });

                [rows addObject:viewModel];
            }
            
            return @[ rows.copy ];
        }];
    
    self.searchResultsViewModel = [[MRCReposSearchResultsViewModel alloc] initWithServices:self.services params:nil];
}

@end
