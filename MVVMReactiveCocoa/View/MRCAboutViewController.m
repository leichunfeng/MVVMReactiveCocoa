//
//  MRCAboutViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/3/4.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCAboutViewController.h"
#import "MRCAboutHeaderView.h"
#import "MRCAboutViewModel.h"

@interface MRCAboutViewController ()

@property (strong, nonatomic, readonly) MRCAboutViewModel *viewModel;

@end

@implementation MRCAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 112)];
    MRCAboutHeaderView *aboutHeaderView = [NSBundle.mainBundle loadNibNamed:@"MRCAboutHeaderView" owner:nil options:nil].firstObject;
    aboutHeaderView.frame = tableHeaderView.bounds;
    [tableHeaderView addSubview:aboutHeaderView];
    self.tableView.tableHeaderView = tableHeaderView;
    
    UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 10 - 14 - 64 - 14, SCREEN_WIDTH, 14)];
    usernameLabel.text = @"leichunfeng";
    usernameLabel.font = [UIFont systemFontOfSize:12];
    usernameLabel.textColor = UIColor.lightGrayColor;
    usernameLabel.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:usernameLabel];
    
    UILabel *copyRightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 10 - 14 - 64, SCREEN_WIDTH, 14)];
    copyRightLabel.text = @"Copyright (c) 2015年 leichunfeng. All rights reserved.";
    copyRightLabel.font = [UIFont systemFontOfSize:12];
    copyRightLabel.textColor = UIColor.lightGrayColor;
    copyRightLabel.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:copyRightLabel];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Version upgrade";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"Rate iGitHub";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"About iGitHub";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"Feedback";
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

#pragma mark - UITalbeViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

@end
