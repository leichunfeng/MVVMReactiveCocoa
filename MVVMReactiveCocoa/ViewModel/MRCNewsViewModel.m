//
//  MRCNewsViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCNewsViewModel.h"
#import "MRCNewsItemViewModel.h"
#import "MRCUserDetailViewModel.h"
#import "MRCRepoDetailViewModel.h"
#import "MRCWebViewModel.h"

@interface MRCNewsViewModel ()

@property (strong, nonatomic) OCTUser *user;
@property (copy, nonatomic) NSArray *events;
@property (strong, nonatomic, readwrite) RACCommand *didClickLinkCommand;

@end

@implementation MRCNewsViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.user = params[@"user"] ?: [OCTUser mrc_currentUser];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.title = @"News";
    
    self.shouldPullToRefresh = YES;
    self.shouldInfiniteScrolling = YES;
    
    @weakify(self)
    self.didClickLinkCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSURL *URL) {
        @strongify(self)
        
        NSString *title = [[[[URL.absoluteString componentsSeparatedByString:@"?"].lastObject componentsSeparatedByString:@"="].lastObject stringByReplacingOccurrencesOfString:@"-" withString:@" "] stringByReplacingOccurrencesOfString:@"@" withString:@"#"];
        NSLog(@"didClickLinkCommand: %@, title: %@", URL, title);
        
        if (URL.type == MRCLinkTypeUser) {
            MRCUserDetailViewModel *viewModel = [[MRCUserDetailViewModel alloc] initWithServices:self.services params:URL.mrc_dictionary];
            [self.services pushViewModel:viewModel animated:YES];
        } else if (URL.type == MRCLinkTypeRepository) {
            MRCRepoDetailViewModel *viewModel = [[MRCRepoDetailViewModel alloc] initWithServices:self.services params:URL.mrc_dictionary];
            [self.services pushViewModel:viewModel animated:YES];
        } else {
            NSURLRequest *request = [NSURLRequest requestWithURL:URL];
            
            MRCWebViewModel *viewModel = [[MRCWebViewModel alloc] initWithServices:self.services
                                                                            params:@{ @"title": title ?: @"",
                                                                                      @"request": request ?: @"" }];
            [self.services pushViewModel:viewModel animated:YES];
        }
        
        return [RACSignal empty];
    }];
    
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self)
        MRCNewsItemViewModel *viewModel = self.dataSource[indexPath.section][indexPath.row];
        return [self.didClickLinkCommand execute:viewModel.event.mrc_Link];
    }];
    
    RAC(self, events) = self.requestRemoteDataCommand.executionSignals.switchToLatest;
    
    RAC(self, dataSource) = [RACObserve(self, events) map:^(NSArray *events) {
        @strongify(self)
        return [self dataSourceWithEvents:events];
    }];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    return [[[[self.services
    	client]
        fetchEventsForUser:self.user page:page perPage:self.perPage]
    	collect]
    	map:^(NSArray *events) {
            if (page != 1) {
                events = @[ (self.events ?: @[]).rac_sequence, events.rac_sequence ].rac_sequence.flatten.array;
            }
            return events;
        }];
}

- (NSArray *)dataSourceWithEvents:(NSArray *)events {
    if (events.count == 0) return nil;
    
    @weakify(self)
    NSArray *viewModels = [events.rac_sequence map:^(OCTEvent *event) {
        @strongify(self)
        MRCNewsItemViewModel *viewModel = [[MRCNewsItemViewModel alloc] initWithEvent:event];
        viewModel.didClickLinkCommand = self.didClickLinkCommand;
        return viewModel;
    }].array;
    
    return @[ viewModels ];
}

@end
