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

+ (NSArray *)mrc_fetchUserReceivedEvents {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self receivedEventsPersistencePath]];
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
            NSLog(@"Error: %@", error);
        }
    }
    
    return path;
}

+ (NSString *)receivedEventsPersistencePath {
    return [[self persistenceDirectory] stringByAppendingPathComponent:@"ReceivedEvents"];
}

+ (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *)filePathString {
    NSURL *URL = [NSURL fileURLWithPath:filePathString];
    
    assert([[NSFileManager defaultManager] fileExistsAtPath:URL.path]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (!success) NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    
    return success;
}

@end
