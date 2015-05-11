//
//  MRCReposItemViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRCReposItemViewModel : NSObject

@property (strong, nonatomic, readonly) OCTRepository *repository;
@property (copy, nonatomic, readonly) NSString *identifier;
@property (assign, nonatomic, readonly) NSInteger hexRGB;
@property (strong, nonatomic) NSAttributedString *name;
@property (copy, nonatomic, readonly) NSString *updateTime;
@property (copy, nonatomic, readonly) NSString *language;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat repoDescriptionWidth;

- (instancetype)initWithRepository:(OCTRepository *)repository;

@end
