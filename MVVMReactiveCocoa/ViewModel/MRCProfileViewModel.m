//
//  MRCProfileViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/7.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCProfileViewModel.h"
#import "MRCAvatarHeaderViewModel.h"
#import "MRCSettingsViewModel.h"

@implementation MRCProfileViewModel

- (void)initialize {
    [super initialize];
    
    self.title = @"Profile";
    
    self.currentUser = OCTUser.currentUser;
    self.avatarHeaderViewModel = [[MRCAvatarHeaderViewModel alloc] initWithUser:self.currentUser];
    
    @weakify(self)
    self.fetchUserInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [[[[self.services.client
        	fetchUserInfo]
        	deliverOnMainThread]
         	doNext:^(OCTUser *user) {
            	@strongify(self)
            	[self.currentUser mergeValuesForKeysFromModel:user];
             	[self.currentUser save];
         	}]
            takeUntil:self.willDisappearSignal];
    }];
    
    self.dataSource = @[
        @[
            @{ @"identifier": @"Organization", @"textSignal": RACObserve(self.currentUser, company) },
  			@{ @"identifier": @"Location", @"textSignal": RACObserve(self.currentUser, location) },
  			@{ @"identifier": @"Mail", @"textSignal": RACObserve(self.currentUser, email) },
            @{ @"identifier": @"Link", @"textSignal": RACObserve(self.currentUser, blog) }
    	],
        @[ @{ @"identifier": @"Gear", @"textSignal": [RACSignal return:@"Settings"] } ]
    ];
    
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self)
        if (indexPath.section == 1 && indexPath.row == 0) {
            MRCSettingsViewModel *settingsViewModel = [[MRCSettingsViewModel alloc] initWithServices:self.services params:nil];
            [self.services pushViewModel:settingsViewModel animated:YES];
        }
        return RACSignal.empty;
    }];
    
    [self.fetchUserInfoCommand.errors subscribe:self.errors];
}

@end
