//
//  OCTRepository+MRCPersistence.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "OCTRepository+MRCPersistence.h"

const void *OCTRepositoryStarredKey = &OCTRepositoryStarredKey;

@implementation OCTRepository (Persistence)

- (BOOL)starred {
    return objc_getAssociatedObject(self, OCTRepositoryStarredKey);
}

- (void)setStarred:(BOOL)starred {
    objc_setAssociatedObject(self, OCTRepositoryStarredKey, @(starred), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)save {
    return [self starred] ? [NSKeyedArchiver archiveRootObject:self toFile:[[self persistenceDirectoryOfStarred] stringByAppendingPathComponent:self.name]] : [NSKeyedArchiver archiveRootObject:self toFile:[[self persistenceDirectoryOfRepositories] stringByAppendingPathComponent:self.name]];
}

- (NSString *)persistenceDirectoryOfRepositories {
    NSString *persistenceDirectory = [NSString stringWithFormat:@"%@/Persistence/Repositories/%@/Owned", MRC_DOCUMENT_DIRECTORY, self.ownerLogin];
    BOOL isDirectory;
    if (![[NSFileManager defaultManager] fileExistsAtPath:persistenceDirectory isDirectory:&isDirectory] || !isDirectory) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:persistenceDirectory withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"Error: %@", error);
        }
    }
    return persistenceDirectory;
}

- (NSString *)persistenceDirectoryOfStarred {
    NSString *persistenceDirectory = [NSString stringWithFormat:@"%@/Persistence/Repositories/%@/Starred", MRC_DOCUMENT_DIRECTORY, self.ownerLogin];
    BOOL isDirectory;
    if (![[NSFileManager defaultManager] fileExistsAtPath:persistenceDirectory isDirectory:&isDirectory] || !isDirectory) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:persistenceDirectory withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"Error: %@", error);
        }
    }
    return persistenceDirectory;
}

+ (NSArray *)fetchUserRepositories {
    NSString *persistenceDirectory = [NSString stringWithFormat:@"%@/Persistence/Repositories/%@/Owned", MRC_DOCUMENT_DIRECTORY, [OCTUser rawLoginOfCurrentUser]];
    NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:persistenceDirectory error:NULL];
    return array;
}

@end
