//
//  MRCSegmentedControlController.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCViewController.h"

@class MRCSegmentedControlController;

@protocol MRCSegmentedControlControllerDelegate <NSObject>

@optional

- (void)segmentedControlController:(MRCSegmentedControlController *)segmentedControlController didSelectViewController:(UIViewController *)viewController;

@end

@interface MRCSegmentedControlController : MRCViewController

@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, strong, readonly) UISegmentedControl *segmentedControl;
@property (nonatomic, assign) id<MRCSegmentedControlControllerDelegate> delegate;

@end

@interface UIViewController (MRCSegmentedControlItem)

@property (nonatomic, copy) NSString *segmentedControlItem;

@end
