//
//  MRCExploreViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/3/26.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCExploreViewModel.h"
#import "MRCExploreCollectionViewCellViewModel.h"

@interface MRCExploreViewModel ()

@property (nonatomic, copy) NSArray<NSDictionary *> *showcases;
@property (nonatomic, copy) NSArray<OCTRepository *> *trendingRepos;
@property (nonatomic, copy) NSArray<OCTRepository *> *popularRepos;
@property (nonatomic, copy) NSArray<OCTUser *> *popularUsers;

@property (nonatomic, strong, readwrite) RACCommand *requestShowcasesCommand;
@property (nonatomic, strong, readwrite) RACCommand *requestTrendingReposCommand;
@property (nonatomic, strong, readwrite) RACCommand *requestPopularReposCommand;
@property (nonatomic, strong, readwrite) RACCommand *requestPopularUsersCommand;

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
                        map:^(OCTRepository *repo) {
                            MRCExploreCollectionViewCellViewModel *viewModel = [[MRCExploreCollectionViewCellViewModel alloc] init];
                            
                            viewModel.avatarURL = repo.ownerAvatarURL;
                            viewModel.name = repo.name;
                            
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
                        map:^(OCTRepository *repo) {
                            MRCExploreCollectionViewCellViewModel *viewModel = [[MRCExploreCollectionViewCellViewModel alloc] init];
                            
                            viewModel.avatarURL = repo.ownerAvatarURL;
                            viewModel.name = repo.name;
                            
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
                            
                            viewModel.avatarURL = user.avatarURL;
                            viewModel.name = user.name;
                            
                            return viewModel;
                        }].array;
                    array.count > 0 ? @[ array ] : nil;
                });

                [rows addObject:viewModel];
            }
            
            return @[ rows.copy ];
        }];
}

@end
