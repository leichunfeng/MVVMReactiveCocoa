//
//  MRCReposItemViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, MRCReposItemViewModelOptions) {
    MRCReposItemViewModelOptionsShowOwnerLogin = 1 << 0,
    MRCReposItemViewModelOptionsMarkStarredStatus = 1 << 1
};

@interface MRCReposItemViewModel : NSObject

@property (strong, nonatomic, readonly) OCTRepository *repository;
@property (copy, nonatomic, readonly) NSString *identifier;
@property (assign, nonatomic, readonly) NSInteger hexRGB;
@property (copy, nonatomic) NSAttributedString *name;
@property (copy, nonatomic) NSString *updateTime;
@property (copy, nonatomic, readonly) NSString *language;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat repoDesWidth;
@property (copy, nonatomic) NSAttributedString *repoDescription;

@property (assign, nonatomic, readonly) MRCReposItemViewModelOptions options;

- (instancetype)initWithRepository:(OCTRepository *)repository options:(MRCReposItemViewModelOptions)options;

@end
