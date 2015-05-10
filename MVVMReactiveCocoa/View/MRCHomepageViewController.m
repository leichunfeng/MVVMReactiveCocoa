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
#import "MRCGistsViewModel.h"
#import "MRCProfileViewModel.h"
#import "MRCNavigationControllerStack.h"
#import "MRCReposViewController.h"
#import "MRCNavigationController.h"
#import "MRCSearchViewController.h"
#import "MRCGistsViewController.h"

@interface MRCHomepageViewController () <UITabBarControllerDelegate>

@property (strong, nonatomic, readonly) MRCHomepageViewModel *viewModel;

@property (strong, nonatomic) UINavigationController *newsNavigationController;
@property (strong, nonatomic) UINavigationController *reposNavigationController;
@property (strong, nonatomic) UINavigationController *gistsNavigationController;
@property (strong, nonatomic) UINavigationController *searchNavigationController;
@property (strong, nonatomic) UINavigationController *profileNavigationController;

@end

@implementation MRCHomepageViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewControllers = @[ self.reposNavigationController, self.searchNavigationController, self.profileNavigationController ];
    
    [[self rac_signalForSelector:@selector(tabBarController:didSelectViewController:) fromProtocol:@protocol(UITabBarControllerDelegate)]
    	subscribeNext:^(RACTuple *tuple) {
            if (tuple.second != MRCSharedAppDelegate.navigationControllerStack.topNavigationController) {
                [MRCSharedAppDelegate.navigationControllerStack popNavigationController];
                [MRCSharedAppDelegate.navigationControllerStack pushNavigationController:tuple.second];
            }
     	}];
    self.delegate = self;
    
//    UIImage *image = [UIImage octicon_imageWithIcon:@"GitMerge"
//                                    backgroundColor:UIColor.whiteColor
//                                          iconColor:HexRGB(colorI2)
//                                          iconScale:1
//                                            andSize:CGSizeMake(1024, 1024)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [MRCSharedAppDelegate.navigationControllerStack pushNavigationController:(UINavigationController *)self.selectedViewController];
}

- (UINavigationController *)newsNavigationController {
    if (!_newsNavigationController) {
        MRCNewsViewController *newsViewController = [[MRCNewsViewController alloc] initWithViewModel:self.viewModel.newsViewModel];
        newsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"News"
                                                                      image:[UIImage octicon_imageWithIdentifier:@"Home" size:CGSizeMake(25, 25)]
                                                                        tag:1];
        _newsNavigationController = [[MRCNavigationController alloc] initWithRootViewController:newsViewController];
    }
    return _newsNavigationController;
}

- (UINavigationController *)reposNavigationController {
    if (!_reposNavigationController) {
        MRCReposViewController *repositoriesViewController = [[MRCReposViewController alloc] initWithViewModel:self.viewModel.reposViewModel];
        repositoriesViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Repositories"
                                                                              image:[UIImage octicon_imageWithIdentifier:@"Repo" size:CGSizeMake(25, 25)]
                                                                                tag:2];
        _reposNavigationController = [[MRCNavigationController alloc] initWithRootViewController:repositoriesViewController];
    }
    return _reposNavigationController;
}

- (UINavigationController *)gistsNavigationController {
    if (!_gistsNavigationController) {
        MRCGistsViewController *gistsViewController = [[MRCGistsViewController alloc] initWithViewModel:self.viewModel.gistsViewModel];
        gistsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Gists"
                                                                       image:[UIImage octicon_imageWithIdentifier:@"Gist" size:CGSizeMake(25, 25)]
                                                                         tag:3];
        _gistsNavigationController = [[MRCNavigationController alloc] initWithRootViewController:gistsViewController];
    }
    return _gistsNavigationController;
}

- (UINavigationController *)searchNavigationController {
    if (!_searchNavigationController) {
        MRCSearchViewController *searchViewController = [[MRCSearchViewController alloc] initWithViewModel:self.viewModel.searchViewModel];
        searchViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Search"
                                                                       image:[UIImage octicon_imageWithIdentifier:@"Search" size:CGSizeMake(25, 25)]
                                                                         tag:4];
        _searchNavigationController = [[MRCNavigationController alloc] initWithRootViewController:searchViewController];
    }
    return _searchNavigationController;
}

- (UINavigationController *)profileNavigationController {
    if (!_profileNavigationController) {
        MRCProfileViewController *profileViewController = [[MRCProfileViewController alloc] initWithViewModel:self.viewModel.profileViewModel];
        profileViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile"
                                                                         image:[UIImage octicon_imageWithIdentifier:@"Person" size:CGSizeMake(25, 25)]
                                                                           tag:5];
        _profileNavigationController = [[MRCNavigationController alloc] initWithRootViewController:profileViewController];
    }
    return _profileNavigationController;
}

@end
