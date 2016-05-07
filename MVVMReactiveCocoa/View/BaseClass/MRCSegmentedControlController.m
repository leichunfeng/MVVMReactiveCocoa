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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

- (void)initialize {
    for (UIViewController *viewController in self.viewControllers) {
        viewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addChildViewController:viewController];
    }
    
    self.currentViewController = self.viewControllers.firstObject;
    [self.view addSubview:self.currentViewController.view];

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
            [self transitionFromViewController:self.currentViewController
                              toViewController:toViewController
                                      duration:0
                                       options:0
                                    animations:NULL
                                    completion:^(BOOL finished) {
                                    	@strongify(self)
                                    	self.currentViewController = toViewController;
                                    	if ([self.delegate respondsToSelector:@selector(segmentedControlController:didSelectViewController:)]) {
                                    		[self.delegate segmentedControlController:self didSelectViewController:self.currentViewController];
                                        }
                                    }];
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
