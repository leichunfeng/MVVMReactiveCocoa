//
//  MRCStarredRepositoriesItemViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/17.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCStarredRepositoriesItemViewModel.h"

@interface MRCStarredRepositoriesItemViewModel ()

@property (strong, nonatomic, readwrite) NSString *name;
@property (strong, nonatomic, readwrite) NSString *repoDescription;
@property (strong, nonatomic, readwrite) NSString *language;
@property (assign, nonatomic, readwrite) NSUInteger stargazersCount;
@property (assign, nonatomic, readwrite) NSUInteger forksCount;

@end

@implementation MRCStarredRepositoriesItemViewModel

- (instancetype)initWithRepository:(OCTRepository *)repository {
    self = [super init];
    if (self) {
        self.name            = [NSString stringWithFormat:@"%@/%@", repository.ownerLogin, repository.name];
        self.repoDescription = repository.repoDescription;
        self.language        = repository.language ?: @" ";
        self.stargazersCount = repository.stargazersCount;
        self.forksCount      = repository.forksCount;
    }
    return self;
}

@end
