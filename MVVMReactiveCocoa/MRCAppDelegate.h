//
//  MRCAppDelegate.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MRCNavigationControllerStack;

@interface MRCAppDelegate : UIResponder <UIApplicationDelegate>

// The window of current application.
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MRCNavigationControllerStack *navigationControllerStack;
@property (strong, nonatomic) RACSignal *reachabilitySignal;

@end
