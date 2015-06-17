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
@property (weak, nonatomic) IBOutlet UIButton *operationButton;
@property (strong, nonatomic) MRCUsersItemViewModel *viewModel;

@end

@implementation MRCUsersTableViewCell

- (void)awakeFromNib {
    [self.operationButton setTitleColor:HexRGB(colorI3) forState:UIControlStateNormal];
    [self.operationButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
}

- (void)bindViewModel:(MRCUsersItemViewModel *)viewModel {
    self.viewModel = viewModel;
    
    [self.avatarImageView sd_setImageWithURL:viewModel.avatarURL];
    self.loginLabel.text = viewModel.login;
    
    [self.operationButton addTarget:self action:@selector(didClickOperationButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didClickOperationButton:(UIButton *)operationButton {
    self.viewModel.followingStatus = !self.viewModel.followingStatus;
    operationButton.selected = self.viewModel.followingStatus;
    [self.viewModel.operationCommand execute:self.viewModel];
}

@end
