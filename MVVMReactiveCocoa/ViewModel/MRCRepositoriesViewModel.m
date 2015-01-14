//
//  MRCRepositoriesViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepositoriesViewModel.h"

@implementation MRCRepositoriesViewModel

- (void)initialize {
    [super initialize];
    
    [OCTRepository fetchUserRepositories];
    
    [[self.services.client fetchUserRepositories] subscribeNext:^(OCTRepository *repository) {
        [repository save];
    } error:^(NSError *error) {
        
    } completed:^{
        
    }];
}

@end
