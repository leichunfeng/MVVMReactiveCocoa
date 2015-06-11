//
//  OCTRepository+MRCPersistence.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "OCTRepository+MRCPersistence.h"

static void *OCTRepositoryIsStarredKey = &OCTRepositoryIsStarredKey;

@implementation OCTRepository (MRCPersistence)

- (BOOL)isStarred {
    return [objc_getAssociatedObject(self, OCTRepositoryIsStarredKey) boolValue];
}

- (void)setIsStarred:(BOOL)isStarred {
    objc_setAssociatedObject(self, OCTRepositoryIsStarredKey, @(isStarred), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)mrc_starRepository {
    self.isStarred = YES;
    return [self mrc_saveOrUpdate];
}

- (BOOL)mrc_unstarRepository {
    self.isStarred = NO;
    return [OCTRepository mrc_deleteRepositoryWithId:self.objectID isStarred:@YES];
}

- (BOOL)mrc_update {
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        FMResultSet *rs = [db executeQuery:@"select * from Repository where userId = ? and id = ? and isStarred = ? limit 1;", [OCTUser mrc_currentUserId], self.objectID, @(self.isStarred)];
        if ([rs next]) {
            NSString *sql = @"update Repository set name = :name, owner_login = :owner_login, owner_avatar_url = :owner_avatar_url, description = :description, language = :language, pushed_at = :pushed_at, created_at = :created_at, updated_at = :updated_at, clone_url = :clone_url, ssh_url = :ssh_url, git_url = :git_url, html_url = :html_url, default_branch = :default_branch, private = :private, fork = :fork, watchers_count = :watchers_count, forks_count = :forks_count, stargazers_count = :stargazers_count, open_issues_count = :open_issues_count, subscribers_count = :subscribers_count where userId = :userId and id = :id and isStarred = :isStarred;";
            
            NSMutableDictionary *dictionary = [MTLJSONAdapter JSONDictionaryFromModel:self].mutableCopy;
            
            dictionary[@"userId"] = [OCTUser mrc_currentUserId];
            dictionary[@"owner_login"] = dictionary[@"owner"][@"login"];
            dictionary[@"owner_avatar_url"] = dictionary[@"owner"][@"avatar_url"];
            
            BOOL success = [db executeUpdate:sql withParameterDictionary:dictionary];
            if (!success) {
                mrcLogLastError(db);
                return NO;
            }
            
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)mrc_saveOrUpdate {
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *sql = nil;
        
        FMResultSet *rs = [db executeQuery:@"select * from Repository where userId = ? and id = ? and isStarred = ? limit 1;", [OCTUser mrc_currentUserId], self.objectID, @(self.isStarred)];
        if (![rs next]) { // insert
            sql = @"insert into Repository values (:userId, :id, :isStarred, :name, :owner_login, :owner_avatar_url, :description, :language, :pushed_at, :created_at, :updated_at, :clone_url, :ssh_url, :git_url, :html_url, :default_branch, :private, :fork, :watchers_count, :forks_count, :stargazers_count, :open_issues_count, :subscribers_count);";
        } else { // update
            sql = @"update Repository set name = :name, owner_login = :owner_login, owner_avatar_url = :owner_avatar_url, description = :description, language = :language, pushed_at = :pushed_at, created_at = :created_at, updated_at = :updated_at, clone_url = :clone_url, ssh_url = :ssh_url, git_url = :git_url, html_url = :html_url, default_branch = :default_branch, private = :private, fork = :fork, watchers_count = :watchers_count, forks_count = :forks_count, stargazers_count = :stargazers_count, open_issues_count = :open_issues_count, subscribers_count = :subscribers_count where userId = :userId and id = :id and isStarred = :isStarred;";
        }
        
        NSMutableDictionary *dictionary = [MTLJSONAdapter JSONDictionaryFromModel:self].mutableCopy;
        
        dictionary[@"userId"] = [OCTUser mrc_currentUserId];
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
        
        BOOL success = [db executeUpdate:@"delete from Repository where userId = ? and id = ? and isStarred = ?;", [OCTUser mrc_currentUserId], self.objectID, @(self.isStarred)];
        if (!success) {
            mrcLogLastError(db);
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

+ (NSArray *)mrc_fetchUserRepositories {
    return [self mrc_fetchRepositoriesIsStarred:NO];
}

+ (NSArray *)mrc_fetchUserStarredRepositories {
    return [self mrc_fetchRepositoriesIsStarred:YES];
}

+ (NSArray *)mrc_fetchRepositoriesIsStarred:(BOOL)isStarred {
    NSMutableArray *repos = nil;
    
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *sql = @"select * from Repository where userId = ? and isStarred = ? order by lower(name);";
        
        FMResultSet *rs = [db executeQuery:sql, [OCTUser mrc_currentUserId], @(isStarred)];
        while ([rs next]) {
            @autoreleasepool {
                if (repos == nil) repos = [NSMutableArray new];
                
                NSMutableDictionary *dictionary = rs.resultDictionary.mutableCopy;
                
                [dictionary removeObjectForKey:@"userId"];
               
                dictionary[@"owner"] = @{ @"login": dictionary[@"owner_login"], @"avatar_url": dictionary[@"owner_avatar_url"] };
                [dictionary removeObjectForKey:@"owner_login"];
                [dictionary removeObjectForKey:@"owner_avatar_url"];
                
                OCTRepository *repo = [MTLJSONAdapter modelOfClass:[OCTRepository class] fromJSONDictionary:dictionary error:nil];
                
                [repos addObject:repo];
            }
        }
    }
    
    return repos;
}

+ (BOOL)mrc_saveOrUpdateUserRepositories:(NSArray *)repositories {
    return [self mrc_saveOrUpdateRepositories:repositories isStarred:NO];
}

+ (BOOL)mrc_saveOrUpdateUserStarredRepositories:(NSArray *)repositories {
    return [self mrc_saveOrUpdateRepositories:repositories isStarred:YES];
}

+ (BOOL)mrc_saveOrUpdateRepositories:(NSArray *)repositories isStarred:(BOOL)isStarred {
    if (repositories.count == 0) return YES;
    
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *newIDs = [[repositories.rac_sequence map:^id(OCTRepository *repo) {
            return @(repo.objectID.integerValue);
        }].array componentsJoinedByString:@","];
        
        NSString *sql = [NSString stringWithFormat:@"delete from Repository where userId = %ld and id not in (%@) and isStarred = %d;", [OCTUser mrc_currentUserId].integerValue, newIDs, isStarred];
        
        NSMutableArray *oldIDs = nil;
        
        FMResultSet *rs = [db executeQuery:@"select id from Repository where userId = ? and isStarred = ?;", [OCTUser mrc_currentUserId], @(isStarred)];
        while ([rs next]) {
            if (oldIDs == nil) oldIDs = [NSMutableArray new];
            [oldIDs addObject:[rs stringForColumnIndex:0]];
        }
        
        for (OCTRepository *repo in repositories) {
            @autoreleasepool {
                NSMutableDictionary *dictionary = [MTLJSONAdapter JSONDictionaryFromModel:repo].mutableCopy;
                
                dictionary[@"userId"] = [OCTUser mrc_currentUserId];
                dictionary[@"owner_login"] = dictionary[@"owner"][@"login"];
                dictionary[@"owner_avatar_url"] = dictionary[@"owner"][@"avatar_url"];
                
                if (![oldIDs containsObject:repo.objectID]) { // insert
                    sql = [sql stringByAppendingString:[NSString stringWithFormat:@"insert into Repository values (%ld, %ld, %ld, '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', %ld, %ld, %ld, %ld, %ld, %ld, %ld);", [dictionary[@"userId"] integerValue], [dictionary[@"id"] integerValue], [dictionary[@"isStarred"] integerValue], [dictionary[@"name"] escapeSingleQuote], [dictionary[@"owner_login"] escapeSingleQuote], [dictionary[@"owner_avatar_url"] escapeSingleQuote], [dictionary[@"description"] escapeSingleQuote], [dictionary[@"language"] escapeSingleQuote], [dictionary[@"pushed_at"] escapeSingleQuote], [dictionary[@"created_at"] escapeSingleQuote], [dictionary[@"updated_at"] escapeSingleQuote], [dictionary[@"clone_url"] escapeSingleQuote], [dictionary[@"ssh_url"] escapeSingleQuote], [dictionary[@"git_url"] escapeSingleQuote], [dictionary[@"html_url"] escapeSingleQuote], [dictionary[@"default_branch"] escapeSingleQuote], [dictionary[@"private"] integerValue], [dictionary[@"fork"] integerValue], [dictionary[@"watchers_count"] integerValue], [dictionary[@"forks_count"] integerValue], [dictionary[@"stargazers_count"] integerValue], [dictionary[@"open_issues_count"] integerValue], [dictionary[@"subscribers_count"] integerValue]]];
                } else { // update
                    sql = [sql stringByAppendingString:[NSString stringWithFormat:@"update Repository set name = '%@', owner_login = '%@', owner_avatar_url = '%@', description = '%@', language = '%@', pushed_at = '%@', created_at = '%@', updated_at = '%@', clone_url = '%@', ssh_url = '%@', git_url = '%@', html_url = '%@', default_branch = '%@', private = %ld, fork = %ld, watchers_count = %ld, forks_count = %ld, stargazers_count = %ld, open_issues_count = %ld, subscribers_count = %ld where userId = %ld and id = %ld and isStarred = %ld;", [dictionary[@"name"] escapeSingleQuote], [dictionary[@"owner_login"] escapeSingleQuote], [dictionary[@"owner_avatar_url"] escapeSingleQuote], [dictionary[@"description"] escapeSingleQuote], [dictionary[@"language"] escapeSingleQuote], [dictionary[@"pushed_at"] escapeSingleQuote], [dictionary[@"created_at"] escapeSingleQuote], [dictionary[@"updated_at"] escapeSingleQuote], [dictionary[@"clone_url"] escapeSingleQuote], [dictionary[@"ssh_url"] escapeSingleQuote], [dictionary[@"git_url"] escapeSingleQuote], [dictionary[@"html_url"] escapeSingleQuote], [dictionary[@"default_branch"] escapeSingleQuote], [dictionary[@"private"] integerValue], [dictionary[@"fork"] integerValue], [dictionary[@"watchers_count"] integerValue], [dictionary[@"forks_count"] integerValue], [dictionary[@"stargazers_count"] integerValue], [dictionary[@"open_issues_count"] integerValue], [dictionary[@"subscribers_count"] integerValue], [dictionary[@"userId"] integerValue], [dictionary[@"id"] integerValue], [dictionary[@"isStarred"] integerValue]]];
                }
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

- (BOOL)mrc_hasUserStarred {
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        FMResultSet *rs = [db executeQuery:@"select * from Repository where userId = ? and id = ? and isStarred = ? limit 1;", [OCTUser mrc_currentUserId], self.objectID, @1];
        
        return [rs next];
    }
    return NO;
}

+ (BOOL)mrc_deleteRepositoryWithId:(NSString *)id isStarred:(BOOL)isStarred {
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        BOOL success = [db executeUpdate:@"delete from Repository where userId = ? and id = ? and isStarred = ?;", [OCTUser mrc_currentUserId], id, @(isStarred)];
        if (!success) {
            mrcLogLastError(db);
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

@end
