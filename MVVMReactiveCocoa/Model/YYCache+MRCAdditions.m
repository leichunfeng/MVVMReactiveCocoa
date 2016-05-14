//
//  YYCache+MRCAdditions.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/5/12.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "YYCache+MRCAdditions.h"

NSString * const MRCExploreShowcasesCacheKey     = @"MRCExploreShowcasesCacheKey";
NSString * const MRCExploreTrendingReposCacheKey = @"MRCExploreTrendingReposCacheKey";
NSString * const MRCExplorePopularReposCacheKey  = @"MRCExplorePopularReposCacheKey";
NSString * const MRCExplorePopularUsersCacheKey  = @"MRCExplorePopularUsersCacheKey";

NSString * const MRCTrendingReposLanguageCacheKey = @"MRCTrendingReposLanguageCacheKey";
NSString * const MRCPopularReposLanguageCacheKey  = @"MRCPopularReposLanguageCacheKey";
NSString * const MRCPopularUsersCountryCacheKey   = @"MRCPopularUsersCountryCacheKey";
NSString * const MRCPopularUsersLanguageCacheKey  = @"MRCPopularUsersLanguageCacheKey";

@implementation YYCache (MRCAdditions)

+ (instancetype)sharedCache {
    static YYCache *sharedCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *login = [OCTUser mrc_currentUser].login;
        NSParameterAssert(login.length > 0);
        sharedCache = [YYCache cacheWithName:login];
    });
    return sharedCache;
}

@end
