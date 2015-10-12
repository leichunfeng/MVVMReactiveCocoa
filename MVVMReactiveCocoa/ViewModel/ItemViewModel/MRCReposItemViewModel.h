//
//  MRCReposItemViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRCOwnedReposViewModel.h"

@interface MRCReposItemViewModel : NSObject

@property (nonatomic, strong, readonly) OCTRepository *repository;

@property (nonatomic, copy, readonly) NSAttributedString *name;
@property (nonatomic, copy, readonly) NSAttributedString *repoDescription;
@property (nonatomic, copy, readonly) NSString *updateTime;
@property (nonatomic, copy, readonly) NSString *language;

@property (nonatomic, assign, readonly) CGFloat height;
@property (nonatomic, assign, readonly) MRCReposViewModelOptions options;

- (instancetype)initWithRepository:(OCTRepository *)repository options:(MRCReposViewModelOptions)options;

@end
