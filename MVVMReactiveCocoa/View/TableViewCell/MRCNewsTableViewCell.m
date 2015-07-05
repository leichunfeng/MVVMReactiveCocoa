//
//  MRCNewsTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/5.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCNewsTableViewCell.h"
#import "MRCNewsItemViewModel.h"

@interface MRCNewsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *actionImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *detailView;

@end

@implementation MRCNewsTableViewCell

- (void)awakeFromNib {
    self.avatarImageView.backgroundColor = HexRGB(colorI6);
}

- (void)bindViewModel:(MRCNewsItemViewModel *)viewModel {
    [self.avatarImageView sd_setImageWithURL:viewModel.event.actorAvatarURL];
    
    self.nameLabel.text = viewModel.event.actorLogin;
    
    self.actionImageView.image = [UIImage octicon_imageWithIcon:@"Star" backgroundColor:[UIColor clearColor] iconColor:HexRGB(0xbbbbbb) iconScale:1 andSize:self.actionImageView.frame.size];
}

@end
