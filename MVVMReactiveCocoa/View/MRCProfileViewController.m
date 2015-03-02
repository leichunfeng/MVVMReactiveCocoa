//
//  MRCProfileViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCProfileViewController.h"
#import "MRCProfileViewModel.h"
#import "MRCAvatarHeaderView.h"
#import "MRCAvatarHeaderViewModel.h"

@interface MRCProfileViewController ()

@property (strong, nonatomic, readonly) MRCProfileViewModel *viewModel;

@end

@implementation MRCProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MRCAvatarHeaderView *avatarHeaderView = [[NSBundle mainBundle] loadNibNamed:@"MRCAvatarHeaderView" owner:nil options:nil].firstObject;
    [avatarHeaderView bindViewModel:self.viewModel.avatarHeaderViewModel];
    self.tableView.tableHeaderView = avatarHeaderView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.viewModel.fetchUserInfoCommand execute:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y + 64);
    self.viewModel.avatarHeaderViewModel.contentOffset = contentOffset;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage octicon_imageWithIdentifier:self.viewModel.dataSource[indexPath.section][indexPath.row][@"identifier"]
                                                           size:CGSizeMake(22, 22)];
    
    [self.viewModel.dataSource[indexPath.section][indexPath.row][@"textSignal"] subscribeNext:^(NSString *text) {
        cell.textLabel.text = text;
    }];
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.accessoryType = indexPath.section == 0 ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 20 : 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

@end
