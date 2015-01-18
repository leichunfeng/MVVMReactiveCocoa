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
#import "MRCRepositoriesViewController.h"
#import "MRCGistsViewController.h"
#import "MRCProfileViewController.h"
#import "MRCNewsViewModel.h"
#import "MRCRepositoriesViewModel.h"
#import "MRCGistsViewModel.h"
#import "MRCProfileViewModel.h"
#import "MRCNavigationControllerStack.h"

@interface MRCHomepageViewController () <UITabBarControllerDelegate>

@property (strong, nonatomic, readonly) MRCHomepageViewModel *viewModel;

@property (strong, nonatomic) UINavigationController *newsNavigationController;
@property (strong, nonatomic) UINavigationController *reposNavigationController;
@property (strong, nonatomic) UINavigationController *gistsNavigationController;
@property (strong, nonatomic) UINavigationController *profileNavigationController;

@end

@implementation MRCHomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.translucent = NO;
    self.viewControllers = @[ self.newsNavigationController, self.reposNavigationController, self.gistsNavigationController, self.profileNavigationController ];
    
    [MRCSharedAppDelegate.navigationControllerStack pushNavigationController:self.newsNavigationController];

    [[self rac_signalForSelector:@selector(tabBarController:didSelectViewController:) fromProtocol:@protocol(UITabBarControllerDelegate)]
    	subscribeNext:^(RACTuple *tuple) {
            if (tuple.second != MRCSharedAppDelegate.navigationControllerStack.topNavigationController) {
                [MRCSharedAppDelegate.navigationControllerStack popNavigationController];
                [MRCSharedAppDelegate.navigationControllerStack pushNavigationController:tuple.second];
            }
     	}];
    self.delegate = self;
}

- (UINavigationController *)newsNavigationController {
    if (!_newsNavigationController) {
        MRCNewsViewController *newsViewController = [[MRCNewsViewController alloc] initWithViewModel:self.viewModel.newsViewModel];
        newsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"News"
                                                                      image:[UIImage octicon_imageWithIdentifier:@"Home" size:CGSizeMake(25, 25)]
                                                                        tag:1];
        _newsNavigationController = [[UINavigationController alloc] initWithRootViewController:newsViewController];
    }
    return _newsNavigationController;
}

- (UINavigationController *)reposNavigationController {
    if (!_reposNavigationController) {
        MRCRepositoriesViewController *repositoriesViewController = [[MRCRepositoriesViewController alloc] initWithViewModel:self.viewModel.repositoriesViewModel];
        repositoriesViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Repositories"
                                                                              image:[UIImage octicon_imageWithIdentifier:@"Repo" size:CGSizeMake(25, 25)]
                                                                                tag:2];
        _reposNavigationController = [[UINavigationController alloc] initWithRootViewController:repositoriesViewController];
    }
    return _reposNavigationController;
}

- (UINavigationController *)gistsNavigationController {
    if (!_gistsNavigationController) {
        MRCGistsViewController *gistsViewController = [[MRCGistsViewController alloc] initWithViewModel:self.viewModel.gistsViewModel];
        gistsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Gists"
                                                                       image:[UIImage octicon_imageWithIdentifier:@"Gist" size:CGSizeMake(25, 25)]
                                                                         tag:3];
        _gistsNavigationController = [[UINavigationController alloc] initWithRootViewController:gistsViewController];
    }
    return _gistsNavigationController;
}

- (UINavigationController *)profileNavigationController {
    if (!_profileNavigationController) {
        MRCProfileViewController *profileViewController = [[MRCProfileViewController alloc] initWithViewModel:self.viewModel.profileViewModel];
        profileViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile"
                                                                         image:[UIImage octicon_imageWithIdentifier:@"Person" size:CGSizeMake(25, 25)]
                                                                           tag:4];
        _profileNavigationController = [[UINavigationController alloc] initWithRootViewController:profileViewController];
    }
    return _profileNavigationController;
}

@end
