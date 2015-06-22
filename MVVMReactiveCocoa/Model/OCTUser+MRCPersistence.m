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
    __block BOOL result = YES;
    
    [[FMDatabaseQueue sharedInstance] inDatabase:^(FMDatabase *db) {
        NSString *sql = nil;
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM User WHERE id = ? LIMIT 1;", self.objectID];
        
        @onExit {
            [rs close];
        };

        if (rs == nil) {
            mrcLogLastError(db);
            result = NO;
            return;
        }
        
        if (![rs next]) { // INSERT
            sql = @"INSERT INTO User VALUES (:id, :rawLogin, :login, :name, :bio, :email, :avatar_url, :html_url, :blog, :company, :location, :collaborators, :public_repos, :owned_private_repos, :public_gists, :private_gists, :followers, :following, :disk_usage);";
        } else { // UPDATE
            sql = @"UPDATE User SET rawLogin = :rawLogin, login = :login, name = :name, bio = :bio, email = :email, avatar_url = :avatar_url, html_url = :html_url, blog = :blog, company = :company, location = :location, collaborators = :collaborators, public_repos = :public_repos, owned_private_repos = :owned_private_repos, public_gists = :public_gists, private_gists = :private_gists, followers = :followers, following = :following, disk_usage = :disk_usage WHERE id = :id;";
        }
        
        BOOL success = [db executeUpdate:sql withParameterDictionary:[MTLJSONAdapter JSONDictionaryFromModel:self]];
        if (!success) {
            mrcLogLastError(db);
            result = NO;
            return;
        }
    }];
     
    return result;
}

- (BOOL)mrc_delete {
	return YES;
}

#pragma mark - Save Or Update Users

+ (BOOL)mrc_saveOrUpdateUsers:(NSArray *)users {
    if (users.count == 0) return YES;
    
    __block BOOL result = YES;
    
    [[FMDatabaseQueue sharedInstance] inDatabase:^(FMDatabase *db) {
        NSString *sql = @"";
        
        NSMutableArray *oldIDs = nil;
        
        FMResultSet *rs = [db executeQuery:@"SELECT id FROM User;"];
        
        @onExit {
            [rs close];
        };

        if (rs == nil) {
            mrcLogLastError(db);
            result = NO;
            return;
        }
        
        while ([rs next]) {
            if (oldIDs == nil) oldIDs = [NSMutableArray new];
            [oldIDs addObject:[rs stringForColumnIndex:0]];
        }
        
        for (OCTUser *user in users) {
            if (![oldIDs containsObject:user.objectID]) { // INSERT
                sql = [sql stringByAppendingString:[NSString stringWithFormat:@"INSERT INTO User VALUES (%@, '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', %@, %@, %@, %@, %@, %@, %@, %@, %@);", user.objectID, user.rawLogin.escapeSingleQuote, user.login.escapeSingleQuote, user.name.escapeSingleQuote, user.bio.escapeSingleQuote, user.email.escapeSingleQuote, user.avatarURL.absoluteString.escapeSingleQuote, user.HTMLURL.absoluteString.escapeSingleQuote, user.blog.escapeSingleQuote, user.company.escapeSingleQuote, user.location.escapeSingleQuote, @(user.collaborators), @(user.publicRepoCount), @(user.privateRepoCount), @(user.publicGistCount), @(user.privateGistCount), @(user.followers), @(user.following), @(user.diskUsage)]];
            } else { // UPDATE
                sql = [sql stringByAppendingString:[NSString stringWithFormat:@"UPDATE User SET rawLogin = '%@', login = '%@', bio = '%@', avatar_url = '%@', html_url = '%@', collaborators = %@, owned_private_repos = %@, public_gists = %@, private_gists = %@, disk_usage = %@ WHERE id = %@;", user.rawLogin.escapeSingleQuote, user.login.escapeSingleQuote, user.bio.escapeSingleQuote, user.avatarURL.absoluteString.escapeSingleQuote, user.HTMLURL.absoluteString.escapeSingleQuote, @(user.collaborators), @(user.privateRepoCount), @(user.publicGistCount), @(user.privateGistCount), @(user.diskUsage), user.objectID]];
            }
        }
        
        sql = [sql stringByReplacingOccurrencesOfString:@"'(null)'" withString:@"NULL"];
        
        BOOL success = [db executeStatements:sql];
        if (!success) {
            mrcLogLastError(db);
            result = NO;
            return;
        }
    }];
    
    return result;
}

