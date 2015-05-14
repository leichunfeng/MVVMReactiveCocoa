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
    
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    self.tableView.tableFooterView = nil;
    
    self.searchResultsController = [[MRCReposSearchResultsViewController alloc] initWithViewModel:self.viewModel.searchResultsViewModel];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsController];
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchBar.tintColor = HexRGB(0x24AFFC);
    self.searchController.searchBar.delegate = self.searchResultsController;
    self.searchController.delegate = self;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(MRCSearch *)search {
    cell.textLabel.text = search.keyword;
}

#pragma mark - UISearchControllerDelegate

- (void)presentSearchController:(UISearchController *)searchController {
    [self presentViewController:searchController animated:YES completion:NULL];
}

#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MRCSearch *search = self.viewModel.dataSource[indexPath.section][indexPath.row];
        if ([search mrc_delete]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:MRCRecentSearchesDidChangeNotification object:nil];
        }
    });
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = HexRGB(0xF7F7F7);
  
    UILabel *label = [UILabel new];
    label.text = @"Recent Searches";
    label.font = [UIFont systemFontOfSize:15];
    [label sizeToFit];
    
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    
    CGRect frame = label.frame;
    frame.origin.x = 20;
    frame.origin.y = (height - frame.size.height) / 2;
    label.frame = frame;
    
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 28;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self presentSearchController:self.searchController];

    MRCSearch *search = self.viewModel.dataSource[indexPath.section][indexPath.row];
    self.searchController.searchBar.text = search.keyword;
    
    if ([self.searchController.searchBar.delegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
        [self.searchController.searchBar.delegate searchBar:self.searchController.searchBar textDidChange:search.keyword];
    }
    
    if ([self.searchController.searchBar.delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]) {
        [self.searchController.searchBar.delegate searchBarSearchButtonClicked:self.searchController.searchBar];
    }
}

@end
