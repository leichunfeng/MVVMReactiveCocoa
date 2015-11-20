//
//  MRCViewModelServicesImpl.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCViewModelServicesImpl.h"
#import "MRCRepositoryServiceImpl.h"
#import "MRCAppStoreServiceImpl.h"

@implementation MRCViewModelServicesImpl

@synthesize client = _client;
@synthesize repositoryService = _repositoryService;
@synthesize appStoreService = _appStoreService;

- (instancetype)init {
    self = [super init];
    if (self) {
        _repositoryService = [[MRCRepositoryServiceImpl alloc] init];
        _appStoreService   = [[MRCAppStoreServiceImpl alloc] init];
    }
    return self;
}

- (void)pushViewModel:(MRCViewModel *)viewModel animated:(BOOL)animated {}

- (void)popViewModelAnimated:(BOOL)animated {}

- (void)popToRootViewModelAnimated:(BOOL)animated {}

- (void)presentViewModel:(MRCViewModel *)viewModel animated:(BOOL)animated completion:(VoidBlock)completion {}

- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion {}

- (void)resetRootViewModel:(MRCViewModel *)viewModel {}

@end
