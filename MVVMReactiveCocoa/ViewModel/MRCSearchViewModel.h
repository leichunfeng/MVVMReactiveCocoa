//
//  MRCSearchViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCViewModel.h"
#import "MRCOwnedReposViewModel.h"

@interface MRCSearchViewModel : MRCViewModel

@property (strong, nonatomic) MRCOwnedReposViewModel *searchResultsViewModel;

@end
