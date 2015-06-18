//
//  MRCAvatarHeaderViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRCAvatarHeaderViewModel : NSObject

// The contentOffset of the scroll view.
@property (assign, nonatomic) CGPoint contentOffset;

// The avatar URL of the current `user`.
@property (strong, nonatomic) NSURL *avatarURL;

// The name of the current `user`.
@property (copy, nonatomic) NSString *name;

// The number of followers.
@property (copy, nonatomic) NSString *followers;

// The number of public repositories owned by this account.
@property (copy, nonatomic) NSString *repositories;

// The number of following.
@property (copy, nonatomic) NSString *following;

@property (strong, nonatomic) RACCommand *followersCommand;
@property (strong, nonatomic) RACCommand *repositoriesCommand;
@property (strong, nonatomic) RACCommand *followingCommand;

- (instancetype)initWithUser:(OCTUser *)user;

@end
