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
@property (strong, nonatomic, readonly) OCTUser *user;

@property (copy, nonatomic, readonly) NSString *company;
@property (copy, nonatomic, readonly) NSString *location;
@property (copy, nonatomic, readonly) NSString *email;
@property (copy, nonatomic, readonly) NSString *blog;

// The view model of `Profile` interface.
@property (strong, nonatomic, readonly) MRCAvatarHeaderViewModel *avatarHeaderViewModel;

@end
