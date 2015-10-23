//
//  MRCTrendingViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/10/20.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import "MRCOwnedReposViewModel.h"
#import "MRCTrendingSettingsViewModel.h"

@interface MRCTrendingViewModel : MRCOwnedReposViewModel

@property (nonatomic, copy) NSDictionary *since;
@property (nonatomic, copy) NSDictionary *language;

@end
