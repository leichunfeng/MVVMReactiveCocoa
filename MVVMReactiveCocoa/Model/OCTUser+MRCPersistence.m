//
//  OCTUser+MRCPersistence.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "OCTUser+MRCPersistence.h"

@implementation OCTUser (MRCPersistence)

#pragma mark - Properties

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

#pragma mark - MRCPersistenceProtocol

- (BOOL)mrc_saveOrUpdate {
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *sql = nil;
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM User WHERE id = ? LIMIT 1;", self.objectID];
        if (![rs next]) { // INSERT
            sql = @"INSERT INTO User VALUES (:id, :rawLogin, :login, :name, :bio, :email, :avatar_url, :blog, :company, :location, :collaborators, :public_repos, :owned_private_repos, :public_gists, :private_gists, :followers, :following, :disk_usage);";
        } else { // UPDATE
            sql = @"UPDATE User SET rawLogin = :rawLogin, login = :login, name = :name, bio = :bio, email = :email, avatar_url = :avatar_url, blog = :blog, company = :company, location = :location, collaborators = :collaborators, public_repos = :public_repos, owned_private_repos = :owned_private_repos, public_gists = :public_gists, private_gists = :private_gists, followers = :followers, following = :following, disk_usage = :disk_usage WHERE id = :id;";
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

#pragma mark - Fetch UserId

+ (NSString *)mrc_currentUserId {
    return [self mrc_currentUser].objectID;
}

#pragma mark - Fetch User

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

#pragma mark - Save Or Update Users

+ (BOOL)mrc_saveOrUpdateUsers:(NSArray *)users {
    if (users.count == 0) return YES;
    
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *sql = @"";
        
        NSMutableArray *oldIDs = nil;
        FMResultSet *rs = [db executeQuery:@"SELECT id FROM User;"];
        while ([rs next]) {
            if (oldIDs == nil) oldIDs = [NSMutableArray new];
            [oldIDs addObject:[rs stringForColumnIndex:0]];
        }
        
        for (OCTUser *user in users) {
            if (![oldIDs containsObject:user.objectID]) { // INSERT
                sql = [sql stringByAppendingString:[NSString stringWithFormat:@"INSERT INTO User VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', %@, %@, %@, %@, %@, %@, %@, %@, %@);", user.objectID, user.rawLogin, user.login, user.name, user.bio, user.email, user.avatarURL.absoluteString, user.blog, user.company, user.location, @(user.collaborators), @(user.publicRepoCount), @(user.privateRepoCount), @(user.publicGistCount), @(user.privateGistCount), @(user.followers), @(user.following), @(user.diskUsage)]];
            } else { // UPDATE
                sql = [sql stringByAppendingString:[NSString stringWithFormat:@"UPDATE User SET rawLogin = '%@', login = '%@', name = '%@', bio = '%@', email = '%@', avatar_url = '%@', blog = '%@', company = '%@', location = '%@', collaborators = %@, public_repos = %@, owned_private_repos = %@, public_gists = %@, private_gists = %@, followers = %@, following = %@, disk_usage = %@ WHERE id = %@;", user.rawLogin, user.login, user.name, user.bio, user.email, user.avatarURL.absoluteString, user.blog, user.company, user.location, @(user.collaborators), @(user.publicRepoCount), @(user.privateRepoCount), @(user.publicGistCount), @(user.privateGistCount), @(user.followers), @(user.following), @(user.diskUsage), user.objectID]];
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

+ (BOOL)mrc_saveOrUpdateFollowerStatusWithUsers:(NSArray *)users {
    if (users.count == 0) return YES;
    
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *newIDs = [[users.rac_sequence map:^id(OCTUser *user) {
            return user.objectID;
        }].array componentsJoinedByString:@","];
        
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM User_Following_User WHERE userId NOT IN (%@) AND targetUserId = %@;", newIDs, [OCTUser mrc_currentUserId]];
        
        NSMutableArray *oldIDs = nil;
        FMResultSet *rs = [db executeQuery:@"SELECT userId FROM User_Following_User WHERE targetUserId = ?;", [OCTUser mrc_currentUserId]];
        while ([rs next]) {
            if (oldIDs == nil) oldIDs = [NSMutableArray new];
            [oldIDs addObject:[rs stringForColumnIndex:0]];
        }
        
        for (OCTUser *user in users) {
            if (![oldIDs containsObject:user.objectID]) { // INSERT
                sql = [sql stringByAppendingString:[NSString stringWithFormat:@"INSERT INTO User_Following_User VALUES (%@, %@, %@);", nil, user.objectID, [OCTUser mrc_currentUserId]]];
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

+ (BOOL)mrc_saveOrUpdateFollowingStatusWithUsers:(NSArray *)users {
    if (users.count == 0) return YES;
    
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *newIDs = [[users.rac_sequence map:^id(OCTUser *user) {
            return user.objectID;
        }].array componentsJoinedByString:@","];
        
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM User_Following_User WHERE targetUserId NOT IN (%@) AND userId = %@;", newIDs, [OCTUser mrc_currentUserId]];
        
        NSMutableArray *oldIDs = nil;
        FMResultSet *rs = [db executeQuery:@"SELECT targetUserId FROM User_Following_User WHERE userId = ?;", [OCTUser mrc_currentUserId]];
        while ([rs next]) {
            if (oldIDs == nil) oldIDs = [NSMutableArray new];
            [oldIDs addObject:[rs stringForColumnIndex:0]];
        }
        
        for (OCTUser *user in users) {
            if (![oldIDs containsObject:user.objectID]) { // INSERT
                sql = [sql stringByAppendingString:[NSString stringWithFormat:@"INSERT INTO User_Following_User VALUES (%@, %@, %@);", nil, [OCTUser mrc_currentUserId], user.objectID]];
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

#pragma mark - Fetch Users

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
        
        NSString *sql = @"SELECT * FROM User_Following_User ufu, User u WHERE ufu.targetUserId = ? AND ufu.userId = u.id LIMIT ?;";
        
        FMResultSet *rs = [db executeQuery:sql, [OCTUser mrc_currentUserId], limit];
        while ([rs next]) {
            @autoreleasepool {
                if (followers == nil) followers = [NSMutableArray new];
                OCTUser *user = [MTLJSONAdapter modelOfClass:[OCTUser class] fromJSONDictionary:rs.resultDictionary error:nil];
                user.followerStatus = OCTUserFollowerStatusYES;
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
        
       	NSString *sql = @"SELECT * FROM User_Following_User ufu, User u WHERE ufu.userId = ? AND ufu.targetUserId = u.id LIMIT ?;";
        
        FMResultSet *rs = [db executeQuery:sql, [OCTUser mrc_currentUserId], limit];
        while ([rs next]) {
            @autoreleasepool {
                if (followers == nil) followers = [NSMutableArray new];
                OCTUser *user = [MTLJSONAdapter modelOfClass:[OCTUser class] fromJSONDictionary:rs.resultDictionary error:nil];
                user.followingStatus = OCTUserFollowingStatusYES;
                [followers addObject:user];
            }
        }
    }
    
    return followers;
}

@end
