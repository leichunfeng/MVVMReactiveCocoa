//
//  MRCUsersTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/8.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCUsersTableViewCell.h"
#import "MRCUsersItemViewModel.h"

@interface MRCUsersTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;

@end

@implementation MRCUsersTableViewCell

- (void)bindViewModel:(MRCUsersItemViewModel *)viewModel {
    [self.avatarImageView sd_setImageWithURL:viewModel.avatarURL];
    self.loginLabel.text = viewModel.login;
}

@end
