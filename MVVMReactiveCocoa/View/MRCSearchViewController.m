//
//  MRCSearchViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCSearchViewController.h"
#import "MRCSearchViewModel.h"
#import "MRCReposSearchResultsViewController.h"

@interface MRCSearchViewController () <UISearchControllerDelegate, UISearchBarDelegate>

@property (strong, nonatomic, readonly) MRCSearchViewModel *viewModel;
@property (strong, nonatomic, readwrite) UISearchController *searchController;
@property (strong, nonatomic) MRCReposSearchResultsViewController *searchResultsController;

@end

@implementation MRCSearchViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchResultsController = [[MRCReposSearchResultsViewController alloc] initWithViewModel:self.viewModel.searchResultsViewModel];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsController];
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchBar.showsCancelButton = NO;
    self.searchController.searchBar.tintColor = HexRGB(0x24AFFC);
    self.searchController.searchBar.delegate = self.searchResultsController;
    self.searchController.delegate = self;
}

- (void)willPresentSearchController:(UISearchController *)searchController {

}

- (void)didPresentSearchController:(UISearchController *)searchController {

}

- (void)willDismissSearchController:(UISearchController *)searchController {
    
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    
}

- (void)presentSearchController:(UISearchController *)searchController {
    [self presentViewController:searchController animated:YES completion:NULL];
}

@end
