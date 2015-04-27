//
//  UIViewController+MRCUMAnalytics.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/4/27.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "UIViewController+MRCUMAnalytics.h"

@implementation UIViewController (MRCUMAnalytics)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        // viewWillAppear: Swizzling
        SEL originalSelector1 = @selector(viewWillAppear:);
        SEL swizzledSelector1 = @selector(mrc_viewWillAppear:);
        
        Method originalMethod1 = class_getInstanceMethod(class, originalSelector1);
        Method swizzledMethod1 = class_getInstanceMethod(class, swizzledSelector1);
        
        BOOL didAddMethod1 =
        	class_addMethod(class,
            	originalSelector1,
                method_getImplementation(swizzledMethod1),
                method_getTypeEncoding(swizzledMethod1));
        
        if (didAddMethod1) {
            class_replaceMethod(class,
                swizzledSelector1,
                method_getImplementation(originalMethod1),
                method_getTypeEncoding(originalMethod1));
        } else {
            method_exchangeImplementations(originalMethod1, swizzledMethod1);
        }
        
        // viewWillDisappear: Swizzling
        SEL originalSelector2 = @selector(viewWillDisappear:);
        SEL swizzledSelector2 = @selector(mrc_viewWillDisappear:);
        
        Method originalMethod2 = class_getInstanceMethod(class, originalSelector2);
        Method swizzledMethod2 = class_getInstanceMethod(class, swizzledSelector2);
        
        BOOL didAddMethod2 =
        	class_addMethod(class,
            	originalSelector2,
                method_getImplementation(swizzledMethod2),
                method_getTypeEncoding(swizzledMethod2));
        
        if (didAddMethod2) {
            class_replaceMethod(class,
                swizzledSelector2,
                method_getImplementation(originalMethod2),
                method_getTypeEncoding(originalMethod2));
        } else {
            method_exchangeImplementations(originalMethod2, swizzledMethod2);
        }
    });
}

#pragma mark - Method Swizzling

- (void)mrc_viewWillAppear:(BOOL)animated {
    [self mrc_viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)mrc_viewWillDisappear:(BOOL)animated {
    [self mrc_viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

@end
