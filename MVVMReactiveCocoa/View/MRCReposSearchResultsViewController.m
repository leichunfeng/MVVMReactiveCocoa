//
//  MRCReposSearchResultsViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCReposSearchResultsViewController.h"
#import "MRCReposSearchResultsViewModel.h"
#import "MRCReposTableViewCell.h"
#import "MRCReposSearchResultsItemViewModel.h"
#import "UIImage+RTTint.h"

@interface MRCReposSearchResultsViewController ()

@property (strong, nonatomic, readonly) MRCReposSearchResultsViewModel *viewModel;

@end

@implementation MRCReposSearchResultsViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSString *)labelText {
    return @"Searching";
}

- (void)configureCell:(MRCReposTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(MRCReposSearchResultsItemViewModel *)viewModel {
    [super configureCell:cell atIndexPath:indexPath withObject:viewModel];
    if (viewModel.repository.isStarred) {
        cell.starIconImageView.image = [cell.starIconImageView.image rt_tintedImageWithColor:HexRGB(colorI5)];
    } else {
        cell.starIconImageView.image = [cell.starIconImageView.image rt_tintedImageWithColor:[UIColor darkGrayColor]];
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.viewModel.query = searchText;
    self.viewModel.dataSource = nil;
    self.viewModel.shouldDisplayEmptyDataSet = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar.text.length > 0) {
        [self.viewModel.requestRemoteDataCommand execute:nil];
    }
}

#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return [[NSAttributedString alloc] initWithString:@"No Results"];
}

#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {}

#pragma mark - UITableViewDelegate

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    MRCReposSearchResultsItemViewModel *viewModel = self.viewModel.dataSource[indexPath.section][indexPath.row];
    if ([viewModel.repository.ownerLogin isEqualToString:[OCTUser mrc_currentUserId]]) {
        return nil;
    } else {
        if (viewModel.repository.isStarred) {
            void (^handler)(UITableViewRowAction *, NSIndexPath *) = ^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                tableView.editing = false;
                
                MRCReposTableViewCell *cell = (MRCReposTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                cell.starIconImageView.image = [cell.starIconImageView.image rt_tintedImageWithColor:[UIColor darkGrayColor]];
                
                MRCReposItemViewModel *viewModel = self.viewModel.dataSource[indexPath.section][indexPath.row];
                [[[self.viewModel.services client] mrc_unstarRepository:viewModel.repository] subscribeNext:^(id x) {}];
            };
            
            UITableViewRowAction *unstarAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                                    title:@"Unstar"
                                                                                  handler:handler];
            return @[ unstarAction ];
        } else {
            void (^handler)(UITableViewRowAction *, NSIndexPath *) = ^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                tableView.editing = false;
                
                MRCReposTableViewCell *cell = (MRCReposTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                cell.starIconImageView.image = [cell.starIconImageView.image rt_tintedImageWithColor:HexRGB(colorI5)];
                
                MRCReposItemViewModel *viewModel = self.viewModel.dataSource[indexPath.section][indexPath.row];
                [[[self.viewModel.services client] mrc_starRepository:viewModel.repository] subscribeNext:^(id x) {}];
            };
            
            UITableViewRowAction *starAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                                  title:@"Star"
                                                                                handler:handler];
            return @[ starAction ];
        }
    }
}

@end
