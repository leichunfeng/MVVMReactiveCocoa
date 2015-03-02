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
@property (strong, nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) NSInteger hexRGB;
@property (strong, nonatomic, readonly) NSAttributedString *name;
@property (strong, nonatomic, readonly) NSString *language;

- (instancetype)initWithRepository:(OCTRepository *)repository;

@end
