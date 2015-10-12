//
//  UIView+MRCFrameAdditions.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/8/8.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "UIView+MRCFrameAdditions.h"

@implementation UIView (MRCFrameAdditions)

- (CGFloat)mrc_x {
    return CGRectGetMinX(self.frame);
}

- (void)setMrc_x:(CGFloat)mrc_x {
    self.frame = CGRectMake(mrc_x, CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (CGFloat)mrc_y {
    return CGRectGetMinY(self.frame);
}

- (void)setMrc_y:(CGFloat)mrc_y {
    self.frame = CGRectMake(CGRectGetMinX(self.frame), mrc_y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (CGFloat)mrc_width {
    return CGRectGetWidth(self.frame);
}

- (void)setMrc_width:(CGFloat)mrc_width {
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), mrc_width, CGRectGetHeight(self.frame));
}

- (CGFloat)mrc_height {
    return CGRectGetHeight(self.frame);
}

- (void)setMrc_height:(CGFloat)mrc_height {
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), mrc_height);
}

@end
