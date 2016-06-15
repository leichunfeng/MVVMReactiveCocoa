//
//  MRCRepoReadmeTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/22.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoReadmeTableViewCell.h"

@interface MRCRepoReadmeTableViewCell () <UIWebViewDelegate>

@property (nonatomic, weak, readwrite) IBOutlet UIButton *readmeButton;
@property (nonatomic, weak, readwrite) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, weak, readwrite) IBOutlet UIWebView *webView;

@property (nonatomic, weak) IBOutlet UIImageView *readmeImageView;
@property (nonatomic, weak) IBOutlet UIView *wapperView;
@property (nonatomic, weak) IBOutlet UIView *readmeWapperView;

@end

@implementation MRCRepoReadmeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.readmeImageView.image = [UIImage octicon_imageWithIdentifier:@"Book" size:CGSizeMake(22, 22)];
    self.readmeButton.tintColor = HexRGB(colorI3);

    [self.activityIndicatorView startAnimating];
    
    UIView *readmeWapperViewBottomBorder = [self.readmeWapperView createViewBackedBottomBorderWithHeight:MRC_1PX_WIDTH andColor:HexRGB(colorB2)];
    [self.readmeWapperView addSubview:readmeWapperViewBottomBorder];
    
    UIView *readmeButtonTopBorder = [self.readmeButton createViewBackedTopBorderWithHeight:MRC_1PX_WIDTH andColor:HexRGB(colorB2)];
    [self.readmeButton addSubview:readmeButtonTopBorder];
    
    [RACObserve(self, frame) subscribeNext:^(id x) {
        CGRect frame = [x CGRectValue];
        
        CGRect borderFrame1 = readmeWapperViewBottomBorder.frame;
        borderFrame1.size.width = frame.size.width - 30;
        readmeWapperViewBottomBorder.frame = borderFrame1;
        
        CGRect borderFrame2 = readmeButtonTopBorder.frame;
        borderFrame2.size.width = frame.size.width - 30;
        readmeButtonTopBorder.frame = borderFrame2;
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.wapperView.frame = CGRectMake(15, 0, CGRectGetWidth(self.contentView.frame) - 15*2, CGRectGetHeight(self.contentView.frame));
    self.wapperView.layer.borderColor  = HexRGB(colorB2).CGColor;
    self.wapperView.layer.borderWidth  = MRC_1PX_WIDTH;
    self.wapperView.layer.cornerRadius = 3;
}

@end
