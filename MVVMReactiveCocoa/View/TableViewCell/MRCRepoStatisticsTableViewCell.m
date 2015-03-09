//
//  MRCRepoStatisticsTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/22.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoStatisticsTableViewCell.h"

@implementation MRCRepoStatisticsTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    [self addTopBorderWithHeight:MRC_1PX_WIDTH andColor:HexRGB(colorB2)];
    [self addBottomBorderWithHeight:MRC_1PX_WIDTH andColor:HexRGB(colorB2)];
}

@end
