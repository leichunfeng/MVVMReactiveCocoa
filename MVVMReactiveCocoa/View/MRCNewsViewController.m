//
//  MRCNewsViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCNewsViewController.h"
#import "MRCNewsViewModel.h"
#import "MRCNewsTableViewCell.h"
#import "MRCNewsItemViewModel.h"

@interface MRCNewsViewController ()

@property (strong, nonatomic, readonly) MRCNewsViewModel *viewModel;
@property (strong, nonatomic) NSCache *cache;

@end

@implementation MRCNewsViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cache = [[NSCache alloc] init];
    
    self.tableView.contentOffset = CGPointMake(0, -64);
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCNewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"MRCNewsTableViewCell"];
}

- (MRCNewsTableViewCell *)tableView:(UITableView *)tableView preparedCellForIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.row];
    
    MRCNewsTableViewCell *cell = [self.cache objectForKey:key];

    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MRCNewsTableViewCell"];
        [self.cache setObject:cell forKey:key];
    }
    
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(MRCNewsTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    MRCNewsItemViewModel *viewModel = self.viewModel.dataSource[indexPath.section][indexPath.row];
    [cell bindViewModel:viewModel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MRCNewsTableViewCell *cell = [self tableView:tableView preparedCellForIndexPath:indexPath];
    return [cell height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView preparedCellForIndexPath:indexPath];
}

@end
