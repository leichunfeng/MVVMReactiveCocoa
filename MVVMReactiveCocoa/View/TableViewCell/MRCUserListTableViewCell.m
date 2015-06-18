//
//  MRCUserListTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/8.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCUserListTableViewCell.h"
#import "MRCUserListItemViewModel.h"
#import "MRCFollowButton.h"

@interface MRCUserListTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) MRCFollowButton *operationButton;

@property (strong, nonatomic) MRCUserListItemViewModel *viewModel;

@end

@implementation MRCUserListTableViewCell

- (void)awakeFromNib {
    self.avatarImageView.backgroundColor = HexRGB(0xEFEDEA);
    self.avatarImageView.layer.cornerRadius = 5;
    self.avatarImageView.clipsToBounds = YES;
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    self.operationButton = [[MRCFollowButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [self.operationButton addTarget:self action:@selector(didClickOperationButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)bindViewModel:(MRCUserListItemViewModel *)viewModel {
    self.viewModel = viewModel;
    
    [self.avatarImageView sd_setImageWithURL:viewModel.avatarURL];
    self.loginLabel.text = viewModel.login;
    
    @weakify(self)
    [[[[RACObserve(viewModel, followingStatus)
       	takeUntil:viewModel.rac_willDeallocSignal]
      	deliverOnMainThread]
        doNext:^(NSNumber *followingStatus) {
            @strongify(self)
            [self.activityIndicatorView startAnimating];
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
