//
//  OCTUser+MRCPersistence.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "OCTUser+MRCPersistence.h"

@implementation OCTUser (Persistence)

- (BOOL)save {
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *sql = @"insert into User values (NULL, :rawLogin, :login, :name, :bio, :email, :avatar_url, :blog, :company, :location, :collaborators, :public_repos, :owned_private_repos, :public_gists, :private_gists, :followers, :following, :disk_usage);";

        if (![db executeUpdate:sql withParameterDictionary:[MTLJSONAdapter JSONDictionaryFromModel:self]]) {
            mrcLogLastError(db);
            return NO;
        }
        
        return YES;
    }
    return NO;
}

- (BOOL)update {
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
    	};
        
        NSString *sql = @"update User set rawLogin = ?, login = ?, name = ?, bio = ?, email = ?, avatar_url = ?, blog = ?, company = ?, location = ?, collaborators = ?, public_repos = ?, owned_private_repos = ?, public_gists = ?, private_gists = ?, followers = ?, following = ?, disk_usage = ?";
        
        NSDictionary *dictionary = [MTLJSONAdapter JSONDictionaryFromModel:self];
        BOOL success = [db executeUpdate:sql, dictionary[@"rawLogin"], dictionary[@"login"], dictionary[@"name"], dictionary[@"bio"], dictionary[@"email"], dictionary[@"avatar_url"], dictionary[@"blog"], dictionary[@"company"], dictionary[@"location"], dictionary[@"collaborators"], dictionary[@"public_repos"], dictionary[@"owned_private_repos"], dictionary[@"public_gists"], dictionary[@"private_gists"], dictionary[@"followers"], dictionary[@"following"], dictionary[@"disk_usage"]];
        
        if (!success) {
            mrcLogLastError(db);
            return NO;
        }
        
        return YES;
    }
    return NO;
}

- (BOOL)saveOrUpdate {
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        FMResultSet *rs = [db executeQuery:@"select * from User where rowId = ? limit 1;", @(self.rowId)];
        if ([rs next]) {
            return [self update];
        } else {
            return [self save];
        }
    }
    return NO;
}

- (void)delete {}

+ (NSString *)persistenceDirectory {
    NSString *persistenceDirectory = [MRC_DOCUMENT_DIRECTORY stringByAppendingPathComponent:@"Persistence/Users"];
    BOOL isDirectory;
    if (![NSFileManager.defaultManager fileExistsAtPath:persistenceDirectory isDirectory:&isDirectory] || !isDirectory) {
        NSError *error = nil;
        [NSFileManager.defaultManager createDirectoryAtPath:persistenceDirectory withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) NSLog(@"Error: %@", error);
    }
    return persistenceDirectory;
}

+ (OCTUser *)currentUser {
    return [self fetchUserWithRawLogin:[SSKeychain rawLogin]];
}

+ (OCTUser *)fetchUserWithRawLogin:(NSString *)rawLogin {
    OCTUser *user = nil;
    
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        FMResultSet *rs = [db executeQuery:@"select * from User where rawLogin = ? limit 1;", rawLogin];
        if ([rs next]) {
            user = [MTLJSONAdapter modelOfClass:[OCTUser class] fromJSONDictionary:rs.resultDictionary error:nil];
        }
    }
    
    return user;
}

+ (OCTUser *)fetchUserWithUniqueName:(NSString *)uniqueName {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[[self.class persistenceDirectory] stringByAppendingPathComponent:uniqueName]];
}

@end
