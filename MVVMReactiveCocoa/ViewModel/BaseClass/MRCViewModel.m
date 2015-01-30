//
//  MRCViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCViewModel.h"

@implementation MRCViewModel

@synthesize services = _services;
@synthesize params   = _params;
@synthesize callback = _callback;
@synthesize errors   = _errors;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    MRCViewModel *viewModel = [super allocWithZone:zone];
    [[viewModel
    	rac_signalForSelector:@selector(initWithServices:params:)]
    	subscribeNext:^(id x) {
            [viewModel initialize];
        }];
    return viewModel;
}

- (instancetype)initWithServices:(id)services params:(id)params {
    self = [super init];
    if (self) {
        _services = services;
        _params   = params;
    }
    return self;
}

- (RACSubject *)errors {
    if (!_errors) _errors = [RACSubject subject];
    return _errors;
}

- (void)initialize {}

@end
