//
//  MRCSearchViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCSearchViewController.h"
#import "MRCSearchViewModel.h"
#import "MRCOwnedReposViewController.h"

@interface MRCSearchViewController ()

@property (strong, nonatomic, readonly) MRCSearchViewModel *viewModel;

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) MRCOwnedReposViewController *searchResultsController;

@end

@implementation MRCSearchViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchResultsController = [[MRCOwnedReposViewController alloc] initWithViewModel:self.viewModel.searchResultsViewModel];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsController];
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    self.navigationItem.titleView = self.searchController.searchBar;
}

@end
