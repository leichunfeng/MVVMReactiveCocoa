//
//  MRCRepoDetailViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCTableViewModel.h"

@interface MRCRepoDetailViewModel : MRCTableViewModel

@property (strong, nonatomic, readonly) OCTRepository *repository;

@end
