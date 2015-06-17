//
//  UINavigationItem+MRCBackBarButtonItem.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/17.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "UINavigationItem+MRCBackBarButtonItem.h"

@implementation UINavigationItem (MRCBackBarButtonItem)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(backBarButtonItem);
        SEL swizzledSelector = @selector(mrc_backBarButtonItem);
        
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (!success) {
            class_replaceMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        }
    });
}

#pragma mark - Method Swizzling

- (UIBarButtonItem *)mrc_backBarButtonItem {
    return [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:NULL];
}

@end
