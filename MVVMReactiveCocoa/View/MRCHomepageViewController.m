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
#import "MRCSearchViewController.h"

@interface MRCHomepageViewController ()

@property (nonatomic, strong) MRCHomepageViewModel *viewModel;

@end

@implementation MRCHomepageViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];

    UINavigationController *newsNavigationController = ({
        MRCNewsViewController *newsViewController = [[MRCNewsViewController alloc] initWithViewModel:self.viewModel.newsViewModel];

        UIImage *newsImage = [UIImage octicon_imageWithIcon:@"Rss"
                                            backgroundColor:[UIColor clearColor]
                                                  iconColor:[UIColor lightGrayColor]
                                                  iconScale:1
                                                    andSize:CGSizeMake(25, 25)];
        UIImage *newsHLImage = [UIImage octicon_imageWithIcon:@"Rss"
                                              backgroundColor:[UIColor clearColor]
                                                    iconColor:HexRGB(colorI3)
                                                    iconScale:1
                                                      andSize:CGSizeMake(25, 25)];
        
        newsImage   = [newsImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        newsHLImage = [newsHLImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        newsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"News" image:newsImage selectedImage:newsHLImage];

        [[MRCNavigationController alloc] initWithRootViewController:newsViewController];
    });

    UINavigationController *reposNavigationController = ({
        MRCReposViewController *reposViewController = [[MRCReposViewController alloc] initWithViewModel:self.viewModel.reposViewModel];
        
        UIImage *reposImage = [UIImage octicon_imageWithIcon:@"Repo"
                                             backgroundColor:[UIColor clearColor]
                                                   iconColor:[UIColor lightGrayColor]
                                                   iconScale:1
                                                     andSize:CGSizeMake(25, 25)];
        UIImage *reposHLImage = [UIImage octicon_imageWithIcon:@"Repo"
                                               backgroundColor:[UIColor clearColor]
                                                     iconColor:HexRGB(colorI3)
                                                     iconScale:1
                                                       andSize:CGSizeMake(25, 25)];
        
        reposImage   = [reposImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        reposHLImage = [reposHLImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        reposViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Repositories" image:reposImage selectedImage:reposHLImage];

        [[MRCNavigationController alloc] initWithRootViewController:reposViewController];
    });

    UINavigationController *searchNavigationController = ({
        MRCSearchViewController *searchViewController = [[MRCSearchViewController alloc] initWithViewModel:self.viewModel.searchViewModel];

        UIImage *searchImage = [UIImage octicon_imageWithIcon:@"Search"
                                              backgroundColor:[UIColor clearColor]
                                                    iconColor:[UIColor lightGrayColor]
                                                    iconScale:1
                                                      andSize:CGSizeMake(25, 25)];
        UIImage *searchHLImage = [UIImage octicon_imageWithIcon:@"Search"
                                                backgroundColor:[UIColor clearColor]
                                                      iconColor:HexRGB(colorI3)
                                                      iconScale:1
                                                        andSize:CGSizeMake(25, 25)];
        
        searchImage   = [searchImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        searchHLImage = [searchHLImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        searchViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Discover" image:searchImage selectedImage:searchHLImage];

        [[MRCNavigationController alloc] initWithRootViewController:searchViewController];
    });

    UINavigationController *profileNavigationController = ({
        MRCProfileViewController *profileViewController = [[MRCProfileViewController alloc] initWithViewModel:self.viewModel.profileViewModel];

        UIImage *profileImage = [UIImage octicon_imageWithIcon:@"Person"
                                               backgroundColor:[UIColor clearColor]
                                                     iconColor:[UIColor lightGrayColor]
                                                     iconScale:1
                                                       andSize:CGSizeMake(25, 25)];
        UIImage *profileHLImage = [UIImage octicon_imageWithIcon:@"Person"
                                                 backgroundColor:[UIColor clearColor]
                                                       iconColor:HexRGB(colorI3)
                                                       iconScale:1
                                                         andSize:CGSizeMake(25, 25)];
        
        profileImage   = [profileImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        profileHLImage = [profileHLImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        profileViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:profileImage selectedImage:profileHLImage];

        [[MRCNavigationController alloc] initWithRootViewController:profileViewController];
    });

    self.tabBarController.viewControllers = @[ newsNavigationController, reposNavigationController, searchNavigationController, profileNavigationController ];
}

@end
