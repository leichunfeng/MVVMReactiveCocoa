//
//  MRCViewControllerAnimatedTransition.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/12/8.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRCViewController.h"

@interface MRCViewControllerAnimatedTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, readonly) UINavigationControllerOperation operation;
@property (nonatomic, weak, readonly) MRCViewController *fromViewController;
@property (nonatomic, weak, readonly) MRCViewController *toViewController;

- (instancetype)initWithNavigationControllerOperation:(UINavigationControllerOperation)operation
                                   fromViewController:(MRCViewController *)fromViewController
                                     toViewController:(MRCViewController *)toViewController;

@end
