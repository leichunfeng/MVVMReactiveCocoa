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

@property (strong, nonatomic, readonly) MRCStarredReposViewModel *viewModel;

@end

@implementation MRCStarredReposViewController

@dynamic viewModel;

- (UIEdgeInsets)contentInset {
    if (self.viewModel.isCurrentUser && self.viewModel.entryPoint == MRCStarredReposViewModelEntryPointHomepage) {
        return UIEdgeInsetsMake(64, 0, 49, 0);
    }
    return UIEdgeInsetsZero;
}

@end
