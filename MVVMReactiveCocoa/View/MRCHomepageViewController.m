//
//  MRCHomepageViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/9.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCHomepageViewController.h"
#import "MRCHomepageViewModel.h"
#import "MRCNewsViewController.h"
#import "MRCProfileViewController.h"
#import "MRCNewsViewModel.h"
#import "MRCReposViewModel.h"
#import "MRCProfileViewModel.h"
#import "MRCReposViewController.h"
#import "MRCNavigationController.h"
#import "MRCSearchViewController.h"
#import "MRCUserListViewModel.h"
#import "MRCTrendingViewController.h"

@interface MRCHomepageViewController () <UITabBarControllerDelegate>

@property (nonatomic, strong) MRCHomepageViewModel *viewModel;

@end

@implementation MRCHomepageViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;

    UINavigationController *newsNavigationController = ({
        MRCNewsViewController *newsViewController = [[MRCNewsViewController alloc] initWithViewModel:self.viewModel.newsViewModel];

        UIImage *newsImage = [UIImage octicon_imageWithIdentifier:@"Rss" size:CGSizeMake(25, 25)];
        newsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"News" image:newsImage tag:1];

        [[MRCNavigationController alloc] initWithRootViewController:newsViewController];
    });

    UINavigationController *reposNavigationController = ({
        MRCReposViewController *reposViewController = [[MRCReposViewController alloc] initWithViewModel:self.viewModel.reposViewModel];

        UIImage *reposImage = [UIImage octicon_imageWithIdentifier:@"Repo" size:CGSizeMake(25, 25)];
        reposViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Repositories" image:reposImage tag:2];

        [[MRCNavigationController alloc] initWithRootViewController:reposViewController];
    });

    UINavigationController *trendingNavigationController = ({
        MRCTrendingViewController *trendingViewController = [[MRCTrendingViewController alloc] initWithViewModel:self.viewModel.trendingViewModel];

        UIImage *trendingImage = [UIImage octicon_imageWithIdentifier:@"Telescope" size:CGSizeMake(25, 25)];
        trendingViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Trending" image:trendingImage tag:3];

        [[MRCNavigationController alloc] initWithRootViewController:trendingViewController];
    });

    UINavigationController *profileNavigationController = ({
        MRCProfileViewController *profileViewController = [[MRCProfileViewController alloc] initWithViewModel:self.viewModel.profileViewModel];

        UIImage *profileImage = [UIImage octicon_imageWithIdentifier:@"Person" size:CGSizeMake(25, 25)];
        profileViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:profileImage tag:4];

        [[MRCNavigationController alloc] initWithRootViewController:profileViewController];
    });

    self.viewControllers = @[ newsNavigationController, reposNavigationController, trendingNavigationController, profileNavigationController ];

    [MRCSharedAppDelegate.navigationControllerStack pushNavigationController:newsNavigationController];

    [[self
        rac_signalForSelector:@selector(tabBarController:didSelectViewController:)
        fromProtocol:@protocol(UITabBarControllerDelegate)]
        subscribeNext:^(RACTuple *tuple) {
            [MRCSharedAppDelegate.navigationControllerStack popNavigationController];
            [MRCSharedAppDelegate.navigationControllerStack pushNavigationController:tuple.second];
        }];
    self.delegate = self;
}

@end
