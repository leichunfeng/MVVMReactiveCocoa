//
//  OCTRepository+MRCPersistence.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "OCTRepository+MRCPersistence.h"

@implementation OCTRepository (MRCPersistence)

#pragma mark - Properties

- (OCTRepositoryStarredStatus)starredStatus {
    return [objc_getAssociatedObject(self, _cmd) unsignedIntegerValue];
}

- (void)setStarredStatus:(OCTRepositoryStarredStatus)starredStatus {
    objc_setAssociatedObject(self, @selector(starredStatus), @(starredStatus), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - MRCPersistenceProtocol

- (BOOL)mrc_saveOrUpdate {
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *sql = nil;
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM Repository WHERE id = ? LIMIT 1;", self.objectID];
        if (![rs next]) { // INSERT
            sql = @"INSERT INTO Repository VALUES (:id, :name, :owner_login, :owner_avatar_url, :description, :language, :pushed_at, :created_at, :updated_at, :clone_url, :ssh_url, :git_url, :html_url, :default_branch, :private, :fork, :watchers_count, :forks_count, :stargazers_count, :open_issues_count, :subscribers_count);";
        } else { // UPDATE
            sql = @"UPDATE Repository SET name = :name, owner_login = :owner_login, owner_avatar_url = :owner_avatar_url, description = :description, language = :language, pushed_at = :pushed_at, created_at = :created_at, updated_at = :updated_at, clone_url = :clone_url, ssh_url = :ssh_url, git_url = :git_url, html_url = :html_url, default_branch = :default_branch, private = :private, fork = :fork, watchers_count = :watchers_count, forks_count = :forks_count, stargazers_count = :stargazers_count, open_issues_count = :open_issues_count, subscribers_count = :subscribers_count WHERE id = :id;";
        }
        
        NSMutableDictionary *dictionary = [MTLJSONAdapter JSONDictionaryFromModel:self].mutableCopy;
        
        dictionary[@"owner_login"] = dictionary[@"owner"][@"login"];
        dictionary[@"owner_avatar_url"] = dictionary[@"owner"][@"avatar_url"];
        
        BOOL success = [db executeUpdate:sql withParameterDictionary:dictionary];
        if (!success) {
            mrcLogLastError(db);
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

- (BOOL)mrc_delete {
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        BOOL success = [db executeUpdate:@"DELETE FROM Repository WHERE id = ?;", self.objectID];
        if (!success) {
            mrcLogLastError(db);
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

#pragma mark - Save Or Update Repositories

+ (BOOL)mrc_saveOrUpdateRepositories:(NSArray *)repositories {
    if (repositories.count == 0) return YES;
    
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *sql = @"";
        
        NSMutableArray *oldIDs = nil;
        
        FMResultSet *rs = [db executeQuery:@"SELECT id FROM Repository WHERE owner_login = ?;", [OCTUser mrc_currentUser].login];
        while ([rs next]) {
            if (oldIDs == nil) oldIDs = [NSMutableArray new];
            [oldIDs addObject:[rs stringForColumnIndex:0]];
        }
        
        for (OCTRepository *repository in repositories) {
            if (![oldIDs containsObject:repository.objectID]) { // INSERT
                sql = [sql stringByAppendingString:[NSString stringWithFormat:@"INSERT INTO Repository VALUES (%@, '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', %@, %@, %@, %@, %@, %@);", repository.objectID, repository.name.escapeSingleQuote, repository.ownerLogin.escapeSingleQuote, repository.ownerAvatarURL.absoluteString.escapeSingleQuote, repository.repoDescription.escapeSingleQuote, repository.language.escapeSingleQuote, [NSDateFormatter oct_stringFromDate:repository.datePushed], [NSDateFormatter oct_stringFromDate:repository.dateCreated], [NSDateFormatter oct_stringFromDate:repository.dateUpdated], repository.HTTPSURL.absoluteString.escapeSingleQuote, repository.SSHURL.escapeSingleQuote, repository.gitURL.absoluteString.escapeSingleQuote, repository.HTMLURL.absoluteString.escapeSingleQuote, repository.defaultBranch.escapeSingleQuote, @(repository.private), @(repository.fork), @(repository.watchersCount), @(repository.forksCount), @(repository.stargazersCount), @(repository.openIssuesCount)]];
            } else { // UPDATE
                sql = [sql stringByAppendingString:[NSString stringWithFormat:@"UPDATE Repository SET name = '%@', owner_login = '%@', owner_avatar_url = '%@', description = '%@', language = '%@', pushed_at = '%@', created_at = '%@', updated_at = '%@', clone_url = '%@', ssh_url = '%@', git_url = '%@', html_url = '%@', default_branch = '%@', private = %@, fork = %@, watchers_count = %@, forks_count = %@, stargazers_count = %@, open_issues_count = %@ WHERE id = %@;", repository.name.escapeSingleQuote, repository.ownerLogin.escapeSingleQuote, repository.ownerAvatarURL.absoluteString.escapeSingleQuote, repository.repoDescription.escapeSingleQuote, repository.language.escapeSingleQuote, [NSDateFormatter oct_stringFromDate:repository.datePushed], [NSDateFormatter oct_stringFromDate:repository.dateCreated], [NSDateFormatter oct_stringFromDate:repository.dateUpdated], repository.HTTPSURL.absoluteString.escapeSingleQuote, repository.SSHURL.escapeSingleQuote, repository.gitURL.absoluteString.escapeSingleQuote, repository.HTMLURL.absoluteString.escapeSingleQuote, repository.defaultBranch.escapeSingleQuote, @(repository.private), @(repository.fork), @(repository.watchersCount), @(repository.forksCount), @(repository.stargazersCount), @(repository.openIssuesCount), repository.objectID]];
            }
        }
        
        sql = [sql stringByReplacingOccurrencesOfString:@"'(null)'" withString:@"NULL"];
        
        BOOL success = [db executeStatements:sql];
        if (!success) {
            mrcLogLastError(db);
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

+ (BOOL)mrc_saveOrUpdateStarredStatusWithRepositories:(NSArray *)repositories {
    if (repositories.count == 0) return YES;
    
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *newIDs = [[repositories.rac_sequence map:^id(OCTUser *user) {
            return user.objectID;
        }].array componentsJoinedByString:@","];
        
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM User_Starred_Repository WHERE userId = %@ AND repositoryId NOT IN (%@);", [OCTUser mrc_currentUserId], newIDs];
        
        NSMutableArray *oldIDs = nil;
        FMResultSet *rs = [db executeQuery:@"SELECT repositoryId FROM User_Starred_Repository WHERE userId = ?;", [OCTUser mrc_currentUserId]];
        while ([rs next]) {
            if (oldIDs == nil) oldIDs = [NSMutableArray new];
            [oldIDs addObject:[rs stringForColumnIndex:0]];
        }
        
        for (OCTRepository *repository in repositories) {
            if (![oldIDs containsObject:repository.objectID]) { // INSERT
                sql = [sql stringByAppendingString:[NSString stringWithFormat:@"INSERT INTO User_Starred_Repository VALUES (%@, %@, %@);", nil, [OCTUser mrc_currentUserId], repository.objectID]];
            }
        }
        
        BOOL success = [db executeStatements:sql];
        if (!success) {
            mrcLogLastError(db);
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

#pragma mark - Fetch Repositories

+ (instancetype)fetchRepository:(OCTRepository *)repository {
    OCTRepository *repo = nil;
    
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *sql = @"SELECT * FROM Repository WHERE id = ? LIMIT 1;";
        
        FMResultSet *rs = [db executeQuery:sql, repository.objectID];
        if ([rs next]) {
            NSMutableDictionary *dictionary = rs.resultDictionary.mutableCopy;
            dictionary[@"owner"] = @{ @"login": dictionary[@"owner_login"], @"avatar_url": dictionary[@"owner_avatar_url"] };
            
            repo = [MTLJSONAdapter modelOfClass:[OCTRepository class] fromJSONDictionary:dictionary error:nil];
        }
    }
    
    return repo;
}

+ (NSArray *)mrc_fetchUserRepositories {
    NSMutableArray *repos = nil;
    
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *sql = @"SELECT * FROM Repository WHERE owner_login = ? ORDER BY LOWER(name);";

        FMResultSet *rs = [db executeQuery:sql, [OCTUser mrc_currentUser].login];
        while ([rs next]) {
            @autoreleasepool {
                if (repos == nil) repos = [NSMutableArray new];
                
                NSMutableDictionary *dictionary = rs.resultDictionary.mutableCopy;
                dictionary[@"owner"] = @{ @"login": dictionary[@"owner_login"], @"avatar_url": dictionary[@"owner_avatar_url"] };

                OCTRepository *repo = [MTLJSONAdapter modelOfClass:[OCTRepository class] fromJSONDictionary:dictionary error:nil];
                
                [repos addObject:repo];
            }
        }
    }
    
    return repos;
}

+ (NSArray *)mrc_fetchUserStarredRepositories {
    NSMutableArray *repos = nil;
    
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *sql = @"SELECT * FROM User_Starred_Repository usr, Repository r WHERE usr.userId = ? AND usr.repositoryId = r.id ORDER BY LOWER(name);";
        
        FMResultSet *rs = [db executeQuery:sql, [OCTUser mrc_currentUserId]];
        while ([rs next]) {
            @autoreleasepool {
                if (repos == nil) repos = [NSMutableArray new];
                
                NSMutableDictionary *dictionary = rs.resultDictionary.mutableCopy;
                dictionary[@"owner"] = @{ @"login": dictionary[@"owner_login"], @"avatar_url": dictionary[@"owner_avatar_url"] };

                OCTRepository *repo = [MTLJSONAdapter modelOfClass:[OCTRepository class] fromJSONDictionary:dictionary error:nil];
                
                [repos addObject:repo];
            }
        }
    }
    
    return repos;
}

+ (NSArray *)mrc_fetchUserPublicRepositoriesWithPage:(NSUInteger)page perPage:(NSUInteger)perPage {
    NSMutableArray *repos = nil;
    
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM Repository WHERE owner_login = '%@' AND private = 0 ORDER BY LOWER(name)", [OCTUser mrc_currentUser].login];
        
        NSNumber *limit = @(page * perPage);
        if (![limit isEqualToNumber:@0]) {
            sql = [sql stringByAppendingString:[NSString stringWithFormat:@" LIMIT %@", limit]];
        }
        
        sql = [sql stringByAppendingString:@";"];
        
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            @autoreleasepool {
                if (repos == nil) repos = [NSMutableArray new];
                
                NSMutableDictionary *dictionary = rs.resultDictionary.mutableCopy;
                dictionary[@"owner"] = @{ @"login": dictionary[@"owner_login"], @"avatar_url": dictionary[@"owner_avatar_url"] };
                
                OCTRepository *repo = [MTLJSONAdapter modelOfClass:[OCTRepository class] fromJSONDictionary:dictionary error:nil];
                
                [repos addObject:repo];
            }
        }
    }
    
    return repos;
}

#pragma mark - Star Or Unstar Repository

+ (BOOL)mrc_hasUserStarredRepository:(OCTRepository *)repository {
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *sql = @"SELECT * FROM User_Starred_Repository WHERE userId = ? AND repositoryId = ? LIMIT 1;";
        FMResultSet *rs = [db executeQuery:sql, [OCTUser mrc_currentUserId], repository.objectID];
        
        return [rs next];
    }
    return NO;
}

+ (BOOL)mrc_starRepository:(OCTRepository *)repository {
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *sql = @"INSERT INTO User_Starred_Repository VALUES (?, ?, ?);";
        
        BOOL success = [db executeUpdate:sql, nil, [OCTUser mrc_currentUserId], repository.objectID];
        if (!success) {
            mrcLogLastError(db);
            return NO;
        }
        
        repository.starredStatus = OCTRepositoryStarredStatusYES;
        
        return YES;
    }
    return NO;
}

+ (BOOL)mrc_unstarRepository:(OCTRepository *)repository {
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *sql = @"DELETE FROM User_Starred_Repository WHERE userId = ? AND repositoryId = ?;";
        
        BOOL success = [db executeUpdate:sql, [OCTUser mrc_currentUserId], repository.objectID];
        if (!success) {
            mrcLogLastError(db);
            return NO;
        }
        
        repository.starredStatus = OCTRepositoryStarredStatusNO;
        
        return YES;
    }
    return NO;
}

+ (NSArray *)matchStarredStatusForRepositories:(NSArray *)repositories {
    if (repositories.count == 0) return nil;
    
    NSArray *starredRepos = [self mrc_fetchUserStarredRepositories];
   
    for (OCTRepository *repository in repositories) {
        if (repository.starredStatus != OCTRepositoryStarredStatusUnknown) continue;
        
        repository.starredStatus = OCTRepositoryStarredStatusNO;
        for (OCTRepository *starredRepo in starredRepos) {
            if ([repository.objectID isEqualToString:starredRepo.objectID]) {
                repository.starredStatus = OCTRepositoryStarredStatusYES;
                break;
            }
        }
    }

    return repositories;
}

@end
