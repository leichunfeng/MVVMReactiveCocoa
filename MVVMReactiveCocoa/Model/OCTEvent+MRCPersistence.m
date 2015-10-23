//
//  OCTEvent+MRCPersistence.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/25.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "OCTEvent+MRCPersistence.h"

@implementation OCTEvent (MRCPersistence)

+ (BOOL)mrc_saveUserReceivedEvents:(NSArray *)events {
    return [NSKeyedArchiver archiveRootObject:events toFile:[self receivedEventsPersistencePath]];
}

+ (BOOL)mrc_saveUserPerformedEvents:(NSArray *)events {
    return [NSKeyedArchiver archiveRootObject:events toFile:[self performedEventsPersistencePath]];
}

+ (NSArray *)mrc_fetchUserReceivedEvents {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self receivedEventsPersistencePath]];
}

+ (NSArray *)mrc_fetchUserPerformedEvents {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self performedEventsPersistencePath]];
}

#pragma mark - Private Method

+ (NSString *)persistenceDirectory {
    NSString *path = [NSString stringWithFormat:@"%@/Persistence/%@", MRC_DOCUMENT_DIRECTORY, [OCTUser mrc_currentUser].login];
    
    BOOL isDirectory;
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    if (!isExist || !isDirectory) {
        NSError *error = nil;
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:path
                                                 withIntermediateDirectories:YES
                                                                  attributes:nil
                                                                       error:&error];
        if (success) {
            [self addSkipBackupAttributeToItemAtPath:path];
        } else {
            MRCLogError(error);
        }
    }
    
    return path;
}

+ (NSString *)receivedEventsPersistencePath {
    return [[self persistenceDirectory] stringByAppendingPathComponent:@"ReceivedEvents"];
}

+ (NSString *)performedEventsPersistencePath {
    return [[self persistenceDirectory] stringByAppendingPathComponent:@"PerformedEvents"];
}

+ (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *)filePathString {
    NSURL *URL = [NSURL fileURLWithPath:filePathString];
    
    assert([[NSFileManager defaultManager] fileExistsAtPath:URL.path]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (error) MRCLogError(error);
    
    return success;
}

@end
