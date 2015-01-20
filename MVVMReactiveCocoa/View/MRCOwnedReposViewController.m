//
//  MRCOwnedReposViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCOwnedReposViewController.h"
#import "MRCOwnedReposViewModel.h"
#import "MRCReposTableViewCell.h"

@interface MRCOwnedReposViewController ()

@property (strong, nonatomic, readonly) MRCOwnedReposViewModel *viewModel;

@end

@implementation MRCOwnedReposViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 78;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCReposTableViewCell" bundle:nil] forCellReuseIdentifier:@"MRCReposTableViewCell"];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MRCReposTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MRCReposTableViewCell"];
    [cell bindViewModel:self.viewModel.dataSource[indexPath.section][indexPath.row]];
    return cell;
}

@end
