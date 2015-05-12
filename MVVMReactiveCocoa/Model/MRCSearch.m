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

+ (NSArray *)mrc_recentSearches {
    NSArray *recentSearches = nil;
    
    NSMutableArray *dictionaries = nil;
    
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *sql = @"select * from Search where userId = ? order by searched_at desc";
        FMResultSet *rs = [db executeQuery:sql, [OCTUser mrc_currentUserId]];
        while ([rs next]) {
            @autoreleasepool {
                if (dictionaries == nil) dictionaries = [NSMutableArray new];
                
                NSMutableDictionary *dictionary = rs.resultDictionary.mutableCopy;
                [dictionary removeObjectForKey:@"userId"];
                
                [dictionaries addObject:dictionary];
            }
        }
        
        recentSearches = [MTLJSONAdapter modelsOfClass:[MRCSearch class] fromJSONArray:dictionaries error:nil];
    }
    
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
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *sql = nil;
        
        FMResultSet *rs = [db executeQuery:@"select * from Search where keyword = ? and userId = ? limit 1;", self.keyword, [OCTUser mrc_currentUserId]];
        if (![rs next]) {
            sql = @"insert into Search values (:id, :keyword, :searched_at, :userId);";
        } else {
            sql = @"update Search set searched_at = :searched_at where keyword = :keyword and userId = :userId;";
        }

        NSMutableDictionary *dictionary = [MTLJSONAdapter JSONDictionaryFromModel:self].mutableCopy;
        dictionary[@"userId"] = [OCTUser mrc_currentUserId];
        
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
        
        BOOL success = [db executeUpdate:@"delete from Search where id = ?;", self.objectID];
        if (!success) {
            mrcLogLastError(db);
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

@end
