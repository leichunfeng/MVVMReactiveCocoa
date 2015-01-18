//
//  OCTRepository+MRCPersistence.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <OctoKit/OctoKit.h>
#import "MRCPersistenceProtocol.h"

@interface OCTRepository (Persistence) <MRCPersistenceProtocol>

// Retrieves the repositories of the current `user` from disk.
//
// Returns the repositories.
+ (RACSignal *)fetchUserRepositories;

// Retrieves the starred repositories of the current `user` from disk.
//
// Returns the starred repositories.
+ (RACSignal *)fetchUserStarredRepositories;

// Get method, retrieves the star flag of this repository.
//
// Returns the star flag.
- (BOOL)isStarred;

// Set method, setting the star flag of this repository.
//
// starred - The star flag
- (void)setStarred:(BOOL)starred;

@end
