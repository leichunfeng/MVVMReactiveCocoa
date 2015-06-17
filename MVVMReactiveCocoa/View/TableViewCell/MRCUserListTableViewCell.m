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
    
    self.operationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.operationButton setTitle:@"Follow" forState:UIControlStateNormal];
    [self.operationButton setTitle:@"Unollow" forState:UIControlStateSelected];
    
    [self.operationButton setTitleColor:HexRGB(colorB0) forState:UIControlStateNormal];
    [self.operationButton setTitleColor:HexRGB(colorB5) forState:UIControlStateSelected];
    
    [self.operationButton setImage:[UIImage octicon_imageWithIdentifier:@"Person" size:CGSizeMake(15, 15)]
                          forState:UIControlStateNormal];
    
    [self.operationButton setBackgroundImage:[UIImage octicon_imageWithIdentifier:@"Plus" size:CGSizeMake(15, 15)]
                                    forState:UIControlStateNormal];
    
    self.operationButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.operationButton.backgroundColor = HexRGB(colorA11);
    self.operationButton.layer.borderColor = HexRGB(0xcccccc).CGColor;
    self.operationButton.layer.borderWidth = MRC_1PX_WIDTH;
    
    self.operationButton.layer.cornerRadius = 3;
    self.operationButton.contentEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    
    [self.operationButton sizeToFit];
    
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
