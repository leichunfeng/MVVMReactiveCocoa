//
//  MRCUserListItemViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/8.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCUserListItemViewModel.h"

@interface MRCUserListItemViewModel ()

@property (nonatomic, strong, readwrite) OCTUser *user;

@property (nonatomic, copy, readwrite) NSURL *avatarURL;
@property (nonatomic, copy, readwrite) NSString *login;

@end

@implementation MRCUserListItemViewModel

- (instancetype)initWithUser:(OCTUser *)user {
    self = [super init];
    if (self) {
        self.user = user;
        self.avatarURL = user.avatarURL;
        self.login = user.login;
    }
    return self;
}

@end
