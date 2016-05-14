//
//  MRCTrendingReposViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/5/7.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCTrendingReposViewModel.h"
#import "MRCTrendingViewModel.h"
#import "MRCLanguageViewModel.h"

@interface MRCTrendingReposViewModel ()

@property (nonatomic, copy) NSDictionary *language;

@property (nonatomic, strong, readwrite) RACCommand *rightBarButtonItemCommand;

@property (nonatomic, strong, readwrite) MRCTrendingViewModel *dailyViewModel;
@property (nonatomic, strong, readwrite) MRCTrendingViewModel *weeklyViewModel;
@property (nonatomic, strong, readwrite) MRCTrendingViewModel *monthlyViewModel;

@end

@implementation MRCTrendingReposViewModel

- (void)initialize {
    [super initialize];
    
    NSDictionary *language = (NSDictionary *)[[YYCache sharedCache] objectForKey:MRCTrendingReposLanguageCacheKey];
    
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
            
            [[YYCache sharedCache] setObject:language forKey:MRCTrendingReposLanguageCacheKey withBlock:NULL];
        };
        [self.services pushViewModel:viewModel animated:YES];

        return [RACSignal empty];
    }];

    self.dailyViewModel   = [[MRCTrendingViewModel alloc] initWithServices:self.services params:nil];
    self.weeklyViewModel  = [[MRCTrendingViewModel alloc] initWithServices:self.services params:nil];
    self.monthlyViewModel = [[MRCTrendingViewModel alloc] initWithServices:self.services params:nil];
    
    self.dailyViewModel.since   = @{ @"name": @"Today", @"slug": @"daily" };
    self.weeklyViewModel.since  = @{ @"name": @"This week", @"slug": @"weekly" };
    self.monthlyViewModel.since = @{ @"name": @"This month", @"slug": @"monthly" };
    
    RAC(self.dailyViewModel, language)   = RACObserve(self, language);
    RAC(self.weeklyViewModel, language)  = RACObserve(self, language);
    RAC(self.monthlyViewModel, language) = RACObserve(self, language);
}

@end
