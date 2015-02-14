//
//  OCTRepository+MRCPersistence.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "OCTRepository+MRCPersistence.h"

static void *OCTRepositoryKey = &OCTRepositoryKey;
static void *OCTRepositoryStarredKey = &OCTRepositoryStarredKey;

@implementation OCTRepository (Persistence)

- (BOOL)isStarred {
    return objc_getAssociatedObject(self, OCTRepositoryStarredKey);
}

- (void)setStarred:(BOOL)starred {
    objc_setAssociatedObject(self, OCTRepositoryStarredKey, @(starred), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)save {
    NSString *persistenceDirectory = self.isStarred ? self.class.persistenceDirectoryOfStarred : self.class.persistenceDirectoryOfOwned;
    NSString *path = [NSString stringWithFormat:@"%@/%@&%@", persistenceDirectory, self.name, self.ownerLogin];
    return [NSKeyedArchiver archiveRootObject:self toFile:path];
}

- (void)delete {
    NSString *persistenceDirectory = self.isStarred ? self.class.persistenceDirectoryOfStarred : self.class.persistenceDirectoryOfOwned;
    NSString *path = [NSString stringWithFormat:@"%@/%@&%@", persistenceDirectory, self.name, self.ownerLogin];
   
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
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSError *error = nil;
        NSArray *uniqueNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.class.persistenceDirectoryOfOwned error:&error];
        if (error) [subscriber sendError:error];
        
        @weakify(self)
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
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSError *error = nil;
        NSArray *uniqueNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.class.persistenceDirectoryOfStarred error:&error];
        if (error) [subscriber sendError:error];
        
        @weakify(self)
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
    
    OCTRepository *repository = [NSKeyedUnarchiver unarchiveObjectWithFile:[persistenceDirectory stringByAppendingPathComponent:uniqueName]];
    repository.starred = isStarred;
    
    return repository;
}

+ (RACSignal *)fetchRepositoryWithName:(NSString *)name owner:(NSString *)owner {
    BOOL isStarred = ![owner isEqualToString:SSKeychain.rawLogin];
    
    NSString *uniqueName = [NSString stringWithFormat:@"%@&%@", name, owner];
    OCTRepository *repository = [self fetchRepositoryWithUniqueName:uniqueName isStarred:isStarred];
    
    return [RACSignal return:repository];
}

@end
