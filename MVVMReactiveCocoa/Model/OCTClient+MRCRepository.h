//
//  OCTClient+MRCRepository.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <OctoKit/OctoKit.h>

@interface OCTClient (MRCRepository)

/// Star the given `repository`
///
/// repository - The repository to star. Cannot be nil.
///
/// Returns a signal, which will send completed on success. If the client
/// is not `authenticated`, the signal will error immediately.
- (RACSignal *)mrc_starRepository:(OCTRepository *)repository;

/// Unstar the given `repository`
///
/// repository - The repository to unstar. Cannot be nil.
///
/// Returns a signal, which will send completed on success. If the client
/// is not `authenticated`, the signal will error immediately.
- (RACSignal *)mrc_unstarRepository:(OCTRepository *)repository;

@end
