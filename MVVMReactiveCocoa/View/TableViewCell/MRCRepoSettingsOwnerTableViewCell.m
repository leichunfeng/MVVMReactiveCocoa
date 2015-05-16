//
//  MRCRepoSettingsOwnerTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/15.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoSettingsOwnerTableViewCell.h"

@implementation MRCRepoSettingsOwnerTableViewCell

- (void)awakeFromNib {
    self.avatarImageView.layer.cornerRadius = 5;
    self.avatarImageView.clipsToBounds = YES;
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
}

@end
