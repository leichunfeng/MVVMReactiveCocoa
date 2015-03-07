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
    return [NSKeyedArchiver archiveRootObject:self toFile:[[self.class persistenceDirectory] stringByAppendingPathComponent:self.login]];
}

- (void)delete {}

+ (NSString *)persistenceDirectory {
    NSString *persistenceDirectory = [MRC_DOCUMENT_DIRECTORY stringByAppendingPathComponent:@"Persistence/Users"];
    BOOL isDirectory;
    if (![NSFileManager.defaultManager fileExistsAtPath:persistenceDirectory isDirectory:&isDirectory] || !isDirectory) {
        NSError *error = nil;
        [NSFileManager.defaultManager createDirectoryAtPath:persistenceDirectory withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) NSLog(@"Error: %@", error);
    }
    return persistenceDirectory;
}

+ (OCTUser *)currentUser {
    return [self fetchUserWithRawLogin:SSKeychain.rawLogin];
}

+ (OCTUser *)fetchUserWithRawLogin:(NSString *)rawLogin {
    NSError *error = nil;
    NSArray *uniqueNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self.class persistenceDirectory] error:&error];
    if (error) NSLog(@"Error: %@", error);
    
    @weakify(self)
    NSArray *users = [[uniqueNames.rac_sequence
        map:^id(NSString *uniqueName) {
            @strongify(self)
            return [self fetchUserWithUniqueName:uniqueName];
        }]
        filter:^BOOL(OCTUser *user) {
            return [user.rawLogin isEqualToString:rawLogin];
        }].array;
    
    return users.firstObject;
}

+ (OCTUser *)fetchUserWithUniqueName:(NSString *)uniqueName {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[[self.class persistenceDirectory] stringByAppendingPathComponent:uniqueName]];
}

@end
