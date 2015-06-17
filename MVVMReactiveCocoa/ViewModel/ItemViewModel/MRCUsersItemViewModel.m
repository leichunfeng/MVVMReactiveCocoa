//
//  MRCUsersItemViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/8.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCUsersItemViewModel.h"

@interface MRCUsersItemViewModel ()

@property (strong, nonatomic, readwrite) OCTUser *user;
@property (strong, nonatomic, readwrite) NSURL *avatarURL;
@property (copy, nonatomic, readwrite) NSString *login;

@end

@implementation MRCUsersItemViewModel

- (instancetype)initWithUser:(OCTUser *)user {
    self = [super init];
    if (self) {
        self.user = user;
        self.avatarURL = user.avatarURL;
        self.login = user.login;
        self.followingStatus = user.followingStatus;
    }
    return self;
}

@end
