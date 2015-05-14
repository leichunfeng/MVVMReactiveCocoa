//
//  MRCRepoSettingsViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/11.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoSettingsViewController.h"
#import "MRCRepoSettingsViewModel.h"

@interface MRCRepoSettingsViewController ()

@property (strong, nonatomic, readonly) MRCRepoSettingsViewModel *viewModel;

@end

@implementation MRCRepoSettingsViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tintColor = HexRGB(colorI3);
    
    @weakify(self)
    [[RACObserve(self.viewModel, isStarred) deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self)
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Owner";
            cell.detailTextLabel.text = self.viewModel.repository.ownerLogin;
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"Name";
            cell.detailTextLabel.text = self.viewModel.repository.name;
        }
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"Language";
        cell.detailTextLabel.text = self.viewModel.repository.language ?: @"Unknown";
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage octicon_imageWithIcon:@"Star"
                                                  backgroundColor:[UIColor clearColor]
                                                        iconColor:HexRGB(colorI3)
                                                        iconScale:1
                                                          andSize:MRC_LEFT_IMAGE_SIZE];
            cell.textLabel.text = @"Star";
            cell.accessoryType  = self.viewModel.isStarred ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        } else if (indexPath.row == 1) {
            cell.imageView.image = [UIImage octicon_imageWithIcon:@"Star"
                                                  backgroundColor:[UIColor clearColor]
                                                        iconColor:[UIColor lightGrayColor]
                                                        iconScale:1
                                                          andSize:MRC_LEFT_IMAGE_SIZE];
            cell.textLabel.text = @"Unstar";
            cell.accessoryType  = !self.viewModel.isStarred ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        }
    } else if (indexPath.section == 3) {
        cell.textLabel.text = @"Default Branch";
        cell.detailTextLabel.text = self.viewModel.repository.defaultBranch;
    } else if (indexPath.section == 4) {
        cell.textLabel.text = @"Open Issues";
        cell.detailTextLabel.text = [@(self.viewModel.repository.openIssuesCount) stringValue];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0 || section == 2) ? 2 : 1;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 20 : 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return (section == tableView.numberOfSections - 1) ? 20 : 10;
}

@end
