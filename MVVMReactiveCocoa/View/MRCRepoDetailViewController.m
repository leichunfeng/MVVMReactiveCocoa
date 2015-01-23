//
//  MRCRepoDetailViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoDetailViewController.h"
#import "MRCRepoStatisticsTableViewCell.h"
#import "MRCRepoViewCodeTableViewCell.h"
#import "MRCRepoReadMeTableViewCell.h"

@interface MRCRepoDetailViewController ()

@end

@implementation MRCRepoDetailViewController

- (instancetype)initWithViewModel:(id<MRCViewModelProtocol>)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCRepoStatisticsTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"MRCRepoStatisticsTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCRepoViewCodeTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"MRCRepoViewCodeTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCRepoReadMeTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"MRCRepoReadMeTableViewCell"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 1;
        default:
            return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MRCRepoStatisticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MRCRepoStatisticsTableViewCell" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        cell.textLabel.text = @"GitHub API client for Objective-C";
        return cell;
    } else if (indexPath.section == 2) {
        MRCRepoViewCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MRCRepoViewCodeTableViewCell" forIndexPath:indexPath];
        [cell.viewCodeButton setImage:[UIImage octicon_imageWithIdentifier:@"FileDirectory" size:CGSizeMake(22, 22)]
                             forState:UIControlStateNormal];
        return cell;
    } else if (indexPath.section == 3) {
        MRCRepoReadMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MRCRepoReadMeTableViewCell" forIndexPath:indexPath];
        cell.readMeImageView.image = [UIImage octicon_imageWithIdentifier:@"Book" size:CGSizeMake(22, 22)];
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 58;
        case 1:
            return 44;
        case 2:
            return 88;
        case 3:
            return 332;
        default:
            return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 22;
    }
    return 11;
}

@end
