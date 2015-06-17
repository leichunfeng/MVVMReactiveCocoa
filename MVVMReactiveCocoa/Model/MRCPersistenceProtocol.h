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

- (BOOL)mrc_saveOrUpdate;
- (BOOL)mrc_delete;

@end
