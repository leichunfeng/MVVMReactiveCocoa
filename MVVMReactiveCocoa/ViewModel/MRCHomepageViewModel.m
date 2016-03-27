//
//  MRCHomepageViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCHomepageViewModel.h"

@interface MRCHomepageViewModel ()

@property (nonatomic, strong, readwrite) MRCNewsViewModel    *newsViewModel;
@property (nonatomic, strong, readwrite) MRCReposViewModel   *reposViewModel;
@property (nonatomic, strong, readwrite) MRCExploreViewModel *exploreViewModel;
@property (nonatomic, strong, readwrite) MRCProfileViewModel *profileViewModel;

@end

@implementation MRCHomepageViewModel

- (void)initialize {
    [super initialize];
    
    self.newsViewModel    = [[MRCNewsViewModel alloc] initWithServices:self.services params:nil];
    self.reposViewModel   = [[MRCReposViewModel alloc] initWithServices:self.services params:nil];
    self.exploreViewModel = [[MRCExploreViewModel alloc] initWithServices:self.services params:nil];
    self.profileViewModel = [[MRCProfileViewModel alloc] initWithServices:self.services params:nil];
}

@end
