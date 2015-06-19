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
    
    self.currentPage = 1;
    self.pageSize = 30;
    
    @weakify(self)
    self.requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *currentPage) {
        @strongify(self)
        return [[self requestRemoteDataSignalWithCurrentPage:currentPage.unsignedIntegerValue] takeUntil:self.willDisappearSignal];
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

- (RACSignal *)requestRemoteDataSignal {
    return [RACSignal empty];
}

- (RACSignal *)requestRemoteDataSignalWithCurrentPage:(NSUInteger)currentPage {
    return [self requestRemoteDataSignal];
}

@end
