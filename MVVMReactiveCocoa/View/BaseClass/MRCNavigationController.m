//
//  MRCNavigationController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/2/12.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCNavigationController.h"

@implementation MRCNavigationController

- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
}

@end
