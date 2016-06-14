//
//  MRCTableViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCTableViewController.h"
#import "MRCTableViewModel.h"
#import "MRCTableViewCellStyleValue1.h"
#import "YYFPSLabel.h"

@interface MRCTableViewController ()

@property (nonatomic, weak, readwrite) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak, readwrite) IBOutlet UITableView *tableView;

@property (nonatomic, strong) YYFPSLabel *fpsLabel;

@property (nonatomic, strong, readonly) MRCTableViewModel *viewModel;
@property (nonatomic, strong) CBStoreHouseRefreshControl *refreshControl;

@end

@implementation MRCTableViewController

@dynamic viewModel;

- (instancetype)initWithViewModel:(MRCViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        if ([viewModel shouldRequestRemoteDataOnViewDidLoad]) {
            @weakify(self)
            [[self rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
                @strongify(self)
                [self.viewModel.requestRemoteDataCommand execute:@1];
            }];
        }
    }
    return self;
}

- (void)setView:(UIView *)view {
    [super setView:view];
    if ([view isKindOfClass:UITableView.class]) self.tableView = (UITableView *)view;
}

- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(64, 0, 0, 0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.searchBar != nil) {
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        self.tableView.tableHeaderView = tableHeaderView;
        
        [tableHeaderView addSubview:self.searchBar];
        
        self.searchBar.translatesAutoresizingMaskIntoConstraints = NO;
        
        [tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[searchBar]|"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{ @"searchBar": self.searchBar }]];
        
        [tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[searchBar]|"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{ @"searchBar": self.searchBar }]];
    }
    
    self.tableView.contentOffset = CGPointMake(0, self.searchBar.mrc_height - self.contentInset.top);
    self.tableView.contentInset  = self.contentInset;
    self.tableView.scrollIndicatorInsets = self.contentInset;
    
    self.tableView.sectionIndexColor = [UIColor darkGrayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexMinimumDisplayRowCount = 20;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerClass:[MRCTableViewCellStyleValue1 class] forCellReuseIdentifier:@"MRCTableViewCellStyleValue1"];
    
    @weakify(self)
    if (self.viewModel.shouldPullToRefresh) {
        self.refreshControl = [CBStoreHouseRefreshControl attachToScrollView:self.tableView
                                                                      target:self
                                                               refreshAction:@selector(refreshTriggered:)
                                                                       plist:@"storehouse"
                                                                       color:[UIColor blackColor]
                                                                   lineWidth:1.5
                                                                  dropHeight:80
                                                                       scale:1
                                                        horizontalRandomness:150
                                                     reverseLoadingAnimation:YES
                                                     internalAnimationFactor:0.5];
    }
    
    if (self.viewModel.shouldInfiniteScrolling) {
        [self.tableView addInfiniteScrollingWithActionHandler:^{
            @strongify(self)
            [[[self.viewModel.requestRemoteDataCommand
				execute:@(self.viewModel.page + 1)]
        		deliverOnMainThread]
            	subscribeNext:^(NSArray *results) {
                    @strongify(self)
                    self.viewModel.page += 1;
                } error:^(NSError *error) {
                    @strongify(self)
                    [self.tableView.infiniteScrollingView stopAnimating];
                } completed:^{
                    @strongify(self)
                    [self.tableView.infiniteScrollingView stopAnimating];
                }];
        }];
        
        RAC(self.tableView, showsInfiniteScrolling) = [[RACObserve(self.viewModel, dataSource)
        	deliverOnMainThread]
            map:^(NSArray *dataSource) {
                @strongify(self)
                NSUInteger count = 0;
                for (NSArray *array in dataSource) {
                    count += array.count;
                }
                return @(count >= self.viewModel.perPage);
        }];
    }
    
#ifdef DEBUG
    self.fpsLabel = [[YYFPSLabel alloc] init];
    [self.view addSubview:self.fpsLabel];
    
    self.fpsLabel.left   = 12;
    self.fpsLabel.bottom = SCREEN_HEIGHT - self.contentInset.bottom - 12;
    self.fpsLabel.alpha  = 0;

    [self.fpsLabel sizeToFit];
#endif
}

- (void)dealloc {
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
}

- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self)
    [[[RACObserve(self.viewModel, dataSource)
        distinctUntilChanged]
        deliverOnMainThread]
        subscribeNext:^(id x) {
            @strongify(self)
            [self reloadData];
        }];

    [self.viewModel.requestRemoteDataCommand.executing subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        UIView *emptyDataSetView = [self.tableView.subviews.rac_sequence objectPassingTest:^(UIView *view) {
            return [NSStringFromClass(view.class) isEqualToString:@"DZNEmptyDataSetView"];
        }];
        emptyDataSetView.alpha = 1.0 - executing.floatValue;
    }];
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataSource ? self.viewModel.dataSource.count : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"MRCTableViewCellStyleValue1" forIndexPath:indexPath];
    
    id object = self.viewModel.dataSource[indexPath.section][indexPath.row];
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section >= self.viewModel.sectionIndexTitles.count) return nil;
    return self.viewModel.sectionIndexTitles[section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (self.searchBar != nil) {
        if (self.viewModel.sectionIndexTitles.count != 0) {
            return [self.viewModel.sectionIndexTitles.rac_sequence startWith:UITableViewIndexSearch].array;
        }
    }
    return self.viewModel.sectionIndexTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if (self.searchBar != nil) {
        if (index == 0) {
            [tableView scrollRectToVisible:self.searchBar.frame animated:NO];
        }
        return index - 1;
    }
    return index;
}

#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *topNavigationController = MRCSharedAppDelegate.navigationControllerStack.topNavigationController;
    MRCViewController *topViewController = (MRCViewController *)topNavigationController.topViewController;
    topViewController.snapshot = [topNavigationController.view snapshotViewAfterScreenUpdates:NO];
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewModel.didSelectCommand execute:indexPath];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.refreshControl scrollViewDidScroll];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.fpsLabel.alpha == 0) {
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                            self.fpsLabel.alpha = 1;
                         }
                         completion:NULL];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.refreshControl scrollViewDidEndDragging];
    
    if (!decelerate) {
        if (self.fpsLabel.alpha != 0) {
            [UIView animateWithDuration:1
                                  delay:2
                                options:UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                                 self.fpsLabel.alpha = 0;
                             }
                             completion:NULL];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.fpsLabel.alpha != 0) {
        [UIView animateWithDuration:1
                              delay:2
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.fpsLabel.alpha = 0;
                         }
                         completion:NULL];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if (self.fpsLabel.alpha == 0) {
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.fpsLabel.alpha = 1;
                         }
                         completion:NULL];
    }
}

#pragma mark - Listening for the user to trigger a refresh

- (void)refreshTriggered:(id)sender {
    @weakify(self)
    [[[self.viewModel.requestRemoteDataCommand
     	execute:@1]
     	deliverOnMainThread]
    	subscribeNext:^(id x) {
            @strongify(self)
            self.viewModel.page = 1;
        } error:^(NSError *error) {
            @strongify(self)
            [self.refreshControl finishingLoading];
        } completed:^{
            @strongify(self)
            [self.refreshControl finishingLoading];
        }];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.viewModel.keyword = searchText;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];

    searchBar.text = nil;
    self.viewModel.keyword = nil;
}

#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return [[NSAttributedString alloc] initWithString:@"No Data"];
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return self.viewModel.dataSource == nil;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView {
    return CGPointMake(0, -(self.tableView.contentInset.top - self.tableView.contentInset.bottom) / 2);
}

@end
