//
//  MRCTableView.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/9/21.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCTableView.h"

@implementation MRCTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.delaysContentTouches = NO;
    
    // Remove touch delay (since iOS 8)
    UIView *wrapView = self.subviews.firstObject;
    // UITableViewWrapperView
    if (wrapView && [NSStringFromClass(wrapView.class) hasSuffix:@"WrapperView"]) {
        for (UIGestureRecognizer *gesture in wrapView.gestureRecognizers) {
            // UIScrollViewDelayedTouchesBeganGestureRecognizer
            if ([NSStringFromClass(gesture.class) containsString:@"DelayedTouchesBegan"]) {
                gesture.enabled = NO;
                break;
            }
        }
    }
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ([view isKindOfClass:[UIControl class]]) return YES;
    return [super touchesShouldCancelInContentView:view];
}

@end
