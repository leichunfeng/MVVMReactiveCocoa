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

/// The current `user`.
@property (nonatomic, strong, readonly) OCTUser *user;

@property (nonatomic, copy, readonly) NSString *company;
@property (nonatomic, copy, readonly) NSString *location;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy, readonly) NSString *blog;

/// The view model of `Profile` interface.
@property (nonatomic, strong, readonly) MRCAvatarHeaderViewModel *avatarHeaderViewModel;

@end
