//
//  OCTRepository+MRCPersistence.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <OctoKit/OctoKit.h>
#import "MRCPersistenceProtocol.h"

extern const void *OCTRepositoryStarredKey;

@interface OCTRepository (Persistence) <MRCPersistenceProtocol>

// Retrieves the repositories of the current `user` from disk.
//
// Returns the repositories.
+ (NSArray *)fetchUserRepositories;

@end
