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

@interface MRCExploreViewController ()

@property (nonatomic, strong) MRCExploreViewModel *viewModel;

@end

@implementation MRCExploreViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCExploreTableViewCell" bundle:nil] forCellReuseIdentifier:@"MRCExploreTableViewCell"];
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

@end
