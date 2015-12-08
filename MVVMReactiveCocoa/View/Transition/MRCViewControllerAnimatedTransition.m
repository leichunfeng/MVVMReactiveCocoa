//
//  MRCViewControllerAnimatedTransition.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/12/8.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import "MRCViewControllerAnimatedTransition.h"

@interface MRCViewControllerAnimatedTransition ()

@property (nonatomic, assign, readwrite) UINavigationControllerOperation operation;
@property (nonatomic, weak, readwrite) MRCViewController *fromViewController;
@property (nonatomic, weak, readwrite) MRCViewController *toViewController;

@end

@implementation MRCViewControllerAnimatedTransition

- (instancetype)initWithNavigationControllerOperation:(UINavigationControllerOperation)operation
                                   fromViewController:(MRCViewController *)fromViewController
                                     toViewController:(MRCViewController *)toViewController {
    self = [super init];
    if (self) {
        self.operation = operation;
        self.fromViewController = fromViewController;
        self.toViewController = toViewController;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect initialFrameForFromViewController = [transitionContext initialFrameForViewController:fromViewController];
    CGRect finalFrameForFromViewController   = [transitionContext finalFrameForViewController:fromViewController];
    
    NSLog(@"initialFrameForFromViewController: %@", NSStringFromCGRect(initialFrameForFromViewController));
    NSLog(@"finalFrameForFromViewController: %@", NSStringFromCGRect(finalFrameForFromViewController));
    
    CGRect initialFrameForToViewController = [transitionContext initialFrameForViewController:toViewController];
    CGRect finalFrameForToViewController   = [transitionContext finalFrameForViewController:toViewController];
    
    NSLog(@"initialFrameForToViewController: %@", NSStringFromCGRect(initialFrameForToViewController));
    NSLog(@"finalFrameForToViewController: %@", NSStringFromCGRect(finalFrameForToViewController));

    NSTimeInterval duration = [self transitionDuration:transitionContext];

    if (self.operation == UINavigationControllerOperationPush) { // push
        CGRect frame = [transitionContext finalFrameForViewController:toViewController];
        toViewController.view.frame = CGRectOffset(frame, CGRectGetWidth(frame), 0);
        [[transitionContext containerView] addSubview:toViewController.view];

        [UIView animateWithDuration:duration
                         animations:^{
                             fromViewController.view.alpha = 0;
//                             fromViewController.view.frame = CGRectInset(fromViewController.view.frame, 10, 10);
                             toViewController.view.frame = CGRectOffset(toViewController.view.frame, -CGRectGetWidth(toViewController.view.frame), 0);
                         }
                         completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    } else if (self.operation == UINavigationControllerOperationPop) { // pop
        [[transitionContext containerView] addSubview:toViewController.view];
        [[transitionContext containerView] sendSubviewToBack:toViewController.view];

        [UIView animateWithDuration:duration
                         animations:^{
                             fromViewController.view.frame = CGRectOffset(fromViewController.view.frame, CGRectGetWidth(fromViewController.view.frame), 0);
                             toViewController.view.alpha = 1;
//                             toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
                         }
                         completion:^(BOOL finished) {
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
    }
}

@end
