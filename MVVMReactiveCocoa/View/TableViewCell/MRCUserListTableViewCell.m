//
//  MRCUserListTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/8.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCUserListTableViewCell.h"
#import "MRCUserListItemViewModel.h"

@interface MRCUserListTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) UIButton *operationButton;

@property (strong, nonatomic) MRCUserListItemViewModel *viewModel;

@end

@implementation MRCUserListTableViewCell

- (void)awakeFromNib {
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    self.operationButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.operationButton setTitleColor:HexRGB(colorI3) forState:UIControlStateNormal];
    [self.operationButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [self.operationButton addTarget:self action:@selector(didClickOperationButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)bindViewModel:(MRCUserListItemViewModel *)viewModel {
    self.viewModel = viewModel;
    
    [self.avatarImageView sd_setImageWithURL:viewModel.avatarURL];
    self.loginLabel.text = viewModel.login;
    
    @weakify(self)
    [[RACObserve(viewModel, followingStatus)
        doNext:^(NSNumber *followingStatus) {
            @strongify(self)
            self.operationButton.selected = (followingStatus.unsignedIntegerValue == OCTUserFollowingStatusYES);
        }]
        subscribeNext:^(NSNumber *followingStatus) {
            @strongify(self)
            if (followingStatus.unsignedIntegerValue == OCTUserFollowingStatusUnknown) {
                self.accessoryView = self.activityIndicatorView;
            } else {
                self.accessoryView = self.operationButton;
            }
        }];
}

- (void)didClickOperationButton:(UIButton *)operationButton {
    if (self.viewModel.followingStatus == OCTUserFollowingStatusYES) {
        self.viewModel.followingStatus = OCTUserFollowingStatusNO;
    } else if (self.viewModel.followingStatus == OCTUserFollowingStatusNO) {
        self.viewModel.followingStatus = OCTUserFollowingStatusYES;
    }
    [self.viewModel.operationCommand execute:self.viewModel];
}

@end
