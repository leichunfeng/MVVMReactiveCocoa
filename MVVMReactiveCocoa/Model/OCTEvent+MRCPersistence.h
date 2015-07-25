//
//  OCTEvent+MRCPersistence.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/25.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <OctoKit/OctoKit.h>

@interface OCTEvent (MRCPersistence)

+ (BOOL)mrc_saveUserReceivedEvents:(NSArray *)events;
+ (BOOL)mrc_saveUserPerformedEvents:(NSArray *)events;

+ (NSArray *)mrc_fetchUserReceivedEvents;
+ (NSArray *)mrc_fetchUserPerformedEvents;

@end
