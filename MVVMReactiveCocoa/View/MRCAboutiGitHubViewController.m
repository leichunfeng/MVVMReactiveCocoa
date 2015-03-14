//
//  MRCAboutiGitHubViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/3/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCAboutiGitHubViewController.h"
#import "MRCAboutiGitHubViewModel.h"

@interface MRCAboutiGitHubViewController ()

@property (strong, nonatomic, readonly) MRCAboutiGitHubViewModel *viewModel;

@end

@implementation MRCAboutiGitHubViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    [self.webView loadRequest:self.viewModel.request];
}

@end
