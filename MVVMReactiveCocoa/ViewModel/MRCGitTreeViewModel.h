//
//  MRCGitTreeViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/29.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCTableViewModel.h"

@interface MRCGitTreeViewModel : MRCTableViewModel

@property (nonatomic, strong, readonly) OCTTree *tree;
@property (nonatomic, copy, readonly) NSString *path;

@end
