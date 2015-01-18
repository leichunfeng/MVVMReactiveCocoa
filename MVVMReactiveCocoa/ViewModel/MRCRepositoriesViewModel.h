//
//  MRCRepositoriesViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCTableViewModel.h"

@interface MRCRepositoriesViewModel : MRCTableViewModel

@property (nonatomic) NSInteger selectedSegmentIndex;
@property (strong, nonatomic, readonly) NSArray *dataSource;
@property (strong, nonatomic, readonly) NSArray *sectionIndexTitles;

@end