+ (BOOL)mrc_saveOrUpdateFollowerStatusWithUsers:(NSArray *)users {
    if (users.count == 0) return YES;
    
    __block BOOL result = YES;
    
    [[FMDatabaseQueue sharedInstance] inDatabase:^(FMDatabase *db) {
        NSString *newIDs = [[users.rac_sequence map:^(OCTUser *user) {
            return user.objectID;
        }].array componentsJoinedByString:@","];
        
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM User_Following_User WHERE userId NOT IN (%@) AND targetUserId = %@;", newIDs, [OCTUser mrc_currentUserId]];
        
        NSMutableArray *oldIDs = nil;
        
        FMResultSet *rs = [db executeQuery:@"SELECT userId FROM User_Following_User WHERE targetUserId = ?;", [OCTUser mrc_currentUserId]];
        
        @onExit {
            [rs close];
        };

        if (rs == nil) {
            mrcLogLastError(db);
            result = NO;
            return;
        }
        
        while ([rs next]) {
            if (oldIDs == nil) oldIDs = [NSMutableArray new];
            [oldIDs addObject:[rs stringForColumnIndex:0]];
        }
        
        for (OCTUser *user in users) {
            if (![oldIDs containsObject:user.objectID]) { // INSERT
                sql = [sql stringByAppendingString:[NSString stringWithFormat:@"INSERT INTO User_Following_User VALUES (%@, %@, %@);", nil, user.objectID, [OCTUser mrc_currentUserId]]];
            }
        }
        
        BOOL success = [db executeStatements:sql];
        if (!success) {
            mrcLogLastError(db);
            result = NO;
            return;
        }
    }];
    
    return result;
}

+ (BOOL)mrc_saveOrUpdateFollowingStatusWithUsers:(NSArray *)users {
    if (users.count == 0) return YES;
    
    __block BOOL result = YES;
    
    [[FMDatabaseQueue sharedInstance] inDatabase:^(FMDatabase *db) {
        NSString *newIDs = [[users.rac_sequence map:^id(OCTUser *user) {
            return user.objectID;
        }].array componentsJoinedByString:@","];
        
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM User_Following_User WHERE targetUserId NOT IN (%@) AND userId = %@;", newIDs, [OCTUser mrc_currentUserId]];
        
        NSMutableArray *oldIDs = nil;
        
        FMResultSet *rs = [db executeQuery:@"SELECT targetUserId FROM User_Following_User WHERE userId = ?;", [OCTUser mrc_currentUserId]];
        
        @onExit {
            [rs close];
        };

        if (rs == nil) {
            mrcLogLastError(db);
            result = NO;
            return;
        }
        
        while ([rs next]) {
            if (oldIDs == nil) oldIDs = [NSMutableArray new];
            [oldIDs addObject:[rs stringForColumnIndex:0]];
        }
        
        for (OCTUser *user in users) {
            if (![oldIDs containsObject:user.objectID]) { // INSERT
                sql = [sql stringByAppendingString:[NSString stringWithFormat:@"INSERT INTO User_Following_User VALUES (%@, %@, %@);", nil, [OCTUser mrc_currentUserId], user.objectID]];
            }
        }
        
        BOOL success = [db executeStatements:sql];
        if (!success) {
            mrcLogLastError(db);
            result = NO;
            return;
        }
    }];
    
    return result;
}

#pragma mark - Fetch UserId

+ (NSString *)mrc_currentUserId {
    return ((OCTUser *)[self mrc_currentUser]).objectID;
}

#pragma mark - Fetch User

+ (instancetype)mrc_currentUser {
    OCTUser *currentUser = [[MRCMemoryCache sharedInstance] objectForKey:@"currentUser"];
    if (!currentUser) {
        currentUser = [self mrc_fetchUserWithRawLogin:[SSKeychain rawLogin]];
        [[MRCMemoryCache sharedInstance] setObject:currentUser forKey:@"currentUser"];
    }
    return currentUser;
}

