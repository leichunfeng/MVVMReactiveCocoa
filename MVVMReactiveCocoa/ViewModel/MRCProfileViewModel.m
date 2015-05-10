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
    
    self.currentUser = [OCTUser mrc_currentUser];
    self.avatarHeaderViewModel = [[MRCAvatarHeaderViewModel alloc] initWithUser:self.currentUser];
    
    @weakify(self)
    self.fetchUserInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [[self.services.client
        	fetchUserInfo]
         	doNext:^(OCTUser *user) {
            	@strongify(self)
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.currentUser mergeValuesForKeysFromModel:user];
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [self.currentUser mrc_saveOrUpdate];
                    });
                });
         	}];
    }];
    
    id (^mapEmptyValue)(NSString *) = ^id(NSString *value) {
        return value.length > 0 ? value : @"Not Set";
    };
    
    self.dataSource = @[
        @[
            @{ @"identifier": @"Organization", @"hexRGB": @(0x24AFFC), @"textSignal": [RACObserve(self.currentUser, company) map:mapEmptyValue] },
  			@{ @"identifier": @"Location", @"hexRGB": @(0x30C931), @"textSignal": [RACObserve(self.currentUser, location) map:mapEmptyValue] },
  			@{ @"identifier": @"Mail", @"hexRGB": @(0x5586ED), @"textSignal": [RACObserve(self.currentUser, email) map:mapEmptyValue] },
            @{ @"identifier": @"Link", @"hexRGB": @(0x90DD2F), @"textSignal": [RACObserve(self.currentUser, blog) map:mapEmptyValue] }
    	],
        @[ @{ @"identifier": @"Gear", @"hexRGB": @(0x24AFFC), @"textSignal": [RACSignal return:@"Settings"] } ]
    ];
    
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self)
        if (indexPath.section == 1 && indexPath.row == 0) {
            MRCSettingsViewModel *settingsViewModel = [[MRCSettingsViewModel alloc] initWithServices:self.services params:nil];
            [self.services pushViewModel:settingsViewModel animated:YES];
        }
        return [RACSignal empty];
    }];
    
    [self.fetchUserInfoCommand.errors subscribe:self.errors];
}

@end
