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
#import "MRCGistsViewController.h"
#import "MRCProfileViewController.h"
#import "MRCNewsViewModel.h"
#import "MRCReposViewModel.h"
#import "MRCGistsViewModel.h"
#import "MRCProfileViewModel.h"
#import "MRCNavigationControllerStack.h"
#import "MRCReposViewController.h"
#import "MRCNavigationController.h"

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
    
    self.viewControllers = @[ self.reposNavigationController, self.profileNavigationController ];
    
    [[self rac_signalForSelector:@selector(tabBarController:didSelectViewController:) fromProtocol:@protocol(UITabBarControllerDelegate)]
    	subscribeNext:^(RACTuple *tuple) {
            if (tuple.second != MRCSharedAppDelegate.navigationControllerStack.topNavigationController) {
                [MRCSharedAppDelegate.navigationControllerStack popNavigationController];
                [MRCSharedAppDelegate.navigationControllerStack pushNavigationController:tuple.second];
            }
     	}];
    self.delegate = self;
    
    UIImage *image = [UIImage octicon_imageWithIcon:@"MarkGithub"
                                    backgroundColor:HexRGB(0x30434E)
                                          iconColor:UIColor.whiteColor
                                          iconScale:0.8
                                            andSize:CGSizeMake(1024, 1024)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];    
    self.navigationController.navigationBar.hidden = YES;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [MRCSharedAppDelegate.navigationControllerStack pushNavigationController:self.reposNavigationController];
    });
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

- (UINavigationController *)profileNavigationController {
    if (!_profileNavigationController) {
        MRCProfileViewController *profileViewController = [[MRCProfileViewController alloc] initWithViewModel:self.viewModel.profileViewModel];
        profileViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile"
                                                                         image:[UIImage octicon_imageWithIdentifier:@"Person" size:CGSizeMake(25, 25)]
                                                                           tag:4];
        _profileNavigationController = [[MRCNavigationController alloc] initWithRootViewController:profileViewController];
    }
    return _profileNavigationController;
}

@end
