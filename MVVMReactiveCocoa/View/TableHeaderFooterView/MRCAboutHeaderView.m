//
//  MRCAboutHeaderView.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/3/4.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCAboutHeaderView.h"

@interface MRCAboutHeaderView ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *textLabel;

@end

@implementation MRCAboutHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageView.image = [UIImage octicon_imageWithIcon:@"GitMerge" backgroundColor:UIColor.clearColor iconColor:HexRGB(colorI2) iconScale:1 andSize:self.imageView.frame.size];
    self.textLabel.text = [NSString stringWithFormat:@"%@ v%@ (%@)", MRC_APP_NAME, MRC_APP_VERSION, MRC_APP_BUILD];
}

@end
