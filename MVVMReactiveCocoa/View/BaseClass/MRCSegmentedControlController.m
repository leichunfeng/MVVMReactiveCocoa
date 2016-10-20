//
//  MRCSegmentedControlController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCSegmentedControlController.h"

@interface MRCSegmentedControlController ()

@property (nonatomic, strong, readwrite) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIViewController *currentViewController;

@end

@implementation MRCSegmentedControlController

- (void)initialize {
    UIViewController *currentViewController = self.viewControllers.firstObject;
    
    [self addChildViewController:currentViewController];
    currentViewController.view.frame = self.view.bounds;
    [self.view addSubview:currentViewController.view];
    [currentViewController didMoveToParentViewController:self];
    
    self.currentViewController = currentViewController;
    
    NSArray *items = [self.viewControllers.rac_sequence map:^(UIViewController *viewController) {
        return viewController.segmentedControlItem;
    }].array;
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
    self.segmentedControl.selectedSegmentIndex = 0;
    
    self.navigationItem.titleView = self.segmentedControl;
    
    @weakify(self)
    [[self.segmentedControl
    	rac_newSelectedSegmentIndexChannelWithNilValue:@0]
    	subscribeNext:^(NSNumber *selectedSegmentIndex) {
            @strongify(self)
            UIViewController *toViewController = self.viewControllers[selectedSegmentIndex.integerValue];
            [self cycleFromViewController:self.currentViewController toViewController:toViewController];
        }];
}

- (void)cycleFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController {
    // Prepare the two view controllers for the change.
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    toViewController.view.frame = self.view.bounds;
    
    // Queue up the transition animation.
    [self transitionFromViewController:fromViewController
                      toViewController:toViewController
                              duration:0
                               options:0
                            animations:NULL
                            completion:^(BOOL finished) {
                                // Remove the old view controller and send the final
                                // notification to the new view controller.
                                [fromViewController removeFromParentViewController];
                                [toViewController didMoveToParentViewController:self];
                                
                                self.currentViewController = toViewController;
                                
                                if ([self.delegate respondsToSelector:@selector(segmentedControlController:didSelectViewController:)]) {
                                    [self.delegate segmentedControlController:self didSelectViewController:toViewController];
                                }
                            }];
}

- (void)setViewControllers:(NSArray *)viewControllers {
    _viewControllers = viewControllers;
    [self initialize];
}

@end

static void *MRCSegmentedControlItemKey = &MRCSegmentedControlItemKey;

@implementation UIViewController (MRCSegmentedControlItem)

- (NSString *)segmentedControlItem {
    return objc_getAssociatedObject(self, MRCSegmentedControlItemKey);
}

- (void)setSegmentedControlItem:(NSString *)segmentedControlItem {
    objc_setAssociatedObject(self, MRCSegmentedControlItemKey, segmentedControlItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
