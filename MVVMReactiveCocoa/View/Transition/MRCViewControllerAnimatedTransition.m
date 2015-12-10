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
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    MRCViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    MRCViewController *toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
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
        [[transitionContext containerView] addSubview:fromViewController.snapshot];
        fromViewController.view.hidden = YES;
        
        CGRect frame = [transitionContext finalFrameForViewController:toViewController];
        toViewController.view.frame = CGRectOffset(frame, CGRectGetWidth(frame), 0);
        [[transitionContext containerView] addSubview:toViewController.view];

        [UIView animateWithDuration:duration
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             fromViewController.snapshot.alpha = 0.0;
                             fromViewController.snapshot.frame = CGRectInset(fromViewController.view.frame, 20, 20);
                             toViewController.view.frame = CGRectOffset(toViewController.view.frame, -CGRectGetWidth(toViewController.view.frame), 0);
//                             toViewController.navigationController.navigationBar.frame = CGRectOffset(toViewController.navigationController.navigationBar.frame, -CGRectGetWidth(toViewController.navigationController.navigationBar.frame), 0);
                         }
                         completion:^(BOOL finished) {
                             fromViewController.view.hidden = NO;
                             [fromViewController.snapshot removeFromSuperview];
                             [transitionContext completeTransition:YES];
                         }];
    } else if (self.operation == UINavigationControllerOperationPop) { // pop
//        fromViewController.view.hidden = YES;
        toViewController.view.hidden = YES;
        
        [[transitionContext containerView] addSubview:toViewController.view];
        [[transitionContext containerView] addSubview:toViewController.snapshot];
        [[transitionContext containerView] sendSubviewToBack:toViewController.snapshot];
        
        toViewController.snapshot.transform = CGAffineTransformMakeScale(0.95, 0.95);
        
        [fromViewController.view addSubview:fromViewController.snapshot];
        
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, 44)];
//        view.backgroundColor = [UIColor blueColor];
//        [fromViewController.view addSubview:view];
//        [[transitionContext containerView] addSubview:fromViewController.snapshot];
        
        fromViewController.navigationController.navigationBar.hidden = YES;
        
        toViewController.snapshot.alpha = 0.0;
        
        [UIView animateWithDuration:duration
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
//                             fromViewController.navigationController.navigationBar.frame = CGRectOffset(fromViewController.navigationController.navigationBar.frame, CGRectGetWidth(fromViewController.view.frame), 0);
                             fromViewController.view.frame = CGRectOffset(fromViewController.view.frame, CGRectGetWidth(fromViewController.view.frame), 0);
//                             fromViewController.snapshot.frame = CGRectOffset(fromViewController.snapshot.frame, CGRectGetWidth(fromViewController.snapshot.frame), 0);
                             
//                             fromViewController.snapshot.frame = CGRectOffset(fromViewController.snapshot.frame, 0, 0);
                             toViewController.snapshot.alpha = 1.0;
//                             toViewController.snapshot.frame = [transitionContext finalFrameForViewController:toViewController];
                             toViewController.snapshot.transform = CGAffineTransformIdentity;
                         }
                         completion:^(BOOL finished) {
                             toViewController.navigationController.navigationBar.hidden = NO;
                             
                             fromViewController.view.hidden = NO;
                             toViewController.view.hidden   = NO;
                             
                             [fromViewController.snapshot removeFromSuperview];
                             [toViewController.snapshot removeFromSuperview];
                             
//                             if (![transitionContext transitionWasCancelled]) {
//                                 toViewController.navigationController.navigationBar.frame = CGRectOffset(toViewController.navigationController.navigationBar.frame, -CGRectGetWidth(toViewController.view.frame), 0);
//                             }
                             
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
//        [UIView animateWithDuration:duration
//                         animations:^{
////                             fromViewController.navigationController.navigationBar.frame = CGRectOffset(fromViewController.navigationController.navigationBar.frame, CGRectGetWidth(fromViewController.view.frame), 0);
//                             fromViewController.view.frame = CGRectOffset(fromViewController.view.frame, CGRectGetWidth(fromViewController.view.frame), 0);
//                             toViewController.view.alpha = 1;
////                             toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
//                         }
//                         completion:^(BOOL finished) {
//                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//                         }];
    }
}

@end
