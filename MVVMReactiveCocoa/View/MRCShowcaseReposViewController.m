//
//  MRCShowcaseReposViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/4/24.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCShowcaseReposViewController.h"
#import "MRCShowcaseReposViewModel.h"
#import "MRCShowcaseHeaderView.h"

@interface MRCShowcaseReposViewController ()

@property (nonatomic, strong) MRCShowcaseReposViewModel *viewModel;

@end

@implementation MRCShowcaseReposViewController

@synthesize viewModel = _viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.viewModel.headerViewModel.height)];
    
    RAC(self.tableView, tableHeaderView) = [RACObserve(self.viewModel, dataSource) map:^(NSArray *dataSource) {
        return dataSource.count == 0 ? nil : tableHeaderView;
    }];

    MRCShowcaseHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"MRCShowcaseHeaderView"
                                                                      owner:nil
                                                                    options:nil].firstObject;
    [tableHeaderView addSubview:headerView];
    
    headerView.frame = tableHeaderView.bounds;

    [headerView bindViewModel:self.viewModel.headerViewModel];
}

- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(64, 0, 0, 0);
}

@end
