//
//  MRCRepoReadmeTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/22.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoReadmeTableViewCell.h"

@interface MRCRepoReadmeTableViewCell () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *readmeImageView;
@property (weak, nonatomic) IBOutlet UIView *wapperView;
@property (weak, nonatomic) IBOutlet UIView *readmeWapperView;

@property (strong, nonatomic) UIView *readmeWapperViewBottomBorder;
@property (strong, nonatomic) UIView *readmeButtonTopBorder;

@end

@implementation MRCRepoReadmeTableViewCell

- (void)awakeFromNib {
    self.readmeImageView.image = [UIImage octicon_imageWithIdentifier:@"Book" size:CGSizeMake(22, 22)];
    self.readmeButton.tintColor = HexRGB(colorI3);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.wapperView.frame = CGRectMake(15, 0, CGRectGetWidth(self.contentView.frame) - 15*2, CGRectGetHeight(self.contentView.frame));
    self.wapperView.layer.borderColor  = HexRGB(colorB2).CGColor;
    self.wapperView.layer.borderWidth  = MRC_1PX_WIDTH;
    self.wapperView.layer.cornerRadius = 3;
    
    [self.readmeWapperViewBottomBorder removeFromSuperview];
    self.readmeWapperViewBottomBorder = [self.readmeWapperView createViewBackedBottomBorderWithHeight:MRC_1PX_WIDTH andColor:HexRGB(colorB2)];
    [self.readmeWapperView addSubview:self.readmeWapperViewBottomBorder];
    
    [self.readmeButtonTopBorder removeFromSuperview];
    self.readmeButtonTopBorder = [self.readmeButton createViewBackedTopBorderWithHeight:MRC_1PX_WIDTH andColor:HexRGB(colorB2)];
    [self.readmeButton addSubview:self.readmeButtonTopBorder];
}

@end
