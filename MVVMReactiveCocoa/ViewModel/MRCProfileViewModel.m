//
//  MRCProfileViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/7.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCProfileViewModel.h"
#import "MRCAvatarHeaderViewModel.h"

@implementation MRCProfileViewModel

- (void)initialize {
    [super initialize];
    
    self.title = @"Profile";
    
    self.currentUser = OCTUser.currentUser;
    self.avatarHeaderViewModel = [[MRCAvatarHeaderViewModel alloc] initWithUser:self.currentUser];
    
    @weakify(self)
    self.fetchUserInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[[self.services.client
        	fetchUserInfo]
        	deliverOnMainThread]
         	doNext:^(OCTUser *user) {
            	@strongify(self)
            	[self.currentUser mergeValuesForKeysFromModel:user];
             	[self.currentUser save];
         	}];
    }];
    
    self.dataSource = @[
        @[
  			@{ @"title": @"Events", @"identifier": @"Unmute" },
  			@{ @"title": @"Issues", @"identifier": @"IssueOpened" },
  			@{ @"title": @"Notifications", @"identifier": @"Inbox" }
    	],
        @[ @{ @"title": @"Organizations", @"identifier": @"Organization" } ],
        @[ @{ @"title": @"About", @"identifier": @"Info" } ]
    ];
    
    [self.fetchUserInfoCommand.errors subscribe:self.errors];
}

@end
