//
//  OCTUser+MRCPersistence.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <OctoKit/OctoKit.h>
#import "MRCPersistenceProtocol.h"

typedef NS_ENUM(NSUInteger, OCTUserRelationship) {
    OCTUserRelationshipFollower,
    OCTUserRelationshipFollowing,
    OCTUserRelationshipUnknown
};

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

@property (copy, nonatomic) NSString *userId;

@property (assign, nonatomic) OCTUserFollowerStatus followerStatus;
@property (assign, nonatomic) OCTUserFollowingStatus followingStatus;

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

+ (BOOL)mrc_saveOrUpdateFollowers:(NSArray *)users;
+ (BOOL)mrc_saveOrUpdateFollowing:(NSArray *)users;

+ (NSArray *)mrc_fetchFollowersWithPage:(NSUInteger)page perPage:(NSUInteger)perPage;
+ (NSArray *)mrc_fetchFollowingWithPage:(NSUInteger)page perPage:(NSUInteger)perPage;

NSString *MRCStringFromRelationship(OCTUserRelationship relationship);
OCTUserRelationship MRCRelationshipFromString(NSString *string);

@end
