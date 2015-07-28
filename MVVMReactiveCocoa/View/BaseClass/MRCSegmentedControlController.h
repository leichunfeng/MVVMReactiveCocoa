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

@property (copy, nonatomic) NSArray *viewControllers;
@property (strong, nonatomic, readonly) UISegmentedControl *segmentedControl;
@property (assign, nonatomic) id<MRCSegmentedControlControllerDelegate> delegate;

@end

@interface UIViewController (MRCSegmentedControlItem)

@property (copy, nonatomic) NSString *segmentedControlItem;

@end
