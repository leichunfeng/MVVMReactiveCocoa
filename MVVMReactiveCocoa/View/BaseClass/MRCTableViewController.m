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

@interface MRCTableViewController ()

@property (strong, nonatomic, readonly) MRCTableViewModel *viewModel;
@property (strong, nonatomic) CBStoreHouseRefreshControl *refreshControl;

@end

@implementation MRCTableViewController

@dynamic viewModel;

- (instancetype)initWithViewModel:(id<MRCViewModelProtocol>)viewModel {
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.sectionIndexColor = [UIColor darkGrayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexMinimumDisplayRowCount = 20;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerClass:[MRCTableViewCellStyleValue1 class] forCellReuseIdentifier:@"MRCTableViewCellStyleValue1"];
    
    if (self.viewModel.shouldPullToRefresh) {
        self.refreshControl = [CBStoreHouseRefreshControl attachToScrollView:self.tableView
                                                                      target:self
                                                               refreshAction:@selector(refreshTriggered:)
                                                                       plist:@"storehouse"
                                                                       color:UIColor.blackColor
                                                                   lineWidth:1.5
                                                                  dropHeight:80
                                                                       scale:1
                                                        horizontalRandomness:150
                                                     reverseLoadingAnimation:YES
                                                     internalAnimationFactor:0.5];
    }
    
    @weakify(self)
    if (self.viewModel.shouldInfiniteScrolling) {
        [self.tableView addInfiniteScrollingWithActionHandler:^{
            @strongify(self)
            [[[self.viewModel.requestRemoteDataCommand execute:@(self.viewModel.currentPage + 1)]
        		deliverOnMainThread]
            	subscribeNext:^(NSArray *results) {
                    @strongify(self)
                    [self.tableView.infiniteScrollingView stopAnimating];
                    if (results != nil && results.count > 0) self.viewModel.currentPage += 1;
                } error:^(NSError *error) {
                    @strongify(self)
                    [self.tableView.infiniteScrollingView stopAnimating];
                } completed:^{
                    @strongify(self)
                    [self.tableView.infiniteScrollingView stopAnimating];
                }];
        }];
        
        // 当列表的项数大于等于 pageSize 的时候才显示上拉加载，否则隐藏上拉加载功能
        [[RACObserve(self.viewModel, dataSource) deliverOnMainThread] subscribeNext:^(NSArray *dataSource) {
            @strongify(self)
            NSUInteger count = 0;
            for (NSArray *array in dataSource) {
                count += array.count;
            }
            self.tableView.showsInfiniteScrolling = (count >= self.viewModel.pageSize);
        }];
    }
    
    self.tableView.tableFooterView = [UIView new];
}

- (void)dealloc {
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
}

- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self)
    [[[RACObserve(self.viewModel, dataSource) distinctUntilChanged] deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self)
        [self.tableView reloadData];
    }];
    
    [[RACObserve(self.viewModel, shouldDisplayEmptyDataSet) deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self)
        [self.tableView reloadEmptyDataSet];
    }];
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
    return self.viewModel.sectionIndexTitles;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewModel.didSelectCommand execute:indexPath];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.refreshControl scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.refreshControl scrollViewDidEndDragging];
}

#pragma mark - Listening for the user to trigger a refresh

- (void)refreshTriggered:(id)sender {
    @weakify(self)
    [[[self.viewModel.requestRemoteDataCommand
     	execute:@1]
     	deliverOnMainThread]
    	subscribeNext:^(id x) {
            @strongify(self)
            [self.refreshControl finishingLoading];
        } error:^(NSError *error) {
            @strongify(self)
            [self.refreshControl finishingLoading];
        } completed:^{
            @strongify(self)
            [self.refreshControl finishingLoading];
        }];
}

#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return [[NSAttributedString alloc] initWithString:@"No Data"];
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return self.viewModel.shouldDisplayEmptyDataSet;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView {
    return CGPointMake(0, -(self.tableView.contentInset.top - self.tableView.contentInset.bottom) / 2);
}

@end
