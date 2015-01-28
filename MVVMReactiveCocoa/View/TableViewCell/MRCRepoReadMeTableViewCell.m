//
//  MRCRepoReadMeTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/22.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoReadMeTableViewCell.h"

@interface MRCRepoReadMeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *readMeImageView;
@property (weak, nonatomic) IBOutlet UIView *wapperView;
@property (weak, nonatomic) IBOutlet UIView *readMeWapperView;

@end

@implementation MRCRepoReadMeTableViewCell

- (void)awakeFromNib {
    self.readMeImageView.image = [UIImage octicon_imageWithIdentifier:@"Book" size:CGSizeMake(22, 22)];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.wapperView.frame = CGRectMake(15, 0, CGRectGetWidth(self.contentView.frame) - 15*2, CGRectGetHeight(self.contentView.frame));
    
    self.wapperView.layer.borderColor  = HexRGB(colorB2).CGColor;
    self.wapperView.layer.borderWidth  = 0.5;
    self.wapperView.layer.cornerRadius = 3;
    
    [self.readMeWapperView addBottomBorderWithHeight:0.5 andColor:HexRGB(colorB2)];
    [self.readMeButton addTopBorderWithHeight:0.5 andColor:HexRGB(colorB2)];
}

@end
