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
@property (strong, nonatomic) NSURL *avatarURL;

// The username entered by the user.
@property (strong, nonatomic) NSString *username;

// The password entered by the user.
@property (strong, nonatomic) NSString *password;

@property (strong, nonatomic) RACSignal *validLoginSignal;

// The command of login button.
@property (strong, nonatomic) RACCommand *loginCommand;

// The command of uses browser to login button.
@property (strong, nonatomic) RACCommand *browserLoginCommand;

@end
