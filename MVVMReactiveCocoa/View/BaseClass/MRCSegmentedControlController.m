//
//  MRCSegmentedControlController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCSegmentedControlController.h"

@interface MRCSegmentedControlController ()

@property (strong, nonatomic, readwrite) UISegmentedControl *segmentedControl;
@property (strong, nonatomic) UIViewController *currentViewController;

@end

@implementation MRCSegmentedControlController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *items = [self.viewControllers.rac_sequence
    	map:^id(UIViewController *viewController) {
            return viewController.segmentedControlItem;
        }].array;
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
    self.segmentedControl.tintColor = [UIColor whiteColor];
    self.segmentedControl.selectedSegmentIndex = 0;
    
    @weakify(self)
    [[self.segmentedControl rac_newSelectedSegmentIndexChannelWithNilValue:@0]
    	subscribeNext:^(NSNumber *selectedSegmentIndex) {
            @strongify(self)
            UIViewController *toViewController = self.viewControllers[[selectedSegmentIndex integerValue]];
            [self transitionFromViewController:self.currentViewController
                              toViewController:toViewController
                                      duration:0
                                       options:0
                                    animations:NULL
                                    completion:^(BOOL finished) {
                                        @strongify(self)
                                        self.currentViewController = toViewController;
                                    }];
        }];
    
    self.navigationItem.titleView = self.segmentedControl;
    
    for (UIViewController *viewController in self.viewControllers) {
        [self addChildViewController:viewController];
    }
    
    self.currentViewController = self.viewControllers.firstObject;
    [self.view addSubview:self.currentViewController.view];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.currentViewController.view.frame = self.view.bounds;
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
