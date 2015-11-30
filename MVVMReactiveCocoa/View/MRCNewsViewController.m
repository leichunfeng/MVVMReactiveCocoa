//
//  MRCNewsViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
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
    
    [[RACObserve(self.viewModel, events) deliverOnMainThread] subscribeNext:^(NSArray *events) {
        @strongify(self)
        
        [self.tableView beginUpdates];
        
        if (self.viewModel.page == 1) {
            self.viewModel.dataSource = [self.viewModel dataSourceWithEvents:events];
            [self.tableView reloadData];
        } else {
            NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
            [events enumerateObjectsUsingBlock:^(OCTEvent *_, NSUInteger idx, BOOL *__) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.viewModel.dataSource.firstObject count] + idx
                                                            inSection:0];
                [indexPaths addObject:indexPath];
            }];
            self.viewModel.dataSource = [self.viewModel.dataSource.rac_sequence map:^(NSArray *viewModels) {
                @strongify(self)
                return [viewModels.rac_sequence concat:[[self.viewModel dataSourceWithEvents:events].firstObject rac_sequence]].array;
            }].array;
            [self.tableView insertRowsAtIndexPaths:indexPaths.copy withRowAnimation:UITableViewRowAnimationNone];
        }
        
        [self.tableView endUpdates];
    }];
}

- (UIEdgeInsets)contentInset {
    return self.viewModel.type == MRCNewsViewModelTypeNews ? UIEdgeInsetsMake(64, 0, 49, 0) : [super contentInset];
}

- (void)reloadData {}

#pragma mark - ASTableViewDataSource

- (ASCellNode *)tableView:(ASTableView *)tableView nodeForRowAtIndexPath:(NSIndexPath *)indexPath {
    MRCNewsItemViewModel *viewModel = self.viewModel.dataSource[indexPath.section][indexPath.row];
    MRCNewsCellNode *cellNode = [[MRCNewsCellNode alloc] initWithViewModel:viewModel];
    return cellNode;
}

- (void)tableView:(ASTableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = HexRGB(colorI7);
}

- (void)tableView:(ASTableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

@end
