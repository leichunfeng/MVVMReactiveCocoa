//
//  MRCRepoDetailViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoDetailViewModel.h"

@interface MRCRepoDetailViewModel ()

@property (strong, nonatomic) OCTRepository *repository;

@end

@implementation MRCRepoDetailViewModel

- (void)initialize {
    [super initialize];
    
    self.repository = self.params[@"repository"];
    
    if (self.repository.isStarred) {
        self.title = [NSString stringWithFormat:@"%@/%@", self.repository.ownerLogin, self.repository.name];
    } else {
        self.title = self.repository.name;
    }
}

@end
