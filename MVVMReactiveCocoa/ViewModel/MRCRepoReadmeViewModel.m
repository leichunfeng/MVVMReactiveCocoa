//
//  MRCRepoReadmeViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/26.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoReadmeViewModel.h"
#import "MRCRepositoryService.h"

@interface MRCRepoReadmeViewModel ()

@property (strong, nonatomic) OCTRepository *repository;
@property (strong, nonatomic) OCTRef *reference;

@end

@implementation MRCRepoReadmeViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.repository = params[@"repository"];
        self.reference  = params[@"reference"];
        self.readmeAttributedString = params[@"readmeAttributedString"];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.title = @"README.md";
    
    if (!self.readmeAttributedString) {
        @weakify(self)
        [[self.services.repositoryService
        	requestRepositoryReadmeRenderedMarkdown:self.repository reference:self.reference.name]
         	subscribeNext:^(NSString *renderedMarkdown) {
             	@strongify(self)
             	self.readmeAttributedString = [renderedMarkdown renderedMarkdown2AttributedString];
         	}];
    }
}

@end
