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
    
    RAC(self, shouldDisplayEmptyDataSet) = [RACSignal combineLatest:@[ self.requestRemoteDataCommand.executing, RACObserve(self, dataSource) ] reduce:^id(NSNumber *executing, NSArray *dataSource) {
        RACSequence *sequenceOfSequences = [dataSource.rac_sequence map:^id(NSArray *array) {
            NSParameterAssert([array isKindOfClass:[NSArray class]]);
            return array.rac_sequence;
        }];
        
        return @(!executing.boolValue && sequenceOfSequences.flatten.array.count == 0);
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
