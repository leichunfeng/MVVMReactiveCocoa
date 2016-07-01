//
//  MRCPopularReposViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/4/24.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCPopularReposViewModel.h"
#import "MRCLanguageViewModel.h"
#import "MRCLanguageViewModel.h"

@interface MRCPopularReposViewModel ()

@property (nonatomic, copy) NSDictionary *language;
@property (nonatomic, strong, readwrite) RACCommand *rightBarButtonItemCommand;

@end

@implementation MRCPopularReposViewModel

- (void)initialize {
    [super initialize];
    
    NSDictionary *language = (NSDictionary *)[[YYCache sharedCache] objectForKey:MRCPopularReposLanguageCacheKey];
    
    self.language = language ?: @{
        @"name": @"All Languages",
        @"slug": @"",
    };

    RAC(self, title) = [RACObserve(self, language) map:^(NSDictionary *language) {
        return language[@"name"];
    }];
    
    @weakify(self)
    self.rightBarButtonItemCommand = [[RACCommand alloc] initWithSignalBlock:^(id input) {
        @strongify(self)
        
        MRCLanguageViewModel *viewModel = [[MRCLanguageViewModel alloc] initWithServices:self.services
                                                                                  params:@{ @"language": self.language ?: @{} }];
        viewModel.callback = ^(NSDictionary *language) {
            @strongify(self)
            
            self.language = language;
            
            [[YYCache sharedCache] setObject:language forKey:MRCPopularReposLanguageCacheKey withBlock:NULL];
        };
        [self.services pushViewModel:viewModel animated:YES];
        
        return [RACSignal empty];
    }];
    
    self.shouldRequestRemoteDataOnViewDidLoad = NO;
    self.requestRemoteDataCommand.allowsConcurrentExecution = YES;
    
    [[[[RACObserve(self, language)
        map:^(NSDictionary *language) {
            return language[@"slug"];
        }]
        distinctUntilChanged]
        doNext:^(id x) {
            @strongify(self)
            self.dataSource = nil;
        }]
        subscribeNext:^(id x) {
            @strongify(self)
            [self.requestRemoteDataCommand execute:nil];
        }];
}

- (id)fetchLocalData {
    return nil;
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    return [[self.services client] fetchPopularRepositoriesWithLanguage:self.language[@"slug"]];
}

- (MRCReposViewModelType)type {
    return MRCReposViewModelTypePopular;
}

- (MRCReposViewModelOptions)options {
    MRCReposViewModelOptions options = 0;
    
//    options = options | MRCReposViewModelOptionsObserveStarredReposChange;
//    options = options | MRCReposViewModelOptionsSaveOrUpdateRepos;
//    options = options | MRCReposViewModelOptionsSaveOrUpdateStarredStatus;
//    options = options | MRCReposViewModelOptionsPagination;
//    options = options | MRCReposViewModelOptionsSectionIndex;
    options = options | MRCReposViewModelOptionsShowOwnerLogin;
    options = options | MRCReposViewModelOptionsMarkStarredStatus;
    
    return options;
}

@end
