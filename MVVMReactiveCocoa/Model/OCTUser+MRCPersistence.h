//
//  OCTUser+MRCPersistence.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <OctoKit/OctoKit.h>
#import "MRCPersistenceProtocol.h"

@interface OCTUser (MRCPersistence) <MRCPersistenceProtocol>

+ (NSString *)mrc_currentUserId;

// Retrieves the current `user`.
//
// Returns the current `user`.
+ (OCTUser *)mrc_currentUser;

// Retrieves the user by the given `rawLogin` property.
//
// rawLogin - `rawLogin` property
//
// Returns the user.
+ (OCTUser *)mrc_fetchUserWithRawLogin:(NSString *)rawLogin;

@end
