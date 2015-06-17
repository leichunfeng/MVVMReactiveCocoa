//
//  MRCProfileViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/7.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCProfileViewModel.h"
#import "MRCSettingsViewModel.h"
#import "MRCUserListViewModel.h"

@implementation MRCProfileViewModel

- (void)initialize {
    [super initialize];
    
    self.title = @"Profile";
    
    self.user = self.user ?: [OCTUser mrc_currentUser];
    self.avatarHeaderViewModel = [[MRCAvatarHeaderViewModel alloc] initWithUser:self.user];
    
    self.avatarHeaderViewModel.followersCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        MRCUserListViewModel *viewModel = [[MRCUserListViewModel alloc] initWithServices:self.services
                                                                                  params:@{ @"type": @0, @"user": self.user }];
        [self.services pushViewModel:viewModel animated:YES];
        return [RACSignal empty];
    }];

    self.avatarHeaderViewModel.followingCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        MRCUserListViewModel *viewModel = [[MRCUserListViewModel alloc] initWithServices:self.services
                                                                                  params:@{ @"type": @1, @"user": self.user }];
        [self.services pushViewModel:viewModel animated:YES];
        return [RACSignal empty];
    }];
    
    id (^mapEmptyValue)(NSString *) = ^id(NSString *value) {
        return value.length > 0 ? value : @"Not Set";
    };
    
    self.dataSource = @[
        @[
            @{ @"identifier": @"Organization", @"hexRGB": @(0x24AFFC), @"textSignal": [RACObserve(self.user, company) map:mapEmptyValue] },
  			@{ @"identifier": @"Location", @"hexRGB": @(0x30C931), @"textSignal": [RACObserve(self.user, location) map:mapEmptyValue] },
  			@{ @"identifier": @"Mail", @"hexRGB": @(0x5586ED), @"textSignal": [RACObserve(self.user, email) map:mapEmptyValue] },
            @{ @"identifier": @"Link", @"hexRGB": @(0x90DD2F), @"textSignal": [RACObserve(self.user, blog) map:mapEmptyValue] }
    	],
        @[ @{ @"identifier": @"Gear", @"hexRGB": @(0x24AFFC), @"textSignal": [RACSignal return:@"Settings"] } ]
    ];
    
    @weakify(self)
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self)
        if (indexPath.section == 1 && indexPath.row == 0) {
            MRCSettingsViewModel *settingsViewModel = [[MRCSettingsViewModel alloc] initWithServices:self.services params:nil];
            [self.services pushViewModel:settingsViewModel animated:YES];
        }
        return [RACSignal empty];
    }];
    
    [self.requestRemoteDataCommand.errors subscribe:self.errors];
}

- (RACSignal *)requestRemoteDataSignal {
    return [[self.services.client
    	fetchUserInfo]
        doNext:^(OCTUser *user) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.user mergeValuesForKeysFromModel:user];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self.user mrc_saveOrUpdate];
                });
            });
        }];
}

@end
