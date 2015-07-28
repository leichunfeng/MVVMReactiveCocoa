//
//  MRCSearchViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCTableViewModel.h"
#import "MRCReposSearchResultsViewModel.h"

@interface MRCSearchViewModel : MRCTableViewModel

@property (strong, nonatomic, readonly) MRCReposSearchResultsViewModel *searchResultsViewModel;

@end
