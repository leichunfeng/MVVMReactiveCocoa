//
//  MRCProfileViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/7.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCTableViewModel.h"
#import "MRCAvatarHeaderViewModel.h"

@interface MRCProfileViewModel : MRCTableViewModel

// The current `user`.
@property (strong, nonatomic) OCTUser *user;

@property (strong, nonatomic, readonly) NSString *company;
@property (strong, nonatomic, readonly) NSString *location;
@property (strong, nonatomic, readonly) NSString *email;
@property (strong, nonatomic, readonly) NSString *blog;

// The view model of `Profile` interface.
@property (strong, nonatomic) MRCAvatarHeaderViewModel *avatarHeaderViewModel;

@end
