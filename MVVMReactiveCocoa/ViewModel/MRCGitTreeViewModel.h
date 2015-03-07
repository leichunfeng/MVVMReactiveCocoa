//
//  MRCGitTreeViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/29.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCTableViewModel.h"

@interface MRCGitTreeViewModel : MRCTableViewModel

@property (strong, nonatomic, readonly) OCTTree *tree;
@property (strong, nonatomic, readonly) NSString *path;

@end
