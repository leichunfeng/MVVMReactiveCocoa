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
#import "MRCUsersViewModel.h"

@interface MRCHomepageViewController () <UITabBarControllerDelegate>

@property (strong, nonatomic, readonly) MRCHomepageViewModel *viewModel;

@property (strong, nonatomic) MRCReposViewController   *reposViewController;
@property (strong, nonatomic) MRCSearchViewController  *searchViewController;
@property (strong, nonatomic) MRCProfileViewController *profileViewController;

@end

@implementation MRCHomepageViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.reposViewController = [[MRCReposViewController alloc] initWithViewModel:self.viewModel.reposViewModel];
    UIImage *reposImage = [UIImage octicon_imageWithIdentifier:@"Repo" size:CGSizeMake(25, 25)];
    self.reposViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Repositories" image:reposImage tag:1];
    
    self.searchViewController = [[MRCSearchViewController alloc] initWithViewModel:self.viewModel.searchViewModel];
    UIImage *searchImage = [UIImage octicon_imageWithIdentifier:@"Search" size:CGSizeMake(25, 25)];
    self.searchViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Search" image:searchImage tag:2];
    
    UIImage *profileImage = [UIImage octicon_imageWithIdentifier:@"Person" size:CGSizeMake(25, 25)];
    self.profileViewController = [[MRCProfileViewController alloc] initWithViewModel:self.viewModel.profileViewModel];
    self.profileViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:profileImage tag:3];
    
    self.viewControllers = @[ self.reposViewController, self.searchViewController, self.profileViewController ];
    
    [[[self
        rac_signalForSelector:@selector(tabBarController:didSelectViewController:)
        fromProtocol:@protocol(UITabBarControllerDelegate)]
        startWith:RACTuplePack(self, self.reposViewController)]
        subscribeNext:^(RACTuple *tuple) {
            RACTupleUnpack(UITabBarController *tabBarController, UIViewController *viewController) = tuple;
            
            tabBarController.navigationItem.title = [((MRCViewController *)viewController).viewModel title];
            
            if (viewController.tabBarItem.tag == 1) {
                tabBarController.navigationItem.titleView = ((MRCReposViewController *)viewController).segmentedControl;
            } else if (viewController.tabBarItem.tag == 2) {
                tabBarController.navigationItem.titleView = ((MRCSearchViewController *)viewController).searchController.searchBar;
            } else if (viewController.tabBarItem.tag == 3) {
                tabBarController.navigationItem.titleView = nil;
            }
        }];
    self.delegate = self;
}

@end
