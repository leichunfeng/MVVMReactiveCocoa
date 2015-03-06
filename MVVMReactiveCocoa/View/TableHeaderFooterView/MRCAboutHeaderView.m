//
//  MRCAboutHeaderView.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/3/4.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCAboutHeaderView.h"

@interface MRCAboutHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation MRCAboutHeaderView

- (void)awakeFromNib {
    self.imageView.image = [UIImage octicon_imageWithIcon:@"MarkGithub" backgroundColor:UIColor.clearColor iconColor:HexRGB(colorI2) iconScale:1 andSize:self.imageView.frame.size];
    self.textLabel.text = [NSString stringWithFormat:@"iGitHub v%@", MRC_APP_VERSION];
}

@end
