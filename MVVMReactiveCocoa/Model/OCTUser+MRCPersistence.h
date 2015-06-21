//
//  OCTUser+MRCPersistence.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <OctoKit/OctoKit.h>
#import "MRCPersistenceProtocol.h"

typedef NS_ENUM(NSUInteger, OCTUserFollowerStatus) {
    OCTUserFollowerStatusUnknown,
    OCTUserFollowerStatusYES,
    OCTUserFollowerStatusNO
};

typedef NS_ENUM(NSUInteger, OCTUserFollowingStatus) {
    OCTUserFollowingStatusUnknown,
    OCTUserFollowingStatusYES,
    OCTUserFollowingStatusNO
};

@interface OCTUser (MRCPersistence) <MRCPersistenceProtocol>

@property (assign, nonatomic) OCTUserFollowerStatus followerStatus;
@property (assign, nonatomic) OCTUserFollowingStatus followingStatus;

+ (BOOL)mrc_saveOrUpdateUsers:(NSArray *)users;
+ (BOOL)mrc_saveOrUpdateFollowerStatusWithUsers:(NSArray *)users;
+ (BOOL)mrc_saveOrUpdateFollowingStatusWithUsers:(NSArray *)users;

+ (NSString *)mrc_currentUserId;

+ (instancetype)mrc_currentUser;
+ (instancetype)mrc_fetchUserWithRawLogin:(NSString *)rawLogin;
+ (instancetype)mrc_fetchUser:(OCTUser *)user;

+ (BOOL)mrc_followUser:(OCTUser *)user;
+ (BOOL)mrc_unfollowUser:(OCTUser *)user;

+ (NSArray *)mrc_fetchFollowersWithPage:(NSUInteger)page perPage:(NSUInteger)perPage;
+ (NSArray *)mrc_fetchFollowingWithPage:(NSUInteger)page perPage:(NSUInteger)perPage;

@end
