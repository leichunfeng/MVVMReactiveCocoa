//
//  MRCRepoDetailViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoDetailViewModel.h"
#import "MRCRepositoryService.h"

@interface MRCRepoDetailViewModel ()

@property (strong, nonatomic, readwrite) OCTRepository *repository;

@end

@implementation MRCRepoDetailViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.repository = self.params[@"repository"];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    if (self.repository.isStarred) {
        self.title = [NSString stringWithFormat:@"%@/%@", self.repository.ownerLogin, self.repository.name];
    } else {
        self.title = self.repository.name;
    }
}

- (RACSignal *)fetchLocalDataSignal {
    @weakify(self)
    return [[OCTRepository
    	fetchRepositoryWithName:self.repository.name owner:self.repository.ownerLogin]
    	doNext:^(OCTRepository *repository) {
            @strongify(self)
            self.repository = repository;
        }];
}

- (RACSignal *)requestRemoteDataSignal {
    RACSignal *fetchRepoSignal   = [self.services.client fetchRepositoryWithName:self.repository.name owner:self.repository.ownerLogin];
    RACSignal *fetchReadmeSignal = [[self.services getRepositoryService] requestRepositoryReadmeRenderedHTML:self.repository];
    
    @weakify(self)
    return [[RACSignal
        combineLatest:@[fetchRepoSignal, fetchReadmeSignal]]
        doNext:^(RACTuple *tuple) {
            @strongify(self)
            [self.repository mergeValuesForKeysFromModel:tuple.first];
            [self.repository save];
            self.readmeAttributedString = [tuple.second HTMLString2AttributedString];
        }];
}

@end
