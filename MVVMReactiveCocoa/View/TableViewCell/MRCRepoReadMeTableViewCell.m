//
//  MRCRepoReadMeTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/22.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoReadMeTableViewCell.h"

@implementation MRCRepoReadMeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.separatorView1 addTopBorderWithHeight:0.5 andColor:HexRGB(0xd2d2d2)];
    [self.separatorView2 addTopBorderWithHeight:0.5 andColor:HexRGB(0xd2d2d2)];
}

@end
