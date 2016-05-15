//
//  MRCLoginViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCViewModel.h"

@interface MRCLoginViewModel : MRCViewModel

/// The avatar URL of the user.
@property (nonatomic, copy, readonly) NSURL *avatarURL;

/// The username entered by the user.
@property (nonatomic, copy) NSString *username;

/// The password entered by the user.
@property (nonatomic, copy) NSString *password;

@property (nonatomic, strong, readonly) RACSignal *validLoginSignal;

/// The command of login button.
@property (nonatomic, strong, readonly) RACCommand *loginCommand;

/// The command of uses browser to login button.
@property (nonatomic, strong, readonly) RACCommand *browserLoginCommand;
@property (nonatomic, strong, readonly) RACCommand *exchangeTokenCommand;

@end
