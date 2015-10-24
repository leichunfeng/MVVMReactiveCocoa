//
//  MRCSearch.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/12.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCSearch.h"

@implementation MRCSearch

#pragma mark - Query

+ (NSArray *)recentSearches {
    __block NSMutableArray *recentSearches = nil;
    
    [[FMDatabaseQueue sharedInstance] inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM Search WHERE userId = ? ORDER BY searched_at DESC", [OCTUser mrc_currentUserId]];

        @onExit {
            [rs close];
        };
        
        if (rs == nil) {
            MRCLogLastError(db);
            return;
        }
        
        while ([rs next]) {
            @autoreleasepool {
                if (recentSearches == nil) recentSearches = [[NSMutableArray alloc] init];
                
                NSMutableDictionary *dictionary = rs.resultDictionary.mutableCopy;
                [dictionary removeObjectForKey:@"userId"];
                
                MRCSearch *search = [MTLJSONAdapter modelOfClass:[MRCSearch class] fromJSONDictionary:dictionary error:nil];
                [recentSearches addObject:search];
            }
        }
    }];
    
    return recentSearches;
}

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
        @"dateSearched": @"searched_at"
    }];
}

+ (NSValueTransformer *)dateSearchedJSONTransformer {
    return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

#pragma mark - MRCPersistenceProtocol

- (BOOL)mrc_saveOrUpdate {
    __block BOOL result = YES;
    
    [[FMDatabaseQueue sharedInstance] inDatabase:^(FMDatabase *db) {
        NSString *sql = nil;
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM Search WHERE keyword = ? AND userId = ? LIMIT 1;", self.keyword, [OCTUser mrc_currentUserId]];

        @onExit {
            [rs close];
        };
        
        if (rs == nil) {
            MRCLogLastError(db);
            result = NO;
            return;
        }
        
        if (![rs next]) {
            sql = @"INSERT INTO Search VALUES (:id, :keyword, :searched_at, :userId);";
        } else {
            sql = @"UPDATE Search SET searched_at = :searched_at WHERE keyword = :keyword AND userId = :userId;";
        }
        
        NSMutableDictionary *dictionary = [MTLJSONAdapter JSONDictionaryFromModel:self].mutableCopy;
        dictionary[@"userId"] = [OCTUser mrc_currentUserId];
        
        BOOL success = [db executeUpdate:sql withParameterDictionary:dictionary];
        if (!success) {
            MRCLogLastError(db);
            result = NO;
            return;
        }
    }];
    
    return result;
}

- (BOOL)mrc_delete {
    __block BOOL result = YES;
    
    [[FMDatabaseQueue sharedInstance] inDatabase:^(FMDatabase *db) {
        BOOL success = [db executeUpdate:@"DELETE FROM Search WHERE id = ?;", self.objectID];
        if (!success) {
            MRCLogLastError(db);
            result = NO;
            return;
        }
    }];

    return result;
}

@end
