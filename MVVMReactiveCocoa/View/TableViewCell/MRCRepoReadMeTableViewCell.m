//
//  MRCRepoReadMeTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/22.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoReadMeTableViewCell.h"

@interface MRCRepoReadMeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *wapperView;
@property (weak, nonatomic) IBOutlet UIView *readMeWapperView;

@end

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
    
    self.wapperView.layer.borderColor  = HexRGB(colorB2).CGColor;
    self.wapperView.layer.borderWidth  = 0.5;
    self.wapperView.layer.cornerRadius = 3;
    
    [self.readMeWapperView addBottomBorderWithHeight:0.5 andColor:HexRGB(colorB2)];
    [self.readMeButton addTopBorderWithHeight:0.5 andColor:HexRGB(colorB2)];
    
    [self.separatorView1 addTopBorderWithHeight:0.5 andColor:HexRGB(colorB2)];
    [self.separatorView2 addTopBorderWithHeight:0.5 andColor:HexRGB(colorB2)];
}

@end
