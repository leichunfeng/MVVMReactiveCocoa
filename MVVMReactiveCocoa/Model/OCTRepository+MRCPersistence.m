//
//  OCTRepository+MRCPersistence.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "OCTRepository+MRCPersistence.h"

@implementation OCTRepository (Persistence)

- (BOOL)isStarred {
    return ![self.ownerLogin isEqualToString:SSKeychain.rawLogin];
}

- (BOOL)save {
    NSString *persistenceDirectory = self.isStarred ? self.class.persistenceDirectoryOfStarred : self.class.persistenceDirectoryOfOwned;
    NSString *path = [NSString stringWithFormat:@"%@/%@&%@", persistenceDirectory, self.ownerLogin, self.name];
    return [NSKeyedArchiver archiveRootObject:self toFile:path];
}

- (void)delete {
    NSString *persistenceDirectory = self.isStarred ? self.class.persistenceDirectoryOfStarred : self.class.persistenceDirectoryOfOwned;
    NSString *path = [NSString stringWithFormat:@"%@/%@&%@", persistenceDirectory, self.ownerLogin, self.name];
   
    NSError *error = nil;
    [NSFileManager.defaultManager removeItemAtPath:path error:&error];
    if (error) NSLog(@"Error: %@", error);
}

+ (NSString *)persistenceDirectoryOfOwned {
    NSString *persistenceDirectory = [NSString stringWithFormat:@"%@/Persistence/Repositories/%@/Owned", MRC_DOCUMENT_DIRECTORY, SSKeychain.rawLogin];
    BOOL isDirectory;
    if (![[NSFileManager defaultManager] fileExistsAtPath:persistenceDirectory isDirectory:&isDirectory] || !isDirectory) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:persistenceDirectory withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) NSLog(@"Error: %@", error);
    }
    return persistenceDirectory;
}

+ (NSString *)persistenceDirectoryOfStarred {
    NSString *persistenceDirectory = [NSString stringWithFormat:@"%@/Persistence/Repositories/%@/Starred", MRC_DOCUMENT_DIRECTORY, SSKeychain.rawLogin];
    BOOL isDirectory;
    if (![[NSFileManager defaultManager] fileExistsAtPath:persistenceDirectory isDirectory:&isDirectory] || !isDirectory) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:persistenceDirectory withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) NSLog(@"Error: %@", error);
    }
    return persistenceDirectory;
}

+ (RACSignal *)fetchUserRepositories {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        NSError *error = nil;
        NSArray *uniqueNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.class.persistenceDirectoryOfOwned error:&error];
        if (error) [subscriber sendError:error];
        
        NSArray *repositories = [uniqueNames.rac_sequence map:^id(NSString *uniqueName) {
            @strongify(self)
            return [self fetchRepositoryWithUniqueName:uniqueName isStarred:NO];
        }].array;
        
        [subscriber sendNext:repositories];
        [subscriber sendCompleted];
        
        return nil;
    }];
}

+ (RACSignal *)fetchUserStarredRepositories {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        NSError *error = nil;
        NSArray *uniqueNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.class.persistenceDirectoryOfStarred error:&error];
        if (error) [subscriber sendError:error];
        
        NSArray *repositories = [uniqueNames.rac_sequence map:^id(NSString *uniqueName) {
            @strongify(self)
            return [self fetchRepositoryWithUniqueName:uniqueName isStarred:YES];
        }].array;
        
        [subscriber sendNext:repositories];
        [subscriber sendCompleted];
        
        return nil;
    }];
}

+ (OCTRepository *)fetchRepositoryWithUniqueName:(NSString *)uniqueName isStarred:(BOOL)isStarred {
    NSString *persistenceDirectory = isStarred ? self.class.persistenceDirectoryOfStarred : self.class.persistenceDirectoryOfOwned;
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[persistenceDirectory stringByAppendingPathComponent:uniqueName]];
}

+ (RACSignal *)fetchRepositoryWithName:(NSString *)name owner:(NSString *)owner {
    BOOL isStarred = ![owner isEqualToString:SSKeychain.rawLogin];
    
    NSString *uniqueName = [NSString stringWithFormat:@"%@&%@", owner, name];
    OCTRepository *repository = [self fetchRepositoryWithUniqueName:uniqueName isStarred:isStarred];
    
    return [RACSignal return:repository];
}

@end
