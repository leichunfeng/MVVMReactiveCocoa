//
//  MRCRepoReadMeViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/26.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoReadMeViewModel.h"
#import "MRCRepositoryService.h"

@interface MRCRepoReadMeViewModel ()

@property (strong, nonatomic) OCTRepository *repository;

@end

@implementation MRCRepoReadMeViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.repository = params[@"repository"];
        self.readmeAttributedString = params[@"readmeAttributedString"];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.title = @"README.md";
    
    if (!self.readmeAttributedString) {
        @weakify(self)
        [[[self.services getRepositoryService]
        	requestRepositoryReadmeRenderedHTML:self.repository]
         	subscribeNext:^(NSString *htmlString) {
             	@strongify(self)
             	self.readmeAttributedString = [htmlString HTMLString2AttributedString];
         	}];
    }
}

@end
