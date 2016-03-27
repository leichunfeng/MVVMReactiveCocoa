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
#import "MRCExploreViewController.h"
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

        reposViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Repositories" image:reposImage selectedImage:reposHLImage];

        [[MRCNavigationController alloc] initWithRootViewController:reposViewController];
    });

    UINavigationController *exploreNavigationController = ({
        MRCExploreViewController *exploreViewController = [[MRCExploreViewController alloc] initWithViewModel:self.viewModel.exploreViewModel];

        UIImage *exploreImage = [UIImage octicon_imageWithIcon:@"Search"
                                               backgroundColor:[UIColor clearColor]
                                                     iconColor:[UIColor lightGrayColor]
                                                     iconScale:1
                                                      andSize:CGSizeMake(25, 25)];
        UIImage *exploreHLImage = [UIImage octicon_imageWithIcon:@"Search"
                                                 backgroundColor:[UIColor clearColor]
                                                       iconColor:HexRGB(colorI3)
                                                       iconScale:1
                                                         andSize:CGSizeMake(25, 25)];

        exploreViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Explore" image:exploreImage selectedImage:exploreHLImage];

        [[MRCNavigationController alloc] initWithRootViewController:exploreViewController];
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

        profileViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:profileImage selectedImage:profileHLImage];

        [[MRCNavigationController alloc] initWithRootViewController:profileViewController];
    });

    self.tabBarController.viewControllers = @[ newsNavigationController, reposNavigationController, exploreNavigationController, profileNavigationController ];

    [MRCSharedAppDelegate.navigationControllerStack pushNavigationController:newsNavigationController];

    [[self
        rac_signalForSelector:@selector(tabBarController:didSelectViewController:)
        fromProtocol:@protocol(UITabBarControllerDelegate)]
        subscribeNext:^(RACTuple *tuple) {
            [MRCSharedAppDelegate.navigationControllerStack popNavigationController];
            [MRCSharedAppDelegate.navigationControllerStack pushNavigationController:tuple.second];
        }];
    self.tabBarController.delegate = self;
}

@end
