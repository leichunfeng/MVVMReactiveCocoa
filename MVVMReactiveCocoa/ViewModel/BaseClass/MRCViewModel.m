//
//  MRCViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCViewModel.h"

@interface MRCViewModel ()

@property (nonatomic, strong, readwrite) id<MRCViewModelServices> services;
@property (nonatomic, strong, readwrite) id params;

@end

@implementation MRCViewModel

@synthesize services = _services;
@synthesize params   = _params;
@synthesize title    = _title;
@synthesize subtitle = _subtitle;
@synthesize callback = _callback;
@synthesize errors   = _errors;
@synthesize titleViewType = _titleViewType;
@synthesize willDisappearSignal = _willDisappearSignal;
@synthesize shouldFetchLocalDataOnViewModelInitialize = _shouldFetchLocalDataOnViewModelInitialize;
@synthesize shouldRequestRemoteDataOnViewDidLoad = _shouldRequestRemoteDataOnViewDidLoad;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    MRCViewModel *viewModel = [super allocWithZone:zone];
    
    @weakify(viewModel)
    [[viewModel
    	rac_signalForSelector:@selector(initWithServices:params:)]
    	subscribeNext:^(id x) {
            @strongify(viewModel)
            [viewModel initialize];
        }];
    
    return viewModel;
}

- (instancetype)initWithServices:(id)services params:(id)params {
    self = [super init];
    if (self) { 
        self.shouldFetchLocalDataOnViewModelInitialize = YES;
        self.shouldRequestRemoteDataOnViewDidLoad = YES;
        self.title    = params[@"title"];
        self.services = services;
        self.params   = params;
    }
    return self;
}

- (RACSubject *)errors {
    if (!_errors) _errors = [RACSubject subject];
    return _errors;
}

- (RACSubject *)willDisappearSignal {
    if (!_willDisappearSignal) _willDisappearSignal = [RACSubject subject];
    return _willDisappearSignal;
}

- (void)initialize {}

@end
