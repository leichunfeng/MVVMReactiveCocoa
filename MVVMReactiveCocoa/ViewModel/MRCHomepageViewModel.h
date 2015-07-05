//
//  MRCHomepageViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCTabBarViewModel.h"
#import "MRCNewsViewModel.h"
#import "MRCReposViewModel.h"
#import "MRCSearchViewModel.h"
#import "MRCProfileViewModel.h"

@interface MRCHomepageViewModel : MRCTabBarViewModel

// The view model of `News` interface.
@property (strong, nonatomic) MRCNewsViewModel *newsViewModel;

// The view model of `Repositories` interface.
@property (strong, nonatomic) MRCReposViewModel *reposViewModel;

// The view model of `Search` interface.
@property (strong, nonatomic) MRCSearchViewModel *searchViewModel;

// The view model of `Profile` interface.
@property (strong, nonatomic) MRCProfileViewModel *profileViewModel;

@end
