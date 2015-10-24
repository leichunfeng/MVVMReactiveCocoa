//
//  MRCStarredReposViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCStarredReposViewController.h"
#import "MRCStarredReposViewModel.h"

@interface MRCStarredReposViewController ()

@property (nonatomic, strong, readonly) MRCStarredReposViewModel *viewModel;

@end

@implementation MRCStarredReposViewController

@dynamic viewModel;

- (UIEdgeInsets)contentInset {
    return self.viewModel.entryPoint == MRCStarredReposViewModelEntryPointUserDetail ? UIEdgeInsetsMake(64, 0, 0, 0) : [super contentInset];
}

@end
