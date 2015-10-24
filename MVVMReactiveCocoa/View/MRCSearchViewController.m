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
#import "MRCTrendingViewModel.h"

@interface MRCSearchViewController () <UISearchControllerDelegate, UISearchBarDelegate>

@property (nonatomic, strong, readonly) MRCSearchViewModel *viewModel;
@property (nonatomic, strong, readwrite) UISearchController *searchController;
@property (nonatomic, strong) MRCReposSearchResultsViewController *searchResultsController;

@end

@implementation MRCSearchViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.tableView.tableFooterView = nil;
    
    self.searchResultsController = [[MRCReposSearchResultsViewController alloc] initWithViewModel:self.viewModel.searchResultsViewModel];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsController];
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchBar.tintColor = HexRGB(colorI5);
    self.searchController.searchBar.delegate = self.searchResultsController;
    self.searchController.delegate = self;
    
    self.navigationItem.titleView = self.searchController.searchBar;
    
    self.definesPresentationContext = YES;
}

- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(64, 0, 49, 0);
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(MRCSearch *)search {
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage octicon_imageWithIcon:@"Flame"
                                              backgroundColor:[UIColor clearColor]
                                                    iconColor:HexRGB(0x24AFFC)
                                                    iconScale:1
                                                      andSize:MRC_LEFT_IMAGE_SIZE];
        cell.textLabel.text = @"Trending";
    } else {
        cell.imageView.image = nil;
        cell.textLabel.text  = search.keyword;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = HexRGB(0xF7F7F7);
  
    UILabel *label = [[UILabel alloc] init];
    label.text = section == 0 ? @"Explore" : @"Recent Searches";
    label.font = [UIFont systemFontOfSize:15];
    [label sizeToFit];
    
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    
    CGRect frame = label.frame;
    frame.origin.x = 15;
    frame.origin.y = (height - frame.size.height) / 2;
    label.frame = frame;
    
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 28;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? UITableViewCellEditingStyleNone : UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        MRCTrendingViewModel *trendingViewModel = [[MRCTrendingViewModel alloc] initWithServices:self.viewModel.services params:nil];
        [self.viewModel.services pushViewModel:trendingViewModel animated:YES];
    } else {
        [self presentViewController:self.searchController animated:YES completion:NULL];
        
        MRCSearch *search = self.viewModel.dataSource[indexPath.section][indexPath.row];
        self.searchController.searchBar.text = search.keyword;
        
        if ([self.searchController.searchBar.delegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
            [self.searchController.searchBar.delegate searchBar:self.searchController.searchBar textDidChange:search.keyword];
        }
        
        if ([self.searchController.searchBar.delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]) {
            [self.searchController.searchBar.delegate searchBarSearchButtonClicked:self.searchController.searchBar];
        }
    }
}

@end
