//
//  MRCRepoSettingsOwnerTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/15.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoSettingsOwnerTableViewCell.h"

@interface MRCRepoSettingsOwnerTableViewCell ()

@property (weak, nonatomic, readwrite) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic, readwrite) IBOutlet UIButton *avatarButton;
@property (weak, nonatomic, readwrite) IBOutlet UILabel *topTextLabel;
@property (weak, nonatomic, readwrite) IBOutlet UILabel *bottomTextLabel;

@end

@implementation MRCRepoSettingsOwnerTableViewCell

- (void)awakeFromNib {
    self.avatarImageView.layer.cornerRadius = 5;
    self.avatarImageView.clipsToBounds = YES;
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImageView.backgroundColor = HexRGB(colorI6);
}

@end
