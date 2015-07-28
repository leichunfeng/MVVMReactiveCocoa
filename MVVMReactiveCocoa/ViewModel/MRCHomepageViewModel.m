//
//  MRCHomepageViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCHomepageViewModel.h"

@interface MRCHomepageViewModel ()

@property (strong, nonatomic, readwrite) MRCNewsViewModel    *newsViewModel;
@property (strong, nonatomic, readwrite) MRCReposViewModel   *reposViewModel;
@property (strong, nonatomic, readwrite) MRCSearchViewModel  *searchViewModel;
@property (strong, nonatomic, readwrite) MRCProfileViewModel *profileViewModel;

@end

@implementation MRCHomepageViewModel

- (void)initialize {
    [super initialize];
    
    self.newsViewModel    = [[MRCNewsViewModel alloc] initWithServices:self.services params:nil];
    self.reposViewModel   = [[MRCReposViewModel alloc] initWithServices:self.services params:nil];
    self.searchViewModel  = [[MRCSearchViewModel alloc] initWithServices:self.services params:nil];
    self.profileViewModel = [[MRCProfileViewModel alloc] initWithServices:self.services params:nil];
}

@end
