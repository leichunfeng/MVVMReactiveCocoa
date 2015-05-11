//
//  MRCReposViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCReposViewModel.h"
#import "MRCOwnedReposViewModel.h"
#import "MRCStarredReposViewModel.h"

@implementation MRCReposViewModel

- (void)initialize {
    [super initialize];
    
    self.title = @"Repositories";
    
    MRCOwnedReposViewModel *ownedReposViewModel = [[MRCOwnedReposViewModel alloc] initWithServices:self.services params:nil];
    MRCStarredReposViewModel *starredReposViewModel = [[MRCStarredReposViewModel alloc] initWithServices:self.services params:nil];
    
    self.viewModels = @[ ownedReposViewModel, starredReposViewModel ];
}

@end
