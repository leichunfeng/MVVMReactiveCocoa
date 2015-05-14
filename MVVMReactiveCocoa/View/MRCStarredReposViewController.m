//
//  MRCStarredReposViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCStarredReposViewController.h"
#import "MRCStarredReposViewModel.h"
#import "MRCReposItemViewModel.h"

@interface MRCStarredReposViewController ()

@property (strong, nonatomic, readonly) MRCStarredReposViewModel *viewModel;

@end

@implementation MRCStarredReposViewController

@dynamic viewModel;

#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {}

#pragma mark - UITableViewDelegate

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    void (^handler)(UITableViewRowAction *, NSIndexPath *) = ^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        tableView.editing = false;
        
        MRCReposItemViewModel *viewModel = self.viewModel.dataSource[indexPath.section][indexPath.row];
        [[[self.viewModel.services client] mrc_unstarRepository:viewModel.repository] subscribeNext:^(id x) {}];
    };
    
    UITableViewRowAction *unstarAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                            title:@"Unstar"
                                                                          handler:handler];
    return @[ unstarAction ];
}

@end
