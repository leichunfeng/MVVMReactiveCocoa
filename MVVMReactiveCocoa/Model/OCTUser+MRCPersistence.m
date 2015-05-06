//
//  OCTUser+MRCPersistence.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "OCTUser+MRCPersistence.h"

@implementation OCTUser (Persistence)

- (BOOL)saveOrUpdate {
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        FMResultSet *rs = [db executeQuery:@"select * from User where id = ? limit 1;", self.objectID];
        if (![rs next]) {
            NSString *sql = @"insert into User values (:id, :rawLogin, :login, :name, :bio, :email, :avatar_url, :blog, :company, :location, :collaborators, :public_repos, :owned_private_repos, :public_gists, :private_gists, :followers, :following, :disk_usage);";
            
            BOOL success = [db executeUpdate:sql withParameterDictionary:[MTLJSONAdapter JSONDictionaryFromModel:self]];
            if (!success) {
                mrcLogLastError(db);
                return NO;
            }
            
            return YES;
        } else {
            NSString *sql = @"update User set rawLogin = :rawLogin, login = :login, name = :name, bio = :bio, email = :email, avatar_url = :avatar_url, blog = :blog, company = :company, location = :location, collaborators = :collaborators, public_repos = :public_repos, owned_private_repos = :owned_private_repos, public_gists = :public_gists, private_gists = :private_gists, followers = :followers, following = :following, disk_usage = :disk_usage;";
            
            BOOL success = [db executeUpdate:sql withParameterDictionary:[MTLJSONAdapter JSONDictionaryFromModel:self]];
            if (!success) {
                mrcLogLastError(db);
                return NO;
            }
            
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)delete {
	return YES;
}

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
