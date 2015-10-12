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

@property (nonatomic, assign, readonly) MRCUserListViewModelType type;
@property (nonatomic, assign, readonly) BOOL isCurrentUser;
@property (nonatomic, copy, readonly) NSArray *users;

@end
