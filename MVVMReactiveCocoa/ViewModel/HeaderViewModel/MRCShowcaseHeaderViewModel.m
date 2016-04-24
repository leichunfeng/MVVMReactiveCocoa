//
//  MRCShowcaseHeaderViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/4/24.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCShowcaseHeaderViewModel.h"

@implementation MRCShowcaseHeaderViewModel

- (CGFloat)height {
    CGFloat height = 0;
    
    height += 70;
    
    CGRect rect = [self.desc boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 15 * 2, 0)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:15] }
                                          context:nil];
    
    height += 15;
    height += ceil(CGRectGetHeight(rect));
    height += 15;
    
    return height;
}

@end
