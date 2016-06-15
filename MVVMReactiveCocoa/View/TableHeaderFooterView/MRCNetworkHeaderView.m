//
//  MRCNetworkHeaderView.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/3/4.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCNetworkHeaderView.h"

@interface MRCNetworkHeaderView ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation MRCNetworkHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = HexRGB(0xFED6D7);
    self.imageView.image = [UIImage octicon_imageWithIcon:@"IssueOpened"
                                          backgroundColor:UIColor.clearColor
                                                iconColor:HexRGB(0xF1494D)
                                                iconScale:1
                                                  andSize:CGSizeMake(29, 29)];
}

@end
