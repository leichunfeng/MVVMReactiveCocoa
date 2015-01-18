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
    
    self.avatarHeaderViewModel = [MRCAvatarHeaderViewModel new];
    self.currentUser = [OCTUser currentUser];
    
    RAC(self.avatarHeaderViewModel, avatarURL) = RACObserve(self.currentUser, avatarURL);
    RAC(self.avatarHeaderViewModel, name) = RACObserve(self.currentUser, name);
    RAC(self.avatarHeaderViewModel, followers) = [RACObserve(self.currentUser, followers) map:^id(NSNumber *followers) {
        return [followers stringValue];
    }];
    RAC(self.avatarHeaderViewModel, repositories) = [RACObserve(self.currentUser, publicRepoCount) map:^id(NSNumber *publicRepoCount) {
        return [publicRepoCount stringValue];
    }];
    RAC(self.avatarHeaderViewModel, following) = [RACObserve(self.currentUser, following) map:^id(NSNumber *following) {
        return [following stringValue];
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
}

@end
