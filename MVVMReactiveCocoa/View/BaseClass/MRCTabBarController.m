//
//  MRCTabBarController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/9.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCTabBarController.h"

@interface MRCTabBarController ()

@property (nonatomic, strong, readwrite) UITabBarController *tabBarController;

@end

@implementation MRCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.view.frame = self.view.bounds;

    [self addChildViewController:self.tabBarController];
    [self.view addSubview:self.tabBarController.view];
}

- (BOOL)shouldAutorotate {
    return self.tabBarController.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.tabBarController.selectedViewController.supportedInterfaceOrientations;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.tabBarController.selectedViewController.preferredStatusBarStyle;
}

@end
