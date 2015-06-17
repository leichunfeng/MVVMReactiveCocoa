//
//  OCTUser+MRCPersistence.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "OCTUser+MRCPersistence.h"

@implementation OCTUser (MRCPersistence)

- (NSString *)userId {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setUserId:(NSString *)userId {
    objc_setAssociatedObject(self, @selector(userId), userId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (OCTUserFollowerStatus)followerStatus {
    return [objc_getAssociatedObject(self, _cmd) unsignedIntegerValue];
}

- (void)setFollowerStatus:(OCTUserFollowerStatus)followerStatus {
    objc_setAssociatedObject(self, @selector(followerStatus), @(followerStatus), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (OCTUserFollowingStatus)followingStatus {
    return [objc_getAssociatedObject(self, _cmd) unsignedIntegerValue];
}

- (void)setFollowingStatus:(OCTUserFollowingStatus)followingStatus {
    objc_setAssociatedObject(self, @selector(followingStatus), @(followingStatus), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)mrc_saveOrUpdate {
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *sql = nil;
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM User WHERE userId = ? AND id = ? LIMIT 1;", [OCTUser mrc_currentUserId], self.objectID];
        if (![rs next]) {
            sql = @"INSERT INTO User VALUES (:userId, :id, :rawLogin, :login, :name, :bio, :email, :avatar_url, :blog, :company, :location, :collaborators, :public_repos, :owned_private_repos, :public_gists, :private_gists, :followers, :following, :disk_usage, :followerStatus, :followingStatus);";
        } else {
            sql = @"UPDATE User SET rawLogin = :rawLogin, login = :login, name = :name, bio = :bio, email = :email, avatar_url = :avatar_url, blog = :blog, company = :company, location = :location, collaborators = :collaborators, public_repos = :public_repos, owned_private_repos = :owned_private_repos, public_gists = :public_gists, private_gists = :private_gists, followers = :followers, following = :following, disk_usage = :disk_usage, followerStatus = :followerStatus, followingStatus = :followingStatus WHERE userId = :userId AND id = :id;";
        }
        
        BOOL success = [db executeUpdate:sql withParameterDictionary:[MTLJSONAdapter JSONDictionaryFromModel:self]];
        if (!success) {
            mrcLogLastError(db);
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

- (BOOL)mrc_delete {
	return YES;
}

+ (NSString *)mrc_currentUserId {
    return [self mrc_currentUser].objectID;
}

+ (OCTUser *)mrc_currentUser {
    OCTUser *currentUser = [[MRCMemoryCache sharedInstance] objectForKey:@"currentUser"];
    if (!currentUser) {
        currentUser = [self mrc_fetchUserWithRawLogin:[SSKeychain rawLogin]];
        [[MRCMemoryCache sharedInstance] setObject:currentUser forKey:@"currentUser"];
    }
    return currentUser;
}

+ (OCTUser *)mrc_fetchUserWithRawLogin:(NSString *)rawLogin {
    OCTUser *user = nil;
    
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM User WHERE login = ? OR email = ? LIMIT 1;", rawLogin, rawLogin];
        if ([rs next]) {
            user = [MTLJSONAdapter modelOfClass:[OCTUser class] fromJSONDictionary:rs.resultDictionary error:nil];
        }
    }
    
    return user;
}

+ (BOOL)mrc_saveOrUpdateFollowers:(NSArray *)users {
    return [self mrc_saveOrUpdateUsers:users relationship:OCTUserRelationshipFollower];
}

+ (BOOL)mrc_saveOrUpdateFollowing:(NSArray *)users {
    return [self mrc_saveOrUpdateUsers:users relationship:OCTUserRelationshipFollowing];
}

+ (BOOL)mrc_saveOrUpdateUsers:(NSArray *)users relationship:(OCTUserRelationship)relationship {
    if (users.count == 0) return YES;
    
    NSString *string = MRCStringFromRelationship(relationship);
    NSParameterAssert(string != nil);
    
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *newIDs = [[users.rac_sequence map:^id(OCTUser *user) {
            return user.objectID;
        }].array componentsJoinedByString:@","];
        
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM User WHERE userId = %@ AND id NOT IN (%@) AND %@ = 1;", [OCTUser mrc_currentUserId], newIDs, string];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT id FROM User WHERE userId = %@ AND %@ = 1;", [OCTUser mrc_currentUserId], string];

        NSMutableArray *oldIDs = nil;
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]) {
            if (oldIDs == nil) oldIDs = [NSMutableArray new];
            [oldIDs addObject:[rs stringForColumnIndex:0]];
        }
        
        for (OCTUser *user in users) {
            if (![oldIDs containsObject:user.objectID]) { // INSERT
                sql = [sql stringByAppendingString:[NSString stringWithFormat:@"INSERT INTO User VALUES (%@, '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@);", [OCTUser mrc_currentUserId], user.objectID, user.rawLogin, user.login, user.name, user.bio, user.email, user.avatarURL.absoluteString, user.blog, user.company, user.location, @(user.collaborators), @(user.publicRepoCount), @(user.privateRepoCount), @(user.publicGistCount), @(user.privateGistCount), @(user.followers), @(user.following), @(user.diskUsage), @(user.followerStatus), @(user.followingStatus)]];
            } else { // UPDATE
                sql = [sql stringByAppendingString:[NSString stringWithFormat:@"UPDATE User SET rawLogin = '%@', login = '%@', name = '%@', bio = '%@', email = '%@', avatar_url = '%@', blog = '%@', company = '%@', location = '%@', collaborators = %@, public_repos = %@, owned_private_repos = %@, public_gists = %@, private_gists = %@, followers = %@, following = %@, disk_usage = %@, %@ = %@ WHERE userId = %@ AND id = %@;", user.rawLogin, user.login, user.name, user.bio, user.email, user.avatarURL.absoluteString, user.blog, user.company, user.location, @(user.collaborators), @(user.publicRepoCount), @(user.privateRepoCount), @(user.publicGistCount), @(user.privateGistCount), @(user.followers), @(user.following), @(user.diskUsage), string, [user valueForKey:string], [OCTUser mrc_currentUserId], user.objectID]];
            }
        }
        
        sql = [sql stringByReplacingOccurrencesOfString:@"'<null>'" withString:@"NULL"];
        
        BOOL success = [db executeStatements:sql];
        if (!success) {
            mrcLogLastError(db);
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

+ (NSArray *)mrc_fetchFollowersWithPage:(NSUInteger)page perPage:(NSUInteger)perPage {
    NSMutableArray *followers = nil;
    
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSNumber *limit = @0;
        if (page > 0 && perPage > 0) {
            limit = @(page * perPage);
        }
        
        NSString *sql = @"SELECT * FROM user WHERE userId = ? AND followerStatus = 1 LIMIT ?";
        
        FMResultSet *rs = [db executeQuery:sql, [OCTUser mrc_currentUserId], limit];
        while ([rs next]) {
            @autoreleasepool {
                if (followers == nil) followers = [NSMutableArray new];
                OCTUser *user = [MTLJSONAdapter modelOfClass:[OCTUser class] fromJSONDictionary:rs.resultDictionary error:nil];
                [followers addObject:user];
            }
        }
    }
    
    return followers;
}

+ (NSArray *)mrc_fetchFollowingWithPage:(NSUInteger)page perPage:(NSUInteger)perPage {
    NSMutableArray *followers = nil;
    
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSNumber *limit = @0;
        if (page > 0 && perPage > 0) {
            limit = @(page * perPage);
        }
        
        NSString *sql = @"SELECT * FROM user WHERE userId = ? AND followingStatus = 1 LIMIT ?";
        
        FMResultSet *rs = [db executeQuery:sql, [OCTUser mrc_currentUserId], limit];
        while ([rs next]) {
            @autoreleasepool {
                if (followers == nil) followers = [NSMutableArray new];
                OCTUser *user = [MTLJSONAdapter modelOfClass:[OCTUser class] fromJSONDictionary:rs.resultDictionary error:nil];
                [followers addObject:user];
            }
        }
    }
    
    return followers;
}

NSString *MRCStringFromRelationship(OCTUserRelationship relationship) {
    switch (relationship) {
        case OCTUserRelationshipFollower:
            return @"followerStatus";
        case OCTUserRelationshipFollowing:
            return @"followingStatus";
        case OCTUserRelationshipUnknown:
        default:
            return nil;
    }
}

OCTUserRelationship MRCRelationshipFromString(NSString *string)  {
    if ([string isEqualToString:@"followerStatus"]) {
        return OCTUserRelationshipFollower;
    } else if ([string isEqualToString:@"followingStatus"]) {
        return OCTUserRelationshipFollowing;
    }
    return OCTUserRelationshipUnknown;
}

@end
