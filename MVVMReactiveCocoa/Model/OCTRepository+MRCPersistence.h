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

@property (nonatomic, assign) OCTRepositoryStarredStatus starredStatus;

+ (BOOL)mrc_saveOrUpdateRepositories:(NSArray *)repositories;
+ (BOOL)mrc_saveOrUpdateStarredStatusWithRepositories:(NSArray *)repositories;

+ (instancetype)mrc_fetchRepository:(OCTRepository *)repository;

+ (NSArray *)mrc_fetchUserRepositories;
+ (NSArray *)mrc_fetchUserRepositoriesWithKeyword:(NSString *)keyword;
+ (NSArray *)mrc_fetchUserStarredRepositories;
+ (NSArray *)mrc_fetchUserStarredRepositoriesWithKeyword:(NSString *)keyword;
+ (NSArray *)mrc_fetchUserStarredRepositoriesWithPage:(NSUInteger)page perPage:(NSUInteger)perPage;
+ (NSArray *)mrc_fetchUserPublicRepositoriesWithPage:(NSUInteger)page perPage:(NSUInteger)perPage;

+ (BOOL)mrc_hasUserStarredRepository:(OCTRepository *)repository;
+ (BOOL)mrc_starRepository:(OCTRepository *)repository;
+ (BOOL)mrc_unstarRepository:(OCTRepository *)repository;

+ (NSArray *)mrc_matchStarredStatusForRepositories:(NSArray *)repositories;

@end
