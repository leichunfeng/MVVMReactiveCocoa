//
//  MRCLanguageViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/4/24.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCLanguageViewController.h"
#import "MRCLanguageViewModel.h"

@interface MRCLanguageViewController ()

@property (nonatomic, strong) MRCLanguageViewModel *viewModel;

@end

@implementation MRCLanguageViewController

@synthesize viewModel = _viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([self isBeingDismissed] || [self isMovingFromParentViewController]) {
        if (self.viewModel.callback) {
            self.viewModel.callback(self.viewModel.language);
        }
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(NSDictionary *)language {
    cell.textLabel.text = language[@"name"];
    
    if ([language[@"slug"] isEqualToString:self.viewModel.language[@"slug"]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    self.viewModel.language = self.viewModel.dataSource[indexPath.section][indexPath.row];
    
    [tableView reloadData];
}

@end
