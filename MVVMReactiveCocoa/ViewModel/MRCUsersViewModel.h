//
//  MRCUsersViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/8.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCTableViewModel.h"

typedef NS_ENUM(NSUInteger, MRCUsersViewModelType) {
    MRCUsersViewModelTypeFollowers,
    MRCUsersViewModelTypeFollowing
};

@interface MRCUsersViewModel : MRCTableViewModel

@property (assign, nonatomic, readonly) MRCUsersViewModelType type;
@property (copy, nonatomic) NSArray *users;

@end
