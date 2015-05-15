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
    self.avatarButton.imageView.layer.cornerRadius = 5;
    self.avatarButton.imageView.clipsToBounds = YES;
    self.avatarButton.imageView.frame = self.avatarButton.bounds;
    self.avatarButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
}

@end
