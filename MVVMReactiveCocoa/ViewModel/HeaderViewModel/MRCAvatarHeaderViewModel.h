//
//  MRCAvatarHeaderViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRCAvatarHeaderViewModel : NSObject

// The contentOffset of the scroll view.
@property (nonatomic) CGPoint contentOffset;

// The avatar URL of the current `user`.
@property (strong, nonatomic) NSURL *avatarURL;

// The name of the current `user`.
@property (strong, nonatomic) NSString *name;

// The number of followers.
@property (strong, nonatomic) NSString *followers;

// The number of public repositories owned by this account.
@property (strong, nonatomic) NSString *repositories;

// The number of following.
@property (strong, nonatomic) NSString *following;

@end
