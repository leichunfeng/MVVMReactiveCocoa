//
//  OCTUser+MRCPersistence.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <OctoKit/OctoKit.h>
#import "MRCPersistenceProtocol.h"

@interface OCTUser (Persistence) <MRCPersistenceProtocol>

// Retrieves the current `user`.
//
// Returns the current `user`.
+ (OCTUser *)currentUser;

// Retrieves the `rawLogin` property of the current `user`.
//
// Returns the `rawLogin` property.
+ (NSString *)rawLoginOfCurrentUser;

// Retrieves the user by the given `rawLogin` property.
//
// rawLogin - `rawLogin` property
//
// Returns the user.
+ (OCTUser *)fetchWithRawLogin:(NSString *)rawLogin;

@end
