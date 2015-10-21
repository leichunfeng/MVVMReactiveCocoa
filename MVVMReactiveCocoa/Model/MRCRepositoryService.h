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

@end
