//
//  MRCUserListItemViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/8.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRCUserListItemViewModel : NSObject

@property (nonatomic, strong, readonly) OCTUser *user;

@property (nonatomic, copy, readonly) NSURL *avatarURL;
@property (nonatomic, copy, readonly) NSString *login;

@property (nonatomic, strong) RACCommand *operationCommand;

- (instancetype)initWithUser:(OCTUser *)user;

@end
