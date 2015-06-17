//
//  MRCUserListViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/8.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCUserListViewController.h"
#import "MRCUserListViewModel.h"
#import "MRCUserListTableViewCell.h"
#import "MRCUserListItemViewModel.h"

@interface MRCUserListViewController ()

@property (strong, nonatomic, readonly) MRCUserListViewModel *viewModel;

@end

@implementation MRCUserListViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCUserListTableViewCell" bundle:nil] forCellReuseIdentifier:@"MRCUserListTableViewCell"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"MRCUserListTableViewCell" forIndexPath:indexPath];
}

- (void)configureCell:(MRCUserListTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(MRCUserListItemViewModel *)viewModel {
    [cell bindViewModel:viewModel];
}

@end
