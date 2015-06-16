//
//  MRCUserListViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/8.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCTableViewModel.h"

typedef NS_ENUM(NSUInteger, MRCUserListViewModelType) {
    MRCUserListViewModelTypeFollowers,
    MRCUserListViewModelTypeFollowing
};

@interface MRCUserListViewModel : MRCTableViewModel

@property (assign, nonatomic, readonly) MRCUserListViewModelType type;
@property (assign, nonatomic, readonly) BOOL isCurrentUser;
@property (copy, nonatomic) NSArray *users;

@end
