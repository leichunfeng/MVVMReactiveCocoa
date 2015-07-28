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

@property (strong, nonatomic, readonly) OCTRepository *repository;

@property (copy, nonatomic, readonly) NSAttributedString *name;
@property (copy, nonatomic, readonly) NSAttributedString *repoDescription;
@property (copy, nonatomic, readonly) NSString *updateTime;
@property (copy, nonatomic, readonly) NSString *language;

@property (assign, nonatomic, readonly) CGFloat height;
@property (assign, nonatomic, readonly) MRCReposViewModelOptions options;

- (instancetype)initWithRepository:(OCTRepository *)repository options:(MRCReposViewModelOptions)options;

@end