+ (instancetype)mrc_fetchUserWithRawLogin:(NSString *)rawLogin {
    if (rawLogin.length == 0) return nil;
    
    __block OCTUser *user = nil;
    
    [[FMDatabaseQueue sharedInstance] inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM User WHERE login = ? OR email = ? LIMIT 1;", rawLogin, rawLogin];
        
        @onExit {
            [rs close];
        };

        if (rs == nil) {
            mrcLogLastError(db);
            return;
        }
        
        if ([rs next]) {
            user = [MTLJSONAdapter modelOfClass:[OCTUser class] fromJSONDictionary:rs.resultDictionary error:nil];
        }
    }];
    
    return user;
}

+ (instancetype)mrc_fetchUser:(OCTUser *)user {
    __block OCTUser *result = nil;
    
    [[FMDatabaseQueue sharedInstance] inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM User WHERE login = ? LIMIT 1;", user.login];
        
        @onExit {
            [rs close];
        };

        if (rs == nil) {
            mrcLogLastError(db);
            return;
        }
        
        if ([rs next]) {
            result = [MTLJSONAdapter modelOfClass:[OCTUser class] fromJSONDictionary:rs.resultDictionary error:nil];
        }
    }];
    
    return result;
}

+ (BOOL)mrc_followUser:(OCTUser *)user {
    __block BOOL result = YES;
    
    [[FMDatabaseQueue sharedInstance] inDatabase:^(FMDatabase *db) {
        NSString *sql = @"";
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM User WHERE id = ? LIMIT 1;", user.objectID];
        
        @onExit {
            [rs close];
        };

        if (rs == nil) {
            mrcLogLastError(db);
            result = NO;
            return;
        }
        
        if (![rs next]) { // INSERT
            sql = [sql stringByAppendingString:[NSString stringWithFormat:@"INSERT INTO User VALUES (%@, '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', %@, %@, %@, %@, %@, %@, %@, %@, %@);", user.objectID, user.rawLogin.escapeSingleQuote, user.login.escapeSingleQuote, user.name.escapeSingleQuote, user.bio.escapeSingleQuote, user.email.escapeSingleQuote, user.avatarURL.absoluteString.escapeSingleQuote, user.HTMLURL.absoluteString.escapeSingleQuote, user.blog.escapeSingleQuote, user.company.escapeSingleQuote, user.location.escapeSingleQuote, @(user.collaborators), @(user.publicRepoCount), @(user.privateRepoCount), @(user.publicGistCount), @(user.privateGistCount), @(user.followers), @(user.following), @(user.diskUsage)]];
        }
        
        sql = [sql stringByAppendingString:[NSString stringWithFormat:@"INSERT INTO User_Following_User VALUES (%@, %@, %@);", nil, [OCTUser mrc_currentUserId], user.objectID]];
        
        sql = [sql stringByAppendingString:[NSString stringWithFormat:@"UPDATE User SET followers = %@ WHERE id = %@;", @(user.followers+1), user.objectID]];
        sql = [sql stringByAppendingString:[NSString stringWithFormat:@"UPDATE User SET following = %@ WHERE id = %@;", @([OCTUser mrc_currentUser].following+1), [OCTUser mrc_currentUserId]]];
        
        BOOL success = [db executeStatements:sql];
        if (!success) {
            mrcLogLastError(db);
            result = NO;
            return;
        }
        
        user.followingStatus = OCTUserFollowingStatusYES;
        [user increaseFollowers];
        [[OCTUser mrc_currentUser] increaseFollowing];
    }];
    
    return result;
}

+ (BOOL)mrc_unfollowUser:(OCTUser *)user {
    __block BOOL result = YES;
    
    [[FMDatabaseQueue sharedInstance] inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM User_Following_User WHERE userId = %@ AND targetUserId = %@;", [OCTUser mrc_currentUserId], user.objectID];
        
        if (user.followers != 0) {
            sql = [sql stringByAppendingString:[NSString stringWithFormat:@"UPDATE User SET followers = %@ WHERE id = %@;", @(user.followers-1), user.objectID]];
        }
        if ([OCTUser mrc_currentUser].following != 0) {
            sql = [sql stringByAppendingString:[NSString stringWithFormat:@"UPDATE User SET following = %@ WHERE id = %@;", @([OCTUser mrc_currentUser].following-1), [OCTUser mrc_currentUserId]]];
        }
        
        BOOL success = [db executeStatements:sql];
        if (!success) {
            mrcLogLastError(db);
            result = NO;
            return;
        }
        
        user.followingStatus = OCTUserFollowingStatusNO;
        [user decreaseFollowers];
        [[OCTUser mrc_currentUser] decreaseFollowing];
    }];

    return result;
}

