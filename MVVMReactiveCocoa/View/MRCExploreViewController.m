//
//  MRCExploreViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/3/26.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCExploreViewController.h"
#import "MRCExploreViewModel.h"
#import "MRCExploreTableViewCell.h"
#import "MRCReposSearchResultsViewController.h"
#import "MRCSearchBar.h"
#import "SDCycleScrollView.h"

@interface MRCExploreViewController () <UISearchBarDelegate, UISearchControllerDelegate, SDCycleScrollViewDelegate>

@property (nonatomic, strong) MRCExploreViewModel *viewModel;

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) MRCReposSearchResultsViewController *searchResultsController;

@end

@implementation MRCExploreViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCExploreTableViewCell" bundle:nil] forCellReuseIdentifier:@"MRCExploreTableViewCell"];
    
    self.searchResultsController = [[MRCReposSearchResultsViewController alloc] initWithViewModel:self.viewModel.searchResultsViewModel];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsController];
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.delegate = self;
    
    MRCSearchBar *searchBar = [[MRCSearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44)];
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    [self.searchController setValue:searchBar forKey:@"searchBar"];
    
    self.definesPresentationContext = YES;
    
//    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 117)];
//    self.tableView.tableHeaderView = tableHeaderView;
    
    SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 117)
                                                                       delegate:self
                                                               placeholderImage:[HexRGB(colorI6) color2ImageSized:CGSizeMake(252, 117)]];
//    [tableHeaderView addSubview:scrollView];
    self.tableView.tableHeaderView = scrollView;
    
    scrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    scrollView.showPageControl = NO;
    scrollView.autoScrollTimeInterval = 3;
    
    RAC(scrollView, imageURLStringsGroup) = [RACObserve(self.viewModel, showcases) map:^(NSArray *showcases) {
        return [showcases.rac_sequence map:^(NSDictionary *showcase) {
            return showcase[@"image_url"];
        }].array;
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.viewModel.requestShowcasesCommand execute:nil];
    [self.viewModel.requestTrendingReposCommand execute:nil];
    [self.viewModel.requestPopularReposCommand execute:nil];
    [self.viewModel.requestPopularUsersCommand execute:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"MRCExploreTableViewCell" forIndexPath:indexPath];
}

- (void)configureCell:(MRCExploreTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(MRCExploreItemViewModel *)viewModel {
    [cell bindViewModel:viewModel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 168;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchController.active = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.viewModel.searchResultsViewModel.dataSource = @[];
    self.viewModel.searchResultsViewModel.query = searchText;
    self.searchController.view.subviews.firstObject.subviews.firstObject.hidden = (searchText.length == 0);
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar.text.length > 0) {
        [searchBar resignFirstResponder];
        [self.viewModel.searchResultsViewModel.requestRemoteDataCommand execute:nil];
    }
}

@end
