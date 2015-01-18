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

@interface MRCHomepageViewController ()

@property (strong, nonatomic, readonly) MRCHomepageViewModel *viewModel;

@end

@implementation MRCHomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MRCNewsViewController *newsViewController = [[MRCNewsViewController alloc] initWithViewModel:self.viewModel.newsViewModel];
    newsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"News"
                                                                  image:[UIImage octicon_imageWithIdentifier:@"Home" size:CGSizeMake(25, 25)]
                                                                    tag:1];
    
    MRCRepositoriesViewController *repositoriesViewController = [[MRCRepositoriesViewController alloc] initWithViewModel:self.viewModel.repositoriesViewModel];
    repositoriesViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Repositories"
                                                                          image:[UIImage octicon_imageWithIdentifier:@"Repo" size:CGSizeMake(25, 25)]
                                                                            tag:2];
    
    MRCGistsViewController *gistsViewController = [[MRCGistsViewController alloc] initWithViewModel:self.viewModel.gistsViewModel];
    gistsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Gists"
                                                                   image:[UIImage octicon_imageWithIdentifier:@"Gist" size:CGSizeMake(25, 25)]
                                                                     tag:3];
    
    MRCProfileViewController *profileViewController = [[MRCProfileViewController alloc] initWithViewModel:self.viewModel.profileViewModel];
    profileViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile"
                                                                     image:[UIImage octicon_imageWithIdentifier:@"Person" size:CGSizeMake(25, 25)]
                                                                       tag:4];
    
    self.tabBar.translucent = NO;
    
    self.viewControllers = @[[[UINavigationController alloc] initWithRootViewController:newsViewController],
                             [[UINavigationController alloc] initWithRootViewController:repositoriesViewController],
                             [[UINavigationController alloc] initWithRootViewController:gistsViewController],
                             [[UINavigationController alloc] initWithRootViewController:profileViewController]];
}

- (void)bindViewModel {
    [super bindViewModel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

@end
