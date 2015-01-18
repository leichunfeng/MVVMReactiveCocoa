//
//  MRCRepositoriesViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepositoriesViewController.h"
#import "MRCRepositoriesViewModel.h"
#import "MRCRepositoriesTableViewCell.h"
#import "MRCRepositoriesItemViewModel.h"
#import "MRCSearchBarTableViewCell.h"

@interface MRCRepositoriesViewController ()

@property (strong, nonatomic, readonly) MRCRepositoriesViewModel *viewModel;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;

@end

@implementation MRCRepositoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 78;
    self.tableView.sectionIndexColor = [UIColor darkGrayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCSearchBarTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"MRCSearchBarTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCRepositoriesTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"MRCRepositoriesTableViewCell"];
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[ @"Owned", @"Starred" ]];
    self.segmentedControl.tintColor = [UIColor whiteColor];
    self.segmentedControl.selectedSegmentIndex = 0;
    
    self.navigationItem.titleView = self.segmentedControl;
}

- (void)bindViewModel {
    [super bindViewModel];
    
    RAC(self.viewModel, selectedSegmentIndex) = [self.segmentedControl rac_newSelectedSegmentIndexChannelWithNilValue:@0];
    self.viewModel.selectedSegmentIndex = self.segmentedControl.selectedSegmentIndex;
    
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
    MRCRepositoriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MRCRepositoriesTableViewCell"];
    [cell bindViewModel:self.viewModel.dataSource[indexPath.section][indexPath.row]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.viewModel.sectionIndexTitles[section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.viewModel.sectionIndexTitles;
}

@end
