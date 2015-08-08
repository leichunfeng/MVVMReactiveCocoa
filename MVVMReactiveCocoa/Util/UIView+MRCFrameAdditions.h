//
//  UIView+MRCFrameAdditions.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/8/8.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MRCFrameAdditions)

@property (assign, nonatomic) CGFloat mrc_x;
@property (assign, nonatomic) CGFloat mrc_y;
@property (assign, nonatomic) CGFloat mrc_width;
@property (assign, nonatomic) CGFloat mrc_height;

@end
