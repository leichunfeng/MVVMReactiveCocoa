//
//  MRCViewModelServicesImpl.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCViewModelServicesImpl.h"
#import "MRCRepositoryServiceImpl.h"

@interface MRCViewModelServicesImpl ()

@property (strong, nonatomic) MRCRepositoryServiceImpl *repositoryService;

@end

@implementation MRCViewModelServicesImpl

@synthesize client = _client;

- (instancetype)init {
    self = [super init];
    if (self) {
        _repositoryService = [MRCRepositoryServiceImpl new];
    }
    return self;
}

- (void)pushViewModel:(id<MRCViewModelProtocol>)viewModel animated:(BOOL)animated {}

- (void)popViewModelAnimated:(BOOL)animated {}

- (void)popToRootViewModelAnimated:(BOOL)animated {}

- (void)presentViewModel:(id<MRCViewModelProtocol>)viewModel animated:(BOOL)animated completion:(VoidBlock)completion {}

- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion {}

- (void)resetRootViewModel:(id<MRCViewModelProtocol>)viewModel {}

- (id<MRCRepositoryService>)getRepositoryService {
    return self.repositoryService;
}

@end
