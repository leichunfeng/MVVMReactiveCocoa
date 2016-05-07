//
//  MRCTrendingReposViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/5/7.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCViewModel.h"
#import "MRCTrendingViewModel.h"

@interface MRCTrendingReposViewModel : MRCViewModel

@property (nonatomic, strong, readonly) RACCommand *rightBarButtonItemCommand;

@property (nonatomic, strong, readonly) MRCTrendingViewModel *dailyViewModel;
@property (nonatomic, strong, readonly) MRCTrendingViewModel *weeklyViewModel;
@property (nonatomic, strong, readonly) MRCTrendingViewModel *monthlyViewModel;

@end
