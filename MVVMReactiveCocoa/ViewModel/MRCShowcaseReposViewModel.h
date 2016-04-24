//
//  MRCShowcaseReposViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/4/24.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCOwnedReposViewModel.h"
#import "MRCShowcaseHeaderViewModel.h"

@interface MRCShowcaseReposViewModel : MRCOwnedReposViewModel

@property (nonatomic, strong, readonly) MRCShowcaseHeaderViewModel *headerViewModel;

@end
