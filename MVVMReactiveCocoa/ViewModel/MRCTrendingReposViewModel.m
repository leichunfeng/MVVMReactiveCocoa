//
//  MRCTrendingReposViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/5/7.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCTrendingReposViewModel.h"
#import "MRCTrendingViewModel.h"

@interface MRCTrendingReposViewModel ()

@property (nonatomic, strong, readwrite) MRCTrendingViewModel *dailyViewModel;
@property (nonatomic, strong, readwrite) MRCTrendingViewModel *weeklyViewModel;
@property (nonatomic, strong, readwrite) MRCTrendingViewModel *monthlyViewModel;

@end

@implementation MRCTrendingReposViewModel

- (void)initialize {
    [super initialize];
    
    self.title = @"All Languages";

    self.dailyViewModel   = [[MRCTrendingViewModel alloc] initWithServices:self.services params:nil];
    self.weeklyViewModel  = [[MRCTrendingViewModel alloc] initWithServices:self.services params:nil];
    self.monthlyViewModel = [[MRCTrendingViewModel alloc] initWithServices:self.services params:nil];
}

@end
