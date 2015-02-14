//
//  MRCRepoDetailViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoDetailViewModel.h"
#import "MRCRepositoryService.h"
#import "MRCSelectBranchOrTagViewModel.h"
#import "MRCGitTreeViewModel.h"
#import "MRCSourceEditorViewModel.h"

@interface MRCRepoDetailViewModel ()

@property (strong, nonatomic, readwrite) OCTRepository *repository;
@property (strong, nonatomic) NSString *renderedMarkdown;

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
    
    self.shouldPullToRefresh = YES;
    
    self.title = [NSString stringWithFormat:@"%@/%@", self.repository.ownerLogin, self.repository.name];

    NSError *error = nil;
    self.reference = [[OCTRef alloc] initWithDictionary:@{@"name": [NSString stringWithFormat:@"refs/heads/%@", self.repository.defaultBranch]}
                                                  error:&error];
    if (error) NSLog(@"Error: %@", error);
    
    @weakify(self)
    self.viewCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        MRCGitTreeViewModel *gitTreeViewModel = [[MRCGitTreeViewModel alloc] initWithServices:self.services
                                                                                       params:@{@"title": self.title,
                                                                                                @"repository": self.repository,
                                                                                                @"reference": self.reference}];
        [self.services pushViewModel:gitTreeViewModel animated:YES];
        return [RACSignal empty];
    }];
    
    self.readmeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        NSMutableDictionary *params = [NSMutableDictionary new];
        
        [params setValue:@"README.md" forKey:@"title"];
        [params setValue:self.repository forKey:@"repository"];
        [params setValue:self.reference forKey:@"reference"];
        [params setValue:@(MRCSourceEditorViewModelTypeReadme) forKey:@"type"];
        
        if (self.renderedMarkdown) [params setValue:self.renderedMarkdown forKey:@"renderedMarkdown"];
        
        MRCSourceEditorViewModel *sourceEditorViewModel = [[MRCSourceEditorViewModel alloc] initWithServices:self.services params:params.copy];
        [self.services pushViewModel:sourceEditorViewModel animated:YES];
        
        return [RACSignal empty];
    }];
    
    self.selectBranchOrTagCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        if (self.references) {
            [self presentSelectBranchOrTagViewModel];
            return RACSignal.empty;
        } else {
            return [[[self.services.client
            	fetchAllReferencesInRepository:self.repository]
             	collect]
                doNext:^(NSArray *references) {
                    @strongify(self)
                    self.references = references;
                    [self presentSelectBranchOrTagViewModel];
                }];
        }
    }];
    
    [self.selectBranchOrTagCommand.errors subscribe:self.errors];
}

- (void)presentSelectBranchOrTagViewModel {
    NSDictionary *params = @{@"references": self.references, @"selectedReference": self.reference };
    MRCSelectBranchOrTagViewModel *branchViewModel = [[MRCSelectBranchOrTagViewModel alloc] initWithServices:self.services params:params];
    
    @weakify(self)
    branchViewModel.callback = ^(OCTRef *reference) {
        @strongify(self)
        self.reference = reference;
        [self.requestRemoteDataCommand execute:nil];
    };
    
    [self.services presentViewModel:branchViewModel animated:YES completion:NULL];
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
    RACSignal *fetchReadmeSignal = [self.services.repositoryService requestRepositoryReadmeRenderedMarkdown:self.repository
                                                                                                  reference:self.reference.name];
    @weakify(self)
    return [[[[RACSignal
        combineLatest:@[fetchRepoSignal, fetchReadmeSignal]]
        deliverOn:RACScheduler.mainThreadScheduler]
        doNext:^(RACTuple *tuple) {
            @strongify(self)
            [self.repository mergeValuesForKeysFromModel:tuple.first];
            [self.repository save];
            
            self.renderedMarkdown = tuple.second;
            self.readmeAttributedString = [tuple.second renderedMarkdown2AttributedString];
        }]
    	takeUntil:self.willDisappearSignal];
}

@end
