//
//  MRCAvatarHeaderViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRCAvatarHeaderViewModel : NSObject

@property (strong, nonatomic, readonly) OCTUser *user;

// The contentOffset of the scroll view.
@property (assign, nonatomic) CGPoint contentOffset;

@property (strong, nonatomic) RACCommand *operationCommand;
@property (strong, nonatomic) RACCommand *followersCommand;
@property (strong, nonatomic) RACCommand *repositoriesCommand;
@property (strong, nonatomic) RACCommand *followingCommand;

- (instancetype)initWithUser:(OCTUser *)user;

@end
