//
//  MRCRepoDetailViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoDetailViewModel.h"
#import "MRCRepositoryService.h"
#import "MRCSelectBranchViewModel.h"
#import "MRCRepoReadmeViewModel.h"
#import "MRCGitTreeViewModel.h"

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
    
    self.title = (self.repository.isStarred ? [NSString stringWithFormat:@"%@/%@", self.repository.ownerLogin, self.repository.name] : self.repository.name);

    NSError *error = nil;
    self.reference = [[OCTRef alloc] initWithDictionary:@{@"name": [NSString stringWithFormat:@"refs/heads/%@", self.repository.defaultBranch]}
                                                  error:&error];
    if (error) NSLog(@"Error: %@", error);
    
    @weakify(self)
    self.viewCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSString *reference = [self.reference.name componentsSeparatedByString:@"/"].lastObject;
        MRCGitTreeViewModel *gitTreeViewModel = [[MRCGitTreeViewModel alloc] initWithServices:self.services
                                                                                       params:@{@"title": self.repository.name,
                                                                                                @"repository": self.repository,
                                                                                                @"reference": reference}];
        [self.services pushViewModel:gitTreeViewModel animated:YES];
        return [RACSignal empty];
    }];
    
    self.readmeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        NSMutableDictionary *params = [NSMutableDictionary new];
        
        [params setValue:self.repository forKey:@"repository"];
        [params setValue:self.reference forKey:@"reference"];
        if (self.readmeAttributedString) [params setValue:self.readmeAttributedString forKey:@"readmeAttributedString"];
        
        MRCRepoReadmeViewModel *readmeViewModel = [[MRCRepoReadmeViewModel alloc] initWithServices:self.services params:[params copy]];
        [self.services pushViewModel:readmeViewModel animated:YES];
        
        return [RACSignal empty];
    }];
    
    self.selectBranchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        MRCSelectBranchViewModel *selectBranchViewModel = [[MRCSelectBranchViewModel alloc] initWithServices:self.services
                                                                                                      params:@{@"repository": self.repository}];
        
        selectBranchViewModel.callback = ^(OCTRef *reference) {
            @strongify(self)
            self.reference = reference;
            [self.requestRemoteDataCommand execute:nil];
        };
        [self.services presentViewModel:selectBranchViewModel animated:YES completion:NULL];
        
        return [RACSignal empty];
    }];
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
    RACSignal *fetchRepoSignal = [self.services.client fetchRepositoryWithName:self.repository.name
                                                                           owner:self.repository.ownerLogin];
    RACSignal *fetchReadmeSignal = [[self.services getRepositoryService] requestRepositoryReadmeRenderedHTML:self.repository
                                                                                                   reference:self.reference.name];
    
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
