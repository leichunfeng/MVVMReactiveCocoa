//
//  FMDatabaseQueue+MRCHelper.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/22.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "FMDatabaseQueue+MRCHelper.h"

@implementation FMDatabaseQueue (MRCHelper)

+ (instancetype)sharedInstance {
    static FMDatabaseQueue *databaseQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        databaseQueue = [FMDatabaseQueue databaseQueueWithPath:MRC_FMDB_PATH];
    });
    return databaseQueue;
}

@end
