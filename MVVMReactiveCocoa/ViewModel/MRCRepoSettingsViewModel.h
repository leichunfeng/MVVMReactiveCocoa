//
//  MRCRepoSettingsViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/11.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCTableViewModel.h"

@interface MRCRepoSettingsViewModel : MRCTableViewModel

@property (nonatomic, strong, readonly) OCTRepository *repository;

@end
