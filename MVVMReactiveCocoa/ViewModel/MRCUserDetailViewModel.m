//
//  MRCUserDetailViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/16.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCUserDetailViewModel.h"

@implementation MRCUserDetailViewModel

- (void)initialize {
    [super initialize];
    self.title = self.user.login;
}

@end
