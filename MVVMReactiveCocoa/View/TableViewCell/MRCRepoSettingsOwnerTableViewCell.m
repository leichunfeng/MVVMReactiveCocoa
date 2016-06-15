//
//  MRCRepoSettingsOwnerTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/15.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoSettingsOwnerTableViewCell.h"

@interface MRCRepoSettingsOwnerTableViewCell ()

@property (nonatomic, weak, readwrite) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak, readwrite) IBOutlet UIButton *avatarButton;
@property (nonatomic, weak, readwrite) IBOutlet UILabel *topTextLabel;
@property (nonatomic, weak, readwrite) IBOutlet UILabel *bottomTextLabel;

@end

@implementation MRCRepoSettingsOwnerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.avatarImageView.layer.cornerRadius  = 5;
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImageView.backgroundColor = HexRGB(colorI6);
}

@end
