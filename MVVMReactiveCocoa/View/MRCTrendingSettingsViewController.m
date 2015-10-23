//
//  MRCTrendingSettingsViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/10/21.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import "MRCTrendingSettingsViewController.h"
#import "MRCTrendingSettingsViewModel.h"

@interface MRCTrendingSettingsViewController ()

@property (nonatomic, strong, readonly) MRCTrendingSettingsViewModel *viewModel;

@end

@implementation MRCTrendingSettingsViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(didClickCancelButton:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(didClickDoneButton:)];
    
    @weakify(self)
    [[[RACSignal
		combineLatest:@[
        	RACObserve(self.viewModel, since).distinctUntilChanged,
            RACObserve(self.viewModel, language).distinctUntilChanged
        ]]
        skip:1]
    	subscribeNext:^(id x) {
            @strongify(self)
            [self.tableView reloadData];
        }];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(NSDictionary *)dictionary {
    cell.textLabel.text = dictionary[@"name"];
    cell.accessoryType  = UITableViewCellAccessoryNone;

    if (indexPath.section == 0) {
        if ([dictionary isEqualToDictionary:self.viewModel.since]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    } else if (indexPath.section == 1) {
        if ([dictionary isEqualToDictionary:self.viewModel.language]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
}

- (void)didClickCancelButton:(id)sender {
    [self.viewModel.services dismissViewModelAnimated:YES completion:NULL];
}

- (void)didClickDoneButton:(id)sender {
    if (self.viewModel.callback) {
        self.viewModel.callback(RACTuplePack(self.viewModel.since, self.viewModel.language));
    }
    [self.viewModel.services dismissViewModelAnimated:YES completion:NULL];
}

#pragma mark - UITableViewDataSource

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dictionary = self.viewModel.dataSource[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        self.viewModel.since = dictionary;
    } else if (indexPath.section == 1) {
        self.viewModel.language = dictionary;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 40 : 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return (section == tableView.numberOfSections - 1) ? 40 : 20;
}

@end
