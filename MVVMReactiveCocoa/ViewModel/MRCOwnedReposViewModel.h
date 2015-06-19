//
//  MRCOwnedReposViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCTableViewModel.h"

typedef NS_ENUM(NSUInteger, MRCReposViewModelType) {
    MRCReposViewModelTypeOwned,
    MRCReposViewModelTypeStarred,
    MRCReposViewModelTypeSearch,
    MRCReposViewModelTypePublic
};

@interface MRCOwnedReposViewModel : MRCTableViewModel

@property (strong, nonatomic, readonly) OCTUser *user;
@property (assign, nonatomic, readonly) BOOL isCurrentUser;
@property (copy, nonatomic) NSArray *repositories;
@property (assign, nonatomic, readonly) MRCReposViewModelType type;

@end
