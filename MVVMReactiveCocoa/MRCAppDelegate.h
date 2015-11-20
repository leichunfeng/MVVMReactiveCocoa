//
//  MRCAppDelegate.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "MRCNavigationControllerStack.h"

@interface MRCAppDelegate : UIResponder <UIApplicationDelegate>

/// The window of current application.
@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong, readonly) MRCNavigationControllerStack *navigationControllerStack;
@property (nonatomic, assign, readonly) NetworkStatus networkStatus;

@property (nonatomic, copy, readonly) NSString *adURL;

@end
