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

@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *loginLabel;
@property (nonatomic, weak) IBOutlet UILabel *htmlLabel;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, weak) IBOutlet MRCFollowButton *operationButton;

@property (nonatomic, strong) MRCUserListItemViewModel *viewModel;

@end

@implementation MRCUserListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.avatarImageView.backgroundColor = HexRGB(colorI6);
    
    RACSignal *operationCommandSignal = RACObserve(self, viewModel.operationCommand);
    RACSignal *followingStatusSignal  = RACObserve(self, viewModel.user.followingStatus).deliverOnMainThread;
    
    RACSignal *combinedSignal = [RACSignal combineLatest:@[ operationCommandSignal, followingStatusSignal ]];
    
    RAC(self.activityIndicatorView, hidden) = [combinedSignal reduceEach:^(RACCommand *operationCommand, NSNumber *followingStatus) {
        if (operationCommand == nil) return @YES;
        if (followingStatus.unsignedIntegerValue != OCTUserFollowingStatusUnknown) return @YES;
        return @NO;
    }];
    
    RAC(self.operationButton, hidden) = [combinedSignal reduceEach:^(RACCommand *operationCommand, NSNumber *followingStatus) {
        if (operationCommand == nil) return @YES;
        if (followingStatus.unsignedIntegerValue == OCTUserFollowingStatusUnknown) return @YES;
        return @NO;
    }];
    
    RAC(self.operationButton, selected) = [followingStatusSignal map:^(NSNumber *followingStatus) {
        return followingStatus.unsignedIntegerValue == OCTUserFollowingStatusYES ? @YES : @NO;
    }];
}

- (void)bindViewModel:(MRCUserListItemViewModel *)viewModel {
    self.viewModel = viewModel;
    
    [self.avatarImageView sd_setImageWithURL:viewModel.avatarURL];
    
    self.loginLabel.text = viewModel.login;
    self.htmlLabel.text  = viewModel.user.HTMLURL.absoluteString;
    
    if (!self.activityIndicatorView.isAnimating) {
        [self.activityIndicatorView startAnimating];
    }
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
