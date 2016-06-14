//
//  UITableView+MRCAdditions.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/6/12.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "UITableView+MRCAdditions.h"

@implementation UITableView (MRCAdditions)

//+ (void)load {
//    static dispatch_once_t onceToken1;
//    dispatch_once(&onceToken1, ^{
//        Class class = [self class];
//        
//        SEL originalSelector = @selector(initWithFrame:);
//        SEL swizzledSelector = @selector(mrc_initWithFrame:);
//        
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//        
//        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//        if (success) {
//            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
//
//    static dispatch_once_t onceToken2;
//    dispatch_once(&onceToken2, ^{
//        Class class = [self class];
//        
//        SEL originalSelector = @selector(initWithCoder:);
//        SEL swizzledSelector = @selector(mrc_initWithCoder:);
//        
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//        
//        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//        if (success) {
//            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
//
//    static dispatch_once_t onceToken3;
//    dispatch_once(&onceToken3, ^{
//        Class class = [self class];
//        
//        SEL originalSelector = @selector(touchesShouldCancelInContentView:);
//        SEL swizzledSelector = @selector(mrc_touchesShouldCancelInContentView:);
//        
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//        
//        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//        if (success) {
//            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
//}

#pragma mark - Method Swizzling

- (instancetype)mrc_initWithFrame:(CGRect)frame {
    UITableView *tableView = [self mrc_initWithFrame:frame];
    [self configureTableView:tableView];
    return tableView;
}

- (instancetype)mrc_initWithCoder:(NSCoder *)aDecoder {
    UITableView *tableView = [self mrc_initWithCoder:aDecoder];
    [self configureTableView:tableView];
    return tableView;
}

- (BOOL)mrc_touchesShouldCancelInContentView:(UIView *)view {
    if ([view isKindOfClass:[UIControl class]]) return YES;
    return [self mrc_touchesShouldCancelInContentView:view];
}

- (void)configureTableView:(UITableView *)tableView {
    tableView.delaysContentTouches = NO;
    
    // Remove touch delay (since iOS 8)
    UIView *wrapView = tableView.subviews.firstObject;
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

@end