#pragma mark - Fetch Users

+ (NSArray *)mrc_fetchFollowersWithPage:(NSUInteger)page perPage:(NSUInteger)perPage {
    __block NSMutableArray *followers = nil;
    
    [[FMDatabaseQueue sharedInstance] inDatabase:^(FMDatabase *db) {
        NSNumber *limit = @0;
        if (page > 0 && perPage > 0) {
            limit = @(page * perPage);
        }
        
        NSString *sql = @"SELECT * FROM User_Following_User ufu, User u WHERE ufu.targetUserId = ? AND ufu.userId = u.id LIMIT ?;";
        
        FMResultSet *rs = [db executeQuery:sql, [OCTUser mrc_currentUserId], limit];
        
        @onExit {
            [rs close];
        };

        if (rs == nil) {
            mrcLogLastError(db);
            return;
        }
        
        while ([rs next]) {
            @autoreleasepool {
                if (followers == nil) followers = [NSMutableArray new];
                OCTUser *user = [MTLJSONAdapter modelOfClass:[OCTUser class] fromJSONDictionary:rs.resultDictionary error:nil];
                user.followerStatus = OCTUserFollowerStatusYES;
                [followers addObject:user];
            }
        }
    }];
    
    return followers;
}

+ (NSArray *)mrc_fetchFollowingWithPage:(NSUInteger)page perPage:(NSUInteger)perPage {
    __block NSMutableArray *followings = nil;
    
    [[FMDatabaseQueue sharedInstance] inDatabase:^(FMDatabase *db) {
        NSNumber *limit = @0;
        if (page > 0 && perPage > 0) {
            limit = @(page * perPage);
        }
        
        NSString *sql = @"SELECT * FROM User_Following_User ufu, User u WHERE ufu.userId = ? AND ufu.targetUserId = u.id ORDER BY u.id LIMIT ?;";
        
        FMResultSet *rs = [db executeQuery:sql, [OCTUser mrc_currentUserId], limit];

        @onExit {
            [rs close];
        };
        
        if (rs == nil) {
            mrcLogLastError(db);
            return;
        }
        
        while ([rs next]) {
            @autoreleasepool {
                if (followings == nil) followings = [NSMutableArray new];
                OCTUser *user = [MTLJSONAdapter modelOfClass:[OCTUser class] fromJSONDictionary:rs.resultDictionary error:nil];
                user.followingStatus = OCTUserFollowingStatusYES;
                [followings addObject:user];
            }
        }
    }];
    
    return followings;
}

- (void)increaseFollowers {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[MTLJSONAdapter JSONDictionaryFromModel:self]];
    
    dictionary[@"followers"] = @([dictionary[@"followers"] unsignedIntegerValue] + 1);
    OCTUser *user = [MTLJSONAdapter modelOfClass:[OCTUser class] fromJSONDictionary:dictionary error:nil];
    
    [self mergeValueForKey:@"followers" fromModel:user];
}

- (void)decreaseFollowers {
    if (self.followers == 0) return;
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[MTLJSONAdapter JSONDictionaryFromModel:self]];
    
    dictionary[@"followers"] = @([dictionary[@"followers"] unsignedIntegerValue] - 1);
    OCTUser *user = [MTLJSONAdapter modelOfClass:[OCTUser class] fromJSONDictionary:dictionary error:nil];
    
    [self mergeValueForKey:@"followers" fromModel:user];
}

- (void)increaseFollowing {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[MTLJSONAdapter JSONDictionaryFromModel:self]];
    
    dictionary[@"following"] = @([dictionary[@"following"] unsignedIntegerValue] + 1);
    OCTUser *user = [MTLJSONAdapter modelOfClass:[OCTUser class] fromJSONDictionary:dictionary error:nil];
    
    [self mergeValueForKey:@"following" fromModel:user];
}

- (void)decreaseFollowing {
    if (self.following == 0) return;
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[MTLJSONAdapter JSONDictionaryFromModel:self]];
    
    dictionary[@"following"] = @([dictionary[@"following"] unsignedIntegerValue] - 1);
    OCTUser *user = [MTLJSONAdapter modelOfClass:[OCTUser class] fromJSONDictionary:dictionary error:nil];
    
    [self mergeValueForKey:@"following" fromModel:user];
}

@end
