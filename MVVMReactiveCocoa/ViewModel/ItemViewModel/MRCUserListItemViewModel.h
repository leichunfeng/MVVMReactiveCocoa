//
//  MRCUserListItemViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/8.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRCUserListItemViewModel : NSObject

@property (strong, nonatomic, readonly) OCTUser *user;

@property (copy, nonatomic, readonly) NSURL *avatarURL;
@property (copy, nonatomic, readonly) NSString *login;

@property (strong, nonatomic) RACCommand *operationCommand;

- (instancetype)initWithUser:(OCTUser *)user;

@end
