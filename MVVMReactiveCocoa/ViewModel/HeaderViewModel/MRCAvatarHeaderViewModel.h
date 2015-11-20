//
//  MRCAvatarHeaderViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRCAvatarHeaderViewModel : NSObject

@property (nonatomic, strong, readonly) OCTUser *user;

/// The contentOffset of the scroll view.
@property (nonatomic, assign) CGPoint contentOffset;

@property (nonatomic, strong) RACCommand *operationCommand;
@property (nonatomic, strong) RACCommand *followersCommand;
@property (nonatomic, strong) RACCommand *repositoriesCommand;
@property (nonatomic, strong) RACCommand *followingCommand;

- (instancetype)initWithUser:(OCTUser *)user;

@end
