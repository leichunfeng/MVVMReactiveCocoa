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
    NSString *persistenceDirectory = [self isStarred] ? [self.class persistenceDirectoryOfStarred] : [self.class persistenceDirectoryOfOwned];
    NSString *path = [NSString stringWithFormat:@"%@/%@&%@", persistenceDirectory, self.name, self.ownerLogin];
    return [NSKeyedArchiver archiveRootObject:self toFile:path];
}

- (void)delete {
    NSString *persistenceDirectory = [self isStarred] ? [self.class persistenceDirectoryOfStarred] : [self.class persistenceDirectoryOfOwned];
    NSString *path = [NSString stringWithFormat:@"%@/%@&%@", persistenceDirectory, self.name, self.ownerLogin];
   
    NSError *error = nil;
    [NSFileManager.defaultManager removeItemAtPath:path error:&error];
    if (error) NSLog(@"Error: %@", error);
}

+ (NSString *)persistenceDirectoryOfOwned {
    NSString *persistenceDirectory = [NSString stringWithFormat:@"%@/Persistence/Repositories/%@/Owned", MRC_DOCUMENT_DIRECTORY, [OCTUser currentUser].rawLogin];
    BOOL isDirectory;
    if (![[NSFileManager defaultManager] fileExistsAtPath:persistenceDirectory isDirectory:&isDirectory] || !isDirectory) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:persistenceDirectory withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) NSLog(@"Error: %@", error);
    }
    return persistenceDirectory;
}

+ (NSString *)persistenceDirectoryOfStarred {
    NSString *persistenceDirectory = [NSString stringWithFormat:@"%@/Persistence/Repositories/%@/Starred", MRC_DOCUMENT_DIRECTORY, [OCTUser currentUser].rawLogin];
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
        NSArray *uniqueNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self.class persistenceDirectoryOfOwned] error:&error];
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
        NSArray *uniqueNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self.class persistenceDirectoryOfStarred] error:&error];
        if (error) [subscriber sendError:error];
        
        @weakify(self)
        NSArray *repositories = [uniqueNames.rac_sequence map:^id(NSString *uniqueName) {
            @strongify(self)
            OCTRepository *repository = [self fetchRepositoryWithUniqueName:uniqueName isStarred:YES];
            [repository setStarred:YES];
            return repository;
        }].array;
        
        [subscriber sendNext:repositories];
        [subscriber sendCompleted];
        
        return nil;
    }];
}

+ (OCTRepository *)fetchRepositoryWithUniqueName:(NSString *)uniqueName isStarred:(BOOL)isStarred {
    NSString *persistenceDirectory = isStarred ? [self.class persistenceDirectoryOfStarred] : [self.class persistenceDirectoryOfOwned];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[persistenceDirectory stringByAppendingPathComponent:uniqueName]];
}

+ (RACSignal *)updateLocalDataWithRemoteUserRepos:(NSArray *)remoteUserRepos {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        [[self.class
          	fetchUserRepositories]
         	subscribeNext:^(NSArray *localUserRepos) {
                if (localUserRepos.count == 0) {
                    [remoteUserRepos.rac_sequence.signal subscribeNext:^(OCTRepository *repository) {
                        [repository save];
                    } completed:^{
                        [subscriber sendNext:@YES];
                        [subscriber sendCompleted];
                    }];
                } else {
                    NSArray *localObjectIDs = [localUserRepos.rac_sequence map:^id(OCTRepository *repository) {
                        objc_setAssociatedObject(repository.objectID, OCTRepositoryKey, repository, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                        return repository.objectID;
                    }].array;
                    NSArray *remoteObjectIDs = [remoteUserRepos.rac_sequence map:^id(OCTRepository *repository) {
                        objc_setAssociatedObject(repository.objectID, OCTRepositoryKey, repository, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                        return repository.objectID;
                    }].array;
                    NSArray *unionofObjectIDs = [NSSet setWithArray:[@[ localObjectIDs.rac_sequence, remoteObjectIDs.rac_sequence ].rac_sequence flatten].array].rac_sequence.array;
                    
                    [unionofObjectIDs.rac_sequence.signal subscribeNext:^(NSString *objectID) {
                        BOOL localContains  = [localObjectIDs containsObject:objectID];
                        BOOL remoteContains = [remoteObjectIDs containsObject:objectID];
                        
                        if (localContains && !remoteContains) { // delete
                            [objc_getAssociatedObject(objectID, OCTRepositoryKey) delete];
                        } else if (!localContains && remoteContains) { // save
                            [objc_getAssociatedObject(objectID, OCTRepositoryKey) save];
                        } else if (localContains && remoteContains) { // update
                            OCTRepository *localRepository = objc_getAssociatedObject([localObjectIDs objectAtIndex:[localObjectIDs indexOfObject:objectID]], OCTRepositoryKey);
                            OCTRepository *remoteRepository = objc_getAssociatedObject([remoteObjectIDs objectAtIndex:[remoteObjectIDs indexOfObject:objectID]], OCTRepositoryKey);
                            [localRepository mergeValuesForKeysFromModel:remoteRepository];
                            [localRepository save];
                        }
                    } completed:^{
                        [subscriber sendNext:@YES];
                        [subscriber sendCompleted];
                    }];
                }
        	}];
        return nil;
    }];
}

@end
