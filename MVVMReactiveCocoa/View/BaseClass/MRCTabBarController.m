//
//  MRCTabBarController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/9.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCTabBarController.h"

@implementation MRCTabBarController

@synthesize viewModel = _viewModel;

- (id<MRCViewProtocol>)initWithViewModel:(id)viewModel {
    _viewModel = viewModel;
    self = [super init];
    if (self) {
    }
    return self;
}

- (BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.selectedViewController.preferredStatusBarStyle;
}

@end
