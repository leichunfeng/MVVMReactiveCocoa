//
//  MRCUsersViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/8.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCUsersViewController.h"
#import "MRCUsersViewModel.h"
#import "MRCUsersTableViewCell.h"
#import "MRCUsersItemViewModel.h"

@interface MRCUsersViewController ()

@property (strong, nonatomic, readonly) MRCUsersViewModel *viewModel;

@end

@implementation MRCUsersViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCUsersTableViewCell" bundle:nil] forCellReuseIdentifier:@"MRCUsersTableViewCell"];
    
    [self.viewModel requestRemoteDataSignalWithCurrentPage:1];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"MRCUsersTableViewCell" forIndexPath:indexPath];
}

- (void)configureCell:(MRCUsersTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(MRCUsersItemViewModel *)viewModel {
    [cell bindViewModel:viewModel];
}

@end
