//
//  MRCHomepageViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCHomepageViewModel.h"
#import "MRCNewsViewModel.h"
#import "MRCReposViewModel.h"
#import "MRCGistsViewModel.h"
#import "MRCProfileViewModel.h"

@implementation MRCHomepageViewModel

- (void)initialize {
    [super initialize];
    
    self.newsViewModel    = [[MRCNewsViewModel alloc] initWithServices:self.services params:nil];
    self.reposViewModel   = [[MRCReposViewModel alloc] initWithServices:self.services params:nil];
    self.gistsViewModel   = [[MRCGistsViewModel alloc] initWithServices:self.services params:nil];
    self.profileViewModel = [[MRCProfileViewModel alloc] initWithServices:self.services params:nil];
}

@end
