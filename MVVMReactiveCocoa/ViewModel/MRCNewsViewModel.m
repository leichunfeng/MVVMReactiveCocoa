//
//  MRCNewsViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCNewsViewModel.h"
#import "MRCNewsItemViewModel.h"

@interface MRCNewsViewModel ()

@property (copy, nonatomic) NSArray *events;

@end

@implementation MRCNewsViewModel

- (void)initialize {
    [super initialize];
    
    self.title = @"News";
    
    self.shouldPullToRefresh = YES;
    
    RAC(self, events) = self.requestRemoteDataCommand.executionSignals.switchToLatest;
    
    @weakify(self)
    RAC(self, dataSource) = [RACObserve(self, events) map:^(NSArray *events) {
        @strongify(self)
        return [self dataSourceWithEvents:events];
    }];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    return [[[self.services
    	client]
        fetchUserEventsNotMatchingEtag:nil]
    	collect];
}

- (NSArray *)dataSourceWithEvents:(NSArray *)events {
    if (events.count == 0) return nil;
    
    NSArray *viewModels = [events.rac_sequence map:^(OCTResponse *response) {
        return [[MRCNewsItemViewModel alloc] initWithEvent:response.parsedResult];
    }].array;
    
    return @[ viewModels ];
}

@end
