//
//  OCTObject+MRCPersistence.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/20.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <OctoKit/OctoKit.h>
#import "MRCPersistenceProtocol.h"

@interface OCTObject (MRCPersistence) <MRCPersistenceProtocol>

@property (assign, nonatomic) NSInteger rowId;

- (void)mergeValuesForKeysFromModelExcludeRowId:(MTLModel *)model;

+ (RACSignal *)updateLocalObjects:(NSArray *)localObjects withRemoteObjects:(NSArray *)remoteObjects;

@end
