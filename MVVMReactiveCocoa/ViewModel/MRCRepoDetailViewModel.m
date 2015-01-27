//
//  MRCRepoDetailViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoDetailViewModel.h"

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

@end
