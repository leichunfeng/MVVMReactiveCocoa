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
#import "MRCNetworkHeaderView.h"
#import "MRCSearchViewModel.h"
#import "MRCNewsCellNode.h"

@interface MRCNewsViewController () <ASTableViewDataSource, ASTableViewDelegate>

@property (nonatomic, weak, readonly) ASTableView *tableView;
@property (nonatomic, strong, readonly) MRCNewsViewModel *viewModel;

@end

@implementation MRCNewsViewController

@dynamic tableView;
@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.asyncDataSource = self;
    self.tableView.asyncDelegate   = self;
    
    if (self.viewModel.type == MRCNewsViewModelTypeNews) {
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        
        MRCNetworkHeaderView *networkHeaderView = [NSBundle.mainBundle loadNibNamed:@"MRCNetworkHeaderView" owner:nil options:nil].firstObject;
        networkHeaderView.frame = tableHeaderView.bounds;
        [tableHeaderView addSubview:networkHeaderView];
        
        RAC(self.tableView, tableHeaderView) = [RACObserve(MRCSharedAppDelegate, networkStatus) map:^(NSNumber *networkStatus) {
            return networkStatus.integerValue == NotReachable ? tableHeaderView : nil;
        }];
    }
    
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

- (UIEdgeInsets)contentInset {
    return self.viewModel.type == MRCNewsViewModelTypeNews ? UIEdgeInsetsMake(64, 0, 49, 0) : [super contentInset];
}

#pragma mark - ASTableViewDataSource

- (ASCellNode *)tableView:(ASTableView *)tableView nodeForRowAtIndexPath:(NSIndexPath *)indexPath {
    MRCNewsItemViewModel *viewModel = self.viewModel.dataSource[indexPath.section][indexPath.row];
    MRCNewsCellNode *cellNode = [[MRCNewsCellNode alloc] initWithViewModel:viewModel];
    return cellNode;
}

@end
