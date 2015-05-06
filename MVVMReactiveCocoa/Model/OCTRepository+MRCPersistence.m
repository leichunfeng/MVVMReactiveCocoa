//
//  OCTRepository+MRCPersistence.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "OCTRepository+MRCPersistence.h"

static void *OCTRepositoryIsStarredKey = &OCTRepositoryIsStarredKey;

@implementation OCTRepository (Persistence)

- (BOOL)isStarred {
    return [objc_getAssociatedObject(self, OCTRepositoryIsStarredKey) boolValue];
}

- (void)setIsStarred:(BOOL)isStarred {
    objc_setAssociatedObject(self, OCTRepositoryIsStarredKey, @(isStarred), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)saveOrUpdate {
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    
    if ([db open]) {
        @onExit {
            [db close];
        };

        NSString *sql = nil;
        
        FMResultSet *rs = [db executeQuery:@"select * from Repository where id = ? limit 1;", self.objectID];
        if (![rs next]) {
            sql = @"insert into Repository values (:id, :name, :owner_login, :description, :language, :pushed_at, :created_at, :updated_at, :clone_url, :ssh_url, :git_url, :html_url, :default_branch, :private, :fork, :watchers_count, :forks_count, :stargazers_count, :open_issues_count, :subscribers_count, :isStarred);";
        } else {
            sql = @"update Repository set name = :name, owner_login = :owner_login, description = :description, language = :language, pushed_at = :pushed_at, created_at = :created_at, updated_at = :updated_at, clone_url = :clone_url, ssh_url = :ssh_url, git_url = :git_url, html_url = :html_url, default_branch = :default_branch, private = :private, fork = :fork, watchers_count = :watchers_count, forks_count = :forks_count, stargazers_count = :stargazers_count, open_issues_count = :open_issues_count, subscribers_count = :subscribers_count, isStarred = :isStarred where id = :id;";
        }
        
        NSMutableDictionary *dictionary = [MTLJSONAdapter JSONDictionaryFromModel:self].mutableCopy;
        
        dictionary[@"owner_login"] = dictionary[@"owner"][@"login"];
        dictionary[@"isStarred"] = @(![self.ownerLogin isEqualToString:[OCTUser currentUser].login]);
        
        BOOL success = [db executeUpdate:sql withParameterDictionary:dictionary];
        if (!success) {
            mrcLogLastError(db);
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

- (BOOL)delete {
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        BOOL success = [db executeUpdate:@"delete from Repository where id = ?;", self.objectID];
        if (!success) {
            mrcLogLastError(db);
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

+ (RACSignal *)fetchUserRepositories {
    return [self fetchRepositoriesIsStarred:NO];
}

+ (RACSignal *)fetchUserStarredRepositories {
    return [self fetchRepositoriesIsStarred:YES];
}

+ (RACSignal *)fetchRepositoriesIsStarred:(BOOL)isStarred {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSMutableArray *repos = [NSMutableArray new];
        
        FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
        if ([db open]) {
            @onExit {
                [db close];
            };
            
            NSString *sql = @"select * from Repository where isStarred = ? order by name;";
            
            FMResultSet *rs = [db executeQuery:sql, @(isStarred)];
            while ([rs next]) {
                NSMutableDictionary *dictionary = rs.resultDictionary.mutableCopy;
                
                dictionary[@"owner"] = @{ @"login": dictionary[@"owner_login"] };
                [dictionary removeObjectForKey:@"owner_login"];
                
                OCTRepository *repo = [MTLJSONAdapter modelOfClass:[OCTRepository class] fromJSONDictionary:dictionary error:nil];
                
                [repos addObject:repo];
            }
        }
        
        [subscriber sendNext:repos];
        [subscriber sendCompleted];
        
        return nil;
    }];
}

+ (RACSignal *)fetchRepositoryWithName:(NSString *)name owner:(NSString *)owner {
    OCTRepository *repo = nil;
    
    NSString *sql = @"select * from Repository where name = ? and owner_login = ? limit 1;";
    
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        FMResultSet *rs = [db executeQuery:sql, name, owner];
        if ([rs next]) {
            NSMutableDictionary *dictionary = rs.resultDictionary.mutableCopy;
            
            dictionary[@"owner"] = @{ @"login": dictionary[@"owner_login"] };
            [dictionary removeObjectForKey:@"owner_login"];

            repo = [MTLJSONAdapter modelOfClass:[OCTRepository class] fromJSONDictionary:dictionary error:nil];
        }
    }
    
    return [RACSignal return:repo];
}

@end
