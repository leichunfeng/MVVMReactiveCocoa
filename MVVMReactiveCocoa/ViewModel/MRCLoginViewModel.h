//
//  MRCLoginViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCViewModel.h"

@interface MRCLoginViewModel : MRCViewModel

// The avatar URL of the user.
@property (copy, nonatomic, readonly) NSURL *avatarURL;

// The username entered by the user.
@property (copy, nonatomic) NSString *username;

// The password entered by the user.
@property (copy, nonatomic) NSString *password;

@property (strong, nonatomic, readonly) RACSignal *validLoginSignal;

// The command of login button.
@property (strong, nonatomic, readonly) RACCommand *loginCommand;

// The command of uses browser to login button.
@property (strong, nonatomic, readonly) RACCommand *browserLoginCommand;

@end
