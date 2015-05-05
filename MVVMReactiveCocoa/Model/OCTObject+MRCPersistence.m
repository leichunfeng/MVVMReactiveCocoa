//
//  OCTObject+MRCPersistence.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/20.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "OCTObject+MRCPersistence.h"
#import <objc/runtime.h>

static void *OCTObjectKey = &OCTObjectKey;
static void *OCTObjectIDKey = &OCTObjectIDKey;

@implementation OCTObject (MRCPersistence)

- (NSInteger)rowId {
    return [objc_getAssociatedObject(self, OCTObjectIDKey) integerValue];
}

- (void)setRowId:(NSInteger)rowId {
    objc_setAssociatedObject(self, OCTObjectIDKey, @(rowId), OBJC_ASSOCIATION_ASSIGN);
}

- (void)mergeValuesForKeysFromModelExcludeRowId:(MTLModel *)model {
    NSInteger rowId = self.rowId;
    [self mergeValuesForKeysFromModel:model];
    self.rowId = rowId;
}

- (BOOL)save {
    return YES;
}

- (void)delete {}

+ (RACSignal *)updateLocalObjects:(NSArray *)localObjects withRemoteObjects:(NSArray *)remoteObjects {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        if (localObjects.count == 0) {
            [remoteObjects.rac_sequence.signal subscribeNext:^(OCTObject *object) {
                [object save];
            } completed:^{
                [subscriber sendNext:@YES];
                [subscriber sendCompleted];
            }];
        } else {
            NSArray *localObjectIDs = [localObjects.rac_sequence map:^id(OCTObject *object) {
                objc_setAssociatedObject(object.objectID, OCTObjectKey, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                return object.objectID;
            }].array;
            NSArray *remoteObjectIDs = [remoteObjects.rac_sequence map:^id(OCTObject *object) {
                objc_setAssociatedObject(object.objectID, OCTObjectKey, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                return object.objectID;
            }].array;
            NSArray *unionObjectIDs = [NSSet setWithArray:[@[ localObjectIDs.rac_sequence, remoteObjectIDs.rac_sequence ].rac_sequence flatten].array].rac_sequence.array;
            
            [unionObjectIDs.rac_sequence.signal subscribeNext:^(NSString *objectID) {
                BOOL localContains  = [localObjectIDs containsObject:objectID];
                BOOL remoteContains = [remoteObjectIDs containsObject:objectID];
                
                if (localContains && !remoteContains) { // delete
                	[objc_getAssociatedObject(objectID, OCTObjectKey) delete];
				} else if (!localContains && remoteContains) { // save
                	[objc_getAssociatedObject(objectID, OCTObjectKey) save];
				} else if (localContains && remoteContains) { // update
                	OCTObject *localObject  = objc_getAssociatedObject([localObjectIDs objectAtIndex:[localObjectIDs indexOfObject:objectID]], OCTObjectKey);
                	OCTObject *remoteObject = objc_getAssociatedObject([remoteObjectIDs objectAtIndex:[remoteObjectIDs indexOfObject:objectID]], OCTObjectKey);
                	[localObject mergeValuesForKeysFromModel:remoteObject];
               		[localObject save];
                }
            } completed:^{
                [subscriber sendNext:@YES];
                [subscriber sendCompleted];
            }];
        }
        return nil;
    }];
}

@end
