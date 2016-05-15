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

@property (nonatomic, strong, readonly) MRCAboutViewModel *viewModel;

@end

@implementation MRCAboutViewController

@dynamic viewModel;

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
    copyRightLabel.text = @"Copyright (c) 2015-2016 leichunfeng. All rights reserved.";
    copyRightLabel.font = [UIFont systemFontOfSize:12];
    copyRightLabel.textColor = UIColor.lightGrayColor;
    copyRightLabel.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:copyRightLabel];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Version upgrade";
        
        @weakify(self)
        [RACObserve(self.viewModel, isLatestVersion) subscribeNext:^(NSNumber *isLatestVersion) {
            @strongify(self)
            if (isLatestVersion.boolValue) {
                cell.detailTextLabel.text = @"Latest version";
                cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
                cell.detailTextLabel.textColor = HexRGB(0x8E8E93);
                cell.detailTextLabel.layer.cornerRadius  = 0;
                cell.detailTextLabel.layer.masksToBounds = YES;
                cell.detailTextLabel.backgroundColor = [UIColor clearColor];
                cell.accessoryType  = UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            } else {
                cell.detailTextLabel.text = [NSString stringWithFormat:@" new v%@ ", self.viewModel.appStoreVersion];
                cell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
                cell.detailTextLabel.textColor = [UIColor whiteColor];
                cell.detailTextLabel.layer.cornerRadius  = 10;
                cell.detailTextLabel.layer.masksToBounds = YES;
                cell.detailTextLabel.backgroundColor = HexRGB(0xF13839);
                cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
        }];
        
        cell.hidden = YES;
    } else if (indexPath.row == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"Rate %@", MRC_APP_NAME];
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"Source Code";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"Author";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"Feedback";
    }
    
    [cell.rac_prepareForReuseSignal subscribeNext:^(id x) {
        cell.detailTextLabel.text = nil;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.hidden = NO;
    }];
}

- (void)openAppStore {
    [UIApplication.sharedApplication openURL:[NSURL URLWithString:MRC_APP_STORE_REVIEW_URL]];
}

#pragma mark - UITalbeViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0 ? 0 : 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        if (!self.viewModel.isLatestVersion) [self openAppStore];
    } else if (indexPath.row == 1) {
        [self openAppStore];
    }
}

@end
