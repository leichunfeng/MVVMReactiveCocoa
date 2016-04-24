//
//  MRCPopularReposViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/4/24.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCOwnedReposViewModel.h"

@interface MRCPopularReposViewModel : MRCOwnedReposViewModel

@property (nonatomic, strong, readonly) RACCommand *rightBarButtonItemCommand;

@end
