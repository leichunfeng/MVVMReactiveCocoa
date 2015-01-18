//
//  MRCStarredRepositoriesItemViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/17.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRCStarredRepositoriesItemViewModel : NSObject

@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSString *repoDescription;
@property (strong, nonatomic, readonly) NSString *language;

// The number of stargazers for this repository.
@property (assign, nonatomic, readonly) NSUInteger stargazersCount;

// The number of forks for this repository.
@property (assign, nonatomic, readonly) NSUInteger forksCount;

- (instancetype)initWithRepository:(OCTRepository *)repository;

@end
