//
//  MRCTableViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCTableViewModel.h"

@interface MRCTableViewModel ()

@property (strong, nonatomic) RACCommand *fetchLocalDataCommand;
@property (strong, nonatomic, readwrite) RACCommand *requestRemoteDataCommand;

@end

@implementation MRCTableViewModel

- (void)initialize {
    [super initialize];
    
    @weakify(self)
    self.fetchLocalDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [self fetchLocalDataSignal];
    }];
    
    self.requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [self requestRemoteDataSignal];
    }];
    
    [[self.requestRemoteDataCommand.executionSignals
    	flatten]
    	subscribeNext:^(id x) {
            @strongify(self)
            [self.fetchLocalDataCommand execute:nil];
        }];
    
    [self.requestRemoteDataCommand.errors subscribe:self.errors];
    
    [self.fetchLocalDataCommand execute:nil];
}

- (RACSignal *)fetchLocalDataSignal {
	return RACSignal.empty;
}

- (RACSignal *)requestRemoteDataSignal {
    return RACSignal.empty;
}

@end
