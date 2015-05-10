//
//  MRCReposSearchResultsViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCReposSearchResultsViewController.h"
#import "MRCReposSearchResultsViewModel.h"

@interface MRCReposSearchResultsViewController ()

@property (strong, nonatomic, readonly) MRCReposSearchResultsViewModel *viewModel;

@end

@implementation MRCReposSearchResultsViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.viewModel.query = searchText;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.viewModel.requestRemoteDataCommand execute:nil];
}

@end
