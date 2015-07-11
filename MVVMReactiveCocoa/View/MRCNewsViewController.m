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
#import "MRCNewsCommentedTableViewCell.h"

@interface MRCNewsViewController ()

@property (strong, nonatomic, readonly) MRCNewsViewModel *viewModel;
@property (strong, nonatomic) DTAttributedLabel *attributedLabel;

@end

@implementation MRCNewsViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentOffset = CGPointMake(0, -64);
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCNewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"MRCNewsTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCNewsCommentedTableViewCell" bundle:nil] forCellReuseIdentifier:@"MRCNewsCommentedTableViewCell"];
    
    self.attributedLabel = [[DTAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 10 - 40 - 10 - 10, 15)];
    self.attributedLabel.layoutFrameHeightIsConstrainedByBounds = NO;
    
    @weakify(self)
    [self.viewModel.requestRemoteDataCommand.executing subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        if (executing.boolValue && self.viewModel.dataSource == nil) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = MBPROGRESSHUD_LABEL_TEXT;
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    MRCNewsItemViewModel *viewModel = self.viewModel.dataSource[indexPath.section][indexPath.row];
    switch (viewModel.type) {
        case MRCNewsItemViewModelTypeStarred:
            return [tableView dequeueReusableCellWithIdentifier:@"MRCNewsTableViewCell" forIndexPath:indexPath];
        case MRCNewsItemViewModelTypeCommented:
            return [tableView dequeueReusableCellWithIdentifier:@"MRCNewsCommentedTableViewCell" forIndexPath:indexPath];
        case MRCNewsItemViewModelTypePullRequest:
            return [tableView dequeueReusableCellWithIdentifier:@"MRCNewsTableViewCell" forIndexPath:indexPath];
        case MRCNewsItemViewModelTypePushed:
            return [tableView dequeueReusableCellWithIdentifier:@"MRCNewsTableViewCell" forIndexPath:indexPath];
        default: {
            return [tableView dequeueReusableCellWithIdentifier:@"MRCNewsTableViewCell" forIndexPath:indexPath];
        }
    }
}

- (void)configureCell:(MRCNewsTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(MRCNewsItemViewModel *)viewModel {
    [cell bindViewModel:viewModel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MRCNewsItemViewModel *viewModel = self.viewModel.dataSource[indexPath.section][indexPath.row];
    switch (viewModel.type) {
        case MRCNewsItemViewModelTypeStarred:
            return [MRCNewsTableViewCell heightWithViewModel:viewModel];
        case MRCNewsItemViewModelTypeCommented:
            return [MRCNewsCommentedTableViewCell heightWithViewModel:viewModel];
        case MRCNewsItemViewModelTypePullRequest:
            return [MRCNewsTableViewCell heightWithViewModel:viewModel];
        case MRCNewsItemViewModelTypePushed:
            return [MRCNewsTableViewCell heightWithViewModel:viewModel];
        default: {
            return [MRCNewsTableViewCell heightWithViewModel:viewModel];
        }
    }
}

@end
