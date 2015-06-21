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
    self.avatarImageView.layer.cornerRadius = 5;
    self.avatarImageView.clipsToBounds = YES;
}

- (void)bindViewModel:(MRCUserListItemViewModel *)viewModel {
    self.viewModel = viewModel;
    
    [self.avatarImageView setImageWithURL:viewModel.avatarURL usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    self.loginLabel.text = viewModel.login;
    self.htmlLabel.text = viewModel.user.HTMLURL.absoluteString;
    
    @weakify(self)
    [[[[RACObserve(viewModel.user, followingStatus)
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
                self.operationButton.hidden = YES;
                self.activityIndicatorView.hidden = NO;
            } else {
                self.activityIndicatorView.hidden = YES;
                self.operationButton.hidden = NO;
            }
        }];
}

- (IBAction)didClickOperationButton:(id)sender {
    [self.viewModel.operationCommand execute:self.viewModel];
}

@end
