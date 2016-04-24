//
//  MRCRepositoryService.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/27.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MRCRepositoryService <NSObject>

- (RACSignal *)requestRepositoryReadmeHTML:(OCTRepository *)repository reference:(NSString *)reference;
- (RACSignal *)requestTrendingRepositoriesSince:(NSString *)since language:(NSString *)language;

/// Request showcases from http://trending.codehub-app.com/v2/showcases
///
/// @return Showcases
- (RACSignal *)requestShowcases;

/// Request showcase repos , such as http://trending.codehub-app.com/v2/showcases/swift
///
/// @param slug
///
/// @return
- (RACSignal *)requestShowcaseRepositoriesWithSlug:(NSString *)slug;

@end
