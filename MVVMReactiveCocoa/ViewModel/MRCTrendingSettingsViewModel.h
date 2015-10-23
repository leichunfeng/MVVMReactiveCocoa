//
//  MRCTrendingSettingsViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/10/21.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import "MRCTableViewModel.h"

@interface MRCTrendingSettingsViewModel : MRCTableViewModel

@property (nonatomic, copy) NSDictionary *since;
@property (nonatomic, copy) NSDictionary *language;

NSArray *MRCTrendingSinces();
NSArray *MRCTrendingLanguages();

@end
