//
//  MRCPersistenceProtocol.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MRCPersistenceProtocol <NSObject>

@required

// Persistence method, save the object to disk.
//
// Returns YES or NO.
- (BOOL)save;

- (void)delete;

@end
