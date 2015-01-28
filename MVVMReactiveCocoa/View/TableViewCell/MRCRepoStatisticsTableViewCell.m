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
    [self addTopBorderWithHeight:0.5 andColor:HexRGB(colorB2)];
    [self addBottomBorderWithHeight:0.5 andColor:HexRGB(colorB2)];
}

@end
