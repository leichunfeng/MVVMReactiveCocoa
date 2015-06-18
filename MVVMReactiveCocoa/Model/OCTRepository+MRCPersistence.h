//
//  OCTRepository+MRCPersistence.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <OctoKit/OctoKit.h>
#import "MRCPersistenceProtocol.h"

typedef NS_ENUM(NSUInteger, OCTRepositoryStarredStatus) {
    OCTRepositoryStarredStatusUnknown,
    OCTRepositoryStarredStatusYES,
    OCTRepositoryStarredStatusNO
};

@interface OCTRepository (MRCPersistence) <MRCPersistenceProtocol>

@property (assign, nonatomic) OCTRepositoryStarredStatus starredStatus;

+ (BOOL)mrc_saveOrUpdateRepositories:(NSArray *)repositories;
+ (BOOL)mrc_saveOrUpdateStarredStatusWithRepositories:(NSArray *)repositories;

+ (NSArray *)mrc_fetchUserRepositoriesWithPage:(NSUInteger)page perPage:(NSUInteger)perPage;
+ (NSArray *)mrc_fetchUserStarredRepositoriesWithPage:(NSUInteger)page perPage:(NSUInteger)perPage;

+ (BOOL)mrc_hasUserStarredRepository:(OCTRepository *)repository;
+ (BOOL)mrc_starRepository:(OCTRepository *)repository;
+ (BOOL)mrc_unstarRepository:(OCTRepository *)repository;

+ (NSArray *)matchStarredStatusForRepositories:(NSArray *)repositories;

@end
