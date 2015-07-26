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
@property (weak, nonatomic) IBOutlet UILabel *htmlLabel;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) IBOutlet MRCFollowButton *operationButton;

@property (strong, nonatomic) MRCUserListItemViewModel *viewModel;

@end

@implementation MRCUserListTableViewCell

- (void)awakeFromNib {
    self.avatarImageView.backgroundColor = HexRGB(colorI6);
}

- (void)bindViewModel:(MRCUserListItemViewModel *)viewModel {
    self.viewModel = viewModel;
    
    [self.avatarImageView sd_setImageWithURL:viewModel.avatarURL];
    
    self.loginLabel.text = viewModel.login;
    self.htmlLabel.text  = viewModel.user.HTMLURL.absoluteString;
    
    [self.activityIndicatorView startAnimating];
    
    @weakify(self)
    [[[RACObserve(viewModel.user, followingStatus)
        deliverOnMainThread]
        takeUntil:self.rac_prepareForReuseSignal]
        subscribeNext:^(NSNumber *followingStatus) {
            @strongify(self)
            self.operationButton.selected = (followingStatus.unsignedIntegerValue == OCTUserFollowingStatusYES);
            self.activityIndicatorView.hidden = (followingStatus.unsignedIntegerValue != OCTUserFollowingStatusUnknown);
            self.operationButton.hidden = (followingStatus.unsignedIntegerValue == OCTUserFollowingStatusUnknown);
        }];
}

- (IBAction)didClickOperationButton:(id)sender {
    self.operationButton.enabled = NO;
    
    @weakify(self)
    [[[self.viewModel.operationCommand
        execute:self.viewModel]
        deliverOnMainThread]
        subscribeCompleted:^{
            @strongify(self)
            self.operationButton.enabled = YES;
        }];
}

@end
