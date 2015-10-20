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
#import "MRCNavigationControllerStack.h"
#import "MRCReposViewController.h"
#import "MRCNavigationController.h"
#import "MRCSearchViewController.h"
#import "MRCUserListViewModel.h"
#import "MRCTrendingViewController.h"

@interface MRCHomepageViewController () <UITabBarControllerDelegate>

@property (nonatomic, strong) MRCHomepageViewModel      *viewModel;
@property (nonatomic, strong) MRCNewsViewController     *newsViewController;
@property (nonatomic, strong) MRCReposViewController    *reposViewController;
@property (nonatomic, strong) MRCTrendingViewController *trendingViewController;
@property (nonatomic, strong) MRCSearchViewController   *searchViewController;
@property (nonatomic, strong) MRCProfileViewController  *profileViewController;

@end

@implementation MRCHomepageViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;

    self.newsViewController = [[MRCNewsViewController alloc] initWithViewModel:self.viewModel.newsViewModel];
    UIImage *newsImage = [UIImage octicon_imageWithIdentifier:@"Rss" size:CGSizeMake(25, 25)];
    self.newsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"News" image:newsImage tag:1];

    self.reposViewController = [[MRCReposViewController alloc] initWithViewModel:self.viewModel.reposViewModel];
    UIImage *reposImage = [UIImage octicon_imageWithIdentifier:@"Repo" size:CGSizeMake(25, 25)];
    self.reposViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Repositories" image:reposImage tag:2];

    self.trendingViewController = [[MRCTrendingViewController alloc] initWithViewModel:self.viewModel.trendingViewModel];
    UIImage *trendingImage = [UIImage octicon_imageWithIdentifier:@"Telescope" size:CGSizeMake(25, 25)];
    self.trendingViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Explore" image:trendingImage tag:3];

    self.searchViewController = [[MRCSearchViewController alloc] initWithViewModel:self.viewModel.searchViewModel];
    UIImage *searchImage = [UIImage octicon_imageWithIdentifier:@"Search" size:CGSizeMake(25, 25)];
    self.searchViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Search" image:searchImage tag:4];

    UIImage *profileImage = [UIImage octicon_imageWithIdentifier:@"Person" size:CGSizeMake(25, 25)];
    self.profileViewController = [[MRCProfileViewController alloc] initWithViewModel:self.viewModel.profileViewModel];
    self.profileViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:profileImage tag:5];

    self.viewControllers = @[
		self.newsViewController,
        self.reposViewController,
        self.trendingViewController,
//        self.searchViewController,
        self.profileViewController
	];

    [[[self
        rac_signalForSelector:@selector(tabBarController:didSelectViewController:)
        fromProtocol:@protocol(UITabBarControllerDelegate)]
        startWith:RACTuplePack(self, self.newsViewController)]
        subscribeNext:^(RACTuple *tuple) {
            RACTupleUnpack(UITabBarController *tabBarController, UIViewController *viewController) = tuple;

            tabBarController.navigationItem.title = [((MRCViewController *)viewController).viewModel title];

            if (viewController.tabBarItem.tag == 1) {
                tabBarController.navigationItem.titleView = nil;
                
                UIImage *image = [UIImage octicon_imageWithIdentifier:@"Search" size:CGSizeMake(22, 22)];
                
                tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                                                      style:UIBarButtonItemStylePlain
                                                                                                     target:nil
                                                                                                     action:NULL];
            } else if (viewController.tabBarItem.tag == 2) {
                tabBarController.navigationItem.titleView = ((MRCReposViewController *)viewController).segmentedControl;
            } else if (viewController.tabBarItem.tag == 3) {
                tabBarController.navigationItem.titleView = nil;
                
                UIImage *image = [UIImage octicon_imageWithIdentifier:@"Gear" size:CGSizeMake(22, 22)];
                
                tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                                                      style:UIBarButtonItemStylePlain
                                                                                                     target:nil
                                                                                                     action:NULL];
            } else if (viewController.tabBarItem.tag == 4) {
                tabBarController.navigationItem.titleView = ((MRCSearchViewController *)viewController).searchController.searchBar;
            } else if (viewController.tabBarItem.tag == 5) {
                tabBarController.navigationItem.titleView = nil;
            }
        }];
    self.delegate = self;
}

@end
