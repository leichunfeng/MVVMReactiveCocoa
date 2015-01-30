//
//  MRCGitTreeViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/29.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCGitTreeViewModel.h"

@interface MRCGitTreeViewModel ()

@property (strong, nonatomic) OCTRepository *repository;
@property (strong, nonatomic) NSString *reference;

@end

@implementation MRCGitTreeViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.repository = params[@"repository"];
        self.reference  = params[@"reference"];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    [[self.services.client
     	fetchTreeForReference:self.reference inRepository:self.repository recursive:NO]
    	subscribeNext:^(OCTTree *tree) {
            self.dataSource = @[tree.entries];
        }];
}

@end
