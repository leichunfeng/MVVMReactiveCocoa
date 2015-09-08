//
//  MRCReposViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCReposViewController.h"
#import "MRCReposViewModel.h"
#import "MRCOwnedReposViewController.h"
#import "MRCStarredReposViewController.h"

@interface MRCReposViewController ()

@property (nonatomic, strong, readonly) MRCReposViewModel *viewModel;

@end

@implementation MRCReposViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MRCOwnedReposViewController *ownedReposViewController = [[MRCOwnedReposViewController alloc] initWithViewModel:self.viewModel.viewModels[0]];
    ownedReposViewController.segmentedControlItem = @"Owned";
    
    MRCStarredReposViewController *starredReposViewController = [[MRCStarredReposViewController alloc] initWithViewModel:self.viewModel.viewModels[1]];
    starredReposViewController.segmentedControlItem = @"Starred";
    
    self.viewControllers = @[ ownedReposViewController, starredReposViewController ];
}

@end
