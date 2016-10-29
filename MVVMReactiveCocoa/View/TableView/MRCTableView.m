//
//  MRCTableView.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/9/21.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCTableView.h"

@implementation MRCTableView

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ([view isKindOfClass:[UIControl class]]) return YES;
    return [super touchesShouldCancelInContentView:view];
}

@end
