//
//  YYCache+MRCAdditions.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/5/12.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "YYCache.h"

extern NSString * const MRCExploreShowcasesCacheKey;
extern NSString * const MRCExploreTrendingReposCacheKey;
extern NSString * const MRCExplorePopularReposCacheKey;
extern NSString * const MRCExplorePopularUsersCacheKey;

extern NSString * const MRCTrendingReposLanguageCacheKey;
extern NSString * const MRCPopularReposLanguageCacheKey;
extern NSString * const MRCPopularUsersCountryCacheKey;
extern NSString * const MRCPopularUsersLanguageCacheKey;

@interface YYCache (MRCAdditions)

+ (instancetype)sharedCache;

@end
