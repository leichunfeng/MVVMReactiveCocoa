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

@property (nonatomic, strong) OCTUser *user;

@property (nonatomic, copy, readwrite) NSArray *events;
@property (nonatomic, assign, readwrite) BOOL isCurrentUser;
@property (nonatomic, assign, readwrite) MRCNewsViewModelType type;
@property (nonatomic, strong, readwrite) RACCommand *didClickLinkCommand;

@end

@implementation MRCNewsViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(NSDictionary *)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.type = [params[@"type"] unsignedIntegerValue];
        self.user = params[@"user"] ?: [OCTUser mrc_currentUser];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.isCurrentUser = [self.user.objectID isEqualToString:[OCTUser mrc_currentUserId]];

    if (self.type == MRCNewsViewModelTypeNews) {
        self.title = @"News";
    } else if (self.type == MRCNewsViewModelTypePublicActivity) {
        self.title = @"Public Activity";
    }
    
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
    
    RAC(self, events) = [self.requestRemoteDataCommand.executionSignals.switchToLatest startWith:self.fetchLocalData];
}

- (BOOL (^)(NSError *))requestRemoteDataErrorsFilter {
    return ^BOOL(NSError *error) {
        if ([error.domain isEqual:OCTClientErrorDomain] && error.code == OCTClientErrorServiceRequestFailed) {
            MRCLogError(error);
            return NO;
        }
        return YES;
    };
}

- (id)fetchLocalData {
    NSArray *events = nil;
    
    if (self.isCurrentUser) {
        if (self.type == MRCNewsViewModelTypeNews) {
            events = [OCTEvent mrc_fetchUserReceivedEvents];
        } else if (self.type == MRCNewsViewModelTypePublicActivity) {
            events = [OCTEvent mrc_fetchUserPerformedEvents];
        }
    }

    return events;
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    RACSignal *fetchSignal = [RACSignal empty];

    if (self.type == MRCNewsViewModelTypeNews) {
        fetchSignal = [[self.services client] fetchUserReceivedEventsWithOffset:[self offsetForPage:page] perPage:self.perPage];
    } else if (self.type == MRCNewsViewModelTypePublicActivity) {
        fetchSignal = [[self.services client] fetchPerformedEventsForUser:self.user offset:[self offsetForPage:page] perPage:self.perPage];
    }
    
    return [[[[fetchSignal
        take:self.perPage]
    	collect]
    	doNext:^(NSArray *events) {
            if (self.isCurrentUser && page == 1) { // Cache the first page
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    if (self.type == MRCNewsViewModelTypeNews) {
                        [OCTEvent mrc_saveUserReceivedEvents:events];
                    } else if (self.type == MRCNewsViewModelTypePublicActivity) {
                        [OCTEvent mrc_saveUserPerformedEvents:events];
                    }
                });
            }
        }]
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
