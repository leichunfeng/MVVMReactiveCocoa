//
//  MRCTableViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCTableViewModel.h"

@interface MRCTableViewModel ()

@property (strong, nonatomic, readwrite) RACCommand *requestRemoteDataCommand;

@end

@implementation MRCTableViewModel

- (void)initialize {
    [super initialize];
    
    self.page = 1;
    self.perPage = 100;
    
    @weakify(self)
    self.requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *page) {
        @strongify(self)
        return [[self requestRemoteDataSignalWithPage:page.unsignedIntegerValue] takeUntil:self.willDisappearSignal];
    }];
    
    RAC(self, shouldDisplayEmptyDataSet) = [RACSignal
        combineLatest:@[ self.requestRemoteDataCommand.executing, RACObserve(self, dataSource) ]
        reduce:^id(NSNumber *executing, NSArray *dataSource) {
            RACSequence *sequenceOfSequences = [dataSource.rac_sequence map:^id(NSArray *array) {
                NSParameterAssert([array isKindOfClass:[NSArray class]]);
                return array.rac_sequence;
            }];
            return @(!executing.boolValue && sequenceOfSequences.flatten.array.count == 0);
        }];
    
    [self.requestRemoteDataCommand.errors subscribe:self.errors];
}

- (id)fetchLocalData {
    return nil;
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    return [RACSignal empty];
}

@end
