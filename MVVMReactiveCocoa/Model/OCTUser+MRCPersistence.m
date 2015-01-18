//
//  OCTUser+MRCPersistence.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "OCTUser+MRCPersistence.h"

@implementation OCTUser (Persistence)

- (BOOL)save {
    return [NSKeyedArchiver archiveRootObject:self toFile:[[self.class persistenceDirectory] stringByAppendingPathComponent:self.rawLogin]];
}

+ (NSString *)persistenceDirectory {
    NSString *persistenceDirectory = [MRC_DOCUMENT_DIRECTORY stringByAppendingPathComponent:@"Persistence/Users"];
    BOOL isDirectory;
    if (![[NSFileManager defaultManager] fileExistsAtPath:persistenceDirectory isDirectory:&isDirectory] || !isDirectory) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:persistenceDirectory withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) NSLog(@"Error: %@", error);
    }
    return persistenceDirectory;
}

+ (OCTUser *)currentUser {
    return [self fetchUserWithRawLogin:[SSKeychain passwordForService:MRC_SERVICE_NAME account:MRC_RAW_LOGIN]];
}

+ (OCTUser *)fetchUserWithRawLogin:(NSString *)rawLogin {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[[self.class persistenceDirectory] stringByAppendingPathComponent:rawLogin]];
}

@end
