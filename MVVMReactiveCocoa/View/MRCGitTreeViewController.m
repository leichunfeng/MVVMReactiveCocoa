//
//  MRCGitTreeViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/29.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCGitTreeViewController.h"
#import "MRCGitTreeViewModel.h"

@interface MRCGitTreeViewController ()

@property (strong, nonatomic, readonly) MRCGitTreeViewModel *viewModel;

@end

@implementation MRCGitTreeViewController

- (void)viewDidLoad {
//    @weakify(self)
//    [self.viewModel.requestRemoteDataCommand.executionSignals
//     	subscribeNext:^(RACSignal *requestRemoteDataSignal) {
//         	@strongify(self)
//         	[MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = @"Loading...";
//         	[requestRemoteDataSignal subscribeNext:^(id x) {
//             	@strongify(self)
//             	[MBProgressHUD hideHUDForView:self.view animated:YES];
//         	}];
//     	}];
//    
//    [self.viewModel.requestRemoteDataCommand.errors subscribeNext:^(NSError *error) {
//        @strongify(self)
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    }];
    
    [super viewDidLoad];

    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSDictionary *dictionary = self.viewModel.dataSource[indexPath.section][indexPath.row];
    
    OCTTreeEntry *treeEntry = dictionary[@"treeEntry"];
    
    cell.imageView.image = [UIImage octicon_imageWithIdentifier:dictionary[@"identifier"] size:CGSizeMake(22, 22)];
    cell.textLabel.text  = dictionary[@"text"];
    cell.textLabel.numberOfLines = 0;
    
    if (treeEntry.type == OCTTreeEntryTypeBlob) {
        UILabel *sizeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
       
        sizeLabel.text = dictionary[@"size"];
        sizeLabel.font = [UIFont systemFontOfSize:15];
        sizeLabel.textColor = UIColor.grayColor;
        
        [sizeLabel sizeToFit];
        
        cell.accessoryView = sizeLabel;
    } else {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    }
    
    [cell.rac_prepareForReuseSignal subscribeNext:^(id x) {
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.accessoryView  = nil;
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

@end
