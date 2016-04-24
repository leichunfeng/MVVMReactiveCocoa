//
//  MRCShowcaseReposViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/4/24.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCShowcaseReposViewModel.h"
#import "MRCViewModelServices.h"

@interface MRCShowcaseReposViewModel ()

@property (nonatomic, copy) NSDictionary *showcase;
@property (nonatomic, strong, readwrite) MRCShowcaseHeaderViewModel *headerViewModel;

@end

@implementation MRCShowcaseReposViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(NSDictionary *)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.showcase = params[@"showcase"];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.title = @"Showcase";
    
    self.headerViewModel = [[MRCShowcaseHeaderViewModel alloc] init];
    
    self.headerViewModel.imageURL = self.showcase[@"image_url"];
    self.headerViewModel.name = self.showcase[@"name"];
    self.headerViewModel.desc = self.showcase[@"description"];
}

- (MRCReposViewModelType)type {
    return MRCReposViewModelTypeShowcase;
}

- (MRCReposViewModelOptions)options {
    MRCReposViewModelOptions options = 0;
    
//    options = options | MRCReposViewModelOptionsObserveStarredReposChange;
//    options = options | MRCReposViewModelOptionsSaveOrUpdateRepos;
//    options = options | MRCReposViewModelOptionsSaveOrUpdateStarredStatus;
//    options = options | MRCReposViewModelOptionsPagination;
//    options = options | MRCReposViewModelOptionsSectionIndex;
    options = options | MRCReposViewModelOptionsShowOwnerLogin;
    options = options | MRCReposViewModelOptionsMarkStarredStatus;
    
    return options;
}

- (id)fetchLocalData {
    return nil;
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    return [[self.services repositoryService] requestShowcaseRepositoriesWithSlug:self.showcase[@"slug"]];
}

@end
