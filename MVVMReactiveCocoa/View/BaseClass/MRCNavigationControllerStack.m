//
//  MRCNavigationControllerStack.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCNavigationControllerStack.h"
#import "MRCRouter.h"
#import "MRCNavigationController.h"
#import "MRCTabBarController.h"
#import "MRCViewControllerAnimatedTransition.h"

@interface MRCNavigationControllerStack () <UINavigationControllerDelegate>

@property (nonatomic, strong) id<MRCViewModelServices> services;
@property (nonatomic, strong) NSMutableArray *navigationControllers;

@end

@implementation MRCNavigationControllerStack

- (instancetype)initWithServices:(id<MRCViewModelServices>)services {
    self = [super init];
    if (self) {
        self.services = services;
        self.navigationControllers = [[NSMutableArray alloc] init];
        [self registerNavigationHooks];
    }
    return self;
}

- (void)pushNavigationController:(UINavigationController *)navigationController {
    if ([self.navigationControllers containsObject:navigationController]) return;
    navigationController.delegate = self;
    [self.navigationControllers addObject:navigationController];
}

- (UINavigationController *)popNavigationController {
    UINavigationController *navigationController = self.navigationControllers.lastObject;
    [self.navigationControllers removeLastObject];
    return navigationController;
}

- (UINavigationController *)topNavigationController {
    return self.navigationControllers.lastObject;
}

- (void)registerNavigationHooks {
    @weakify(self)
    [[(NSObject *)self.services
        rac_signalForSelector:@selector(pushViewModel:animated:)]
        subscribeNext:^(RACTuple *tuple) {
            @strongify(self)
            MRCViewController *topViewController = (MRCViewController *)[self.navigationControllers.lastObject topViewController];
            if (topViewController.snapshot == nil) {
                topViewController.snapshot = [[self.navigationControllers.lastObject view] snapshotViewAfterScreenUpdates:NO];
            }
            
            UIViewController *viewController = (UIViewController *)[MRCRouter.sharedInstance viewControllerForViewModel:tuple.first];
            viewController.hidesBottomBarWhenPushed = YES;
            [self.navigationControllers.lastObject pushViewController:viewController animated:[tuple.second boolValue]];
        }];

    [[(NSObject *)self.services
        rac_signalForSelector:@selector(popViewModelAnimated:)]
        subscribeNext:^(RACTuple *tuple) {
        	@strongify(self)
            [self.navigationControllers.lastObject popViewControllerAnimated:[tuple.first boolValue]];
        }];

    [[(NSObject *)self.services
        rac_signalForSelector:@selector(popToRootViewModelAnimated:)]
        subscribeNext:^(RACTuple *tuple) {
            @strongify(self)
            [self.navigationControllers.lastObject popToRootViewControllerAnimated:[tuple.first boolValue]];
        }];

    [[(NSObject *)self.services
        rac_signalForSelector:@selector(presentViewModel:animated:completion:)]
        subscribeNext:^(RACTuple *tuple) {
        	@strongify(self)
            UIViewController *viewController = (UIViewController *)[MRCRouter.sharedInstance viewControllerForViewModel:tuple.first];

            UINavigationController *presentingViewController = self.navigationControllers.lastObject;
            if (![viewController isKindOfClass:UINavigationController.class]) {
                viewController = [[MRCNavigationController alloc] initWithRootViewController:viewController];
            }
            [self pushNavigationController:(UINavigationController *)viewController];

            [presentingViewController presentViewController:viewController animated:[tuple.second boolValue] completion:tuple.third];
        }];

    [[(NSObject *)self.services
        rac_signalForSelector:@selector(dismissViewModelAnimated:completion:)]
        subscribeNext:^(RACTuple *tuple) {
            @strongify(self)
            [self popNavigationController];
            [self.navigationControllers.lastObject dismissViewControllerAnimated:[tuple.first boolValue] completion:tuple.second];
        }];

    [[(NSObject *)self.services
        rac_signalForSelector:@selector(resetRootViewModel:)]
        subscribeNext:^(RACTuple *tuple) {
            @strongify(self)
            [self.navigationControllers removeAllObjects];

            UIViewController *viewController = (UIViewController *)[MRCRouter.sharedInstance viewControllerForViewModel:tuple.first];

            if (![viewController isKindOfClass:[UINavigationController class]] &&
                ![viewController isKindOfClass:[MRCTabBarController class]]) {
                viewController = [[MRCNavigationController alloc] initWithRootViewController:viewController];
                [self pushNavigationController:(UINavigationController *)viewController];
            }

            MRCSharedAppDelegate.window.rootViewController = viewController;
        }];
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(MRCViewControllerAnimatedTransition *)animationController {
    return animationController.fromViewController.interactivePopTransition;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(MRCViewController *)fromVC
                                                 toViewController:(MRCViewController *)toVC {
    if (fromVC.interactivePopTransition != nil) {
        return [[MRCViewControllerAnimatedTransition alloc] initWithNavigationControllerOperation:operation
                                                                               fromViewController:fromVC
                                                                                 toViewController:toVC];
    }
    return nil;
}

@end
