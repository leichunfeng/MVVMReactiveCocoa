//
//  MRCNewsViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCNewsViewModel.h"

@implementation MRCNewsViewModel

- (void)initialize {
    [super initialize];
    
    self.title = @"News";
    
//    [[self.services.client fetchUserEventsNotMatchingEtag:nil] subscribeNext:^(id x) {
//        
//    }];
}

@end
