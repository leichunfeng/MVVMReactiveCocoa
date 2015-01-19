//
//  MRCStarredReposViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCStarredReposViewController.h"
#import "MRCStarredReposViewModel.h"
#import "MRCReposTableViewCell.h"

@interface MRCStarredReposViewController ()

@property (strong, nonatomic, readonly) MRCStarredReposViewModel *viewModel;
@property (strong, nonatomic) CBStoreHouseRefreshControl *refreshControl;

@end

@implementation MRCStarredReposViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 78;
    self.tableView.sectionIndexColor = [UIColor darkGrayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCReposTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"MRCReposTableViewCell"];
    
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

- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self)
    [RACObserve(self.viewModel, dataSource) subscribeNext:^(id x) {
        @strongify(self)
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MRCReposTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MRCReposTableViewCell"];
    [cell bindViewModel:self.viewModel.dataSource[indexPath.section][indexPath.row]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.viewModel.sectionIndexTitles[section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.viewModel.sectionIndexTitles;
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
    [self performSelector:@selector(finishRefreshControl) withObject:nil afterDelay:3 inModes:@[NSRunLoopCommonModes]];
}

- (void)finishRefreshControl {
    [self.refreshControl finishingLoading];
}

@end
