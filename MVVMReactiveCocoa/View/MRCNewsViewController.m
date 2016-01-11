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
#import "MRCNewsItemViewModel.h"
#import "MRCNetworkHeaderView.h"
#import "MRCSearchViewModel.h"
#import "MRCNewsCellNode.h"

@interface MRCNewsViewController () <ASTableViewDataSource, ASTableViewDelegate>

@property (nonatomic, strong) ASTableView *tableView;
@property (nonatomic, strong, readonly) MRCNewsViewModel *viewModel;

@end

@implementation MRCNewsViewController

@dynamic tableView;
@dynamic viewModel;

- (void)viewDidLoad {
    self.tableView = ({
        ASTableView *tableView = [[ASTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:tableView];
        
        tableView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|"
                                                                          options:0
                                                                          metrics:0
                                                                            views:NSDictionaryOfVariableBindings(tableView)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|"
                                                                          options:0
                                                                          metrics:0
                                                                            views:NSDictionaryOfVariableBindings(tableView)]];
        
        tableView;
    });

    [super viewDidLoad];
    
    self.tableView.asyncDataSource = self;
    self.tableView.asyncDelegate   = self;
    
    self.tableView.emptyDataSetSource   = self;
    self.tableView.emptyDataSetDelegate = self;
    
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
    RAC(self.viewModel, titleViewType) = [self.viewModel.requestRemoteDataCommand.executing map:^(NSNumber *executing) {
        return executing.boolValue ? @(MRCTitleViewTypeLoadingTitle) : @(MRCTitleViewTypeDefault);
    }];
    
    [self.viewModel.requestRemoteDataCommand.executing subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        if (executing.boolValue && self.viewModel.dataSource == nil) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = MBPROGRESSHUD_LABEL_TEXT;
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
    
    [[[RACObserve(self.viewModel, events)
        filter:^(NSArray *events) {
            return @(events.count > 0).boolValue;
        }]
        deliverOnMainThread]
        subscribeNext:^(NSArray *events) {
            @strongify(self)

            if (self.viewModel.dataSource == nil) {
                NSArray *viewModels = [events.rac_sequence map:^(OCTEvent *event) {
                    @strongify(self)
                    MRCNewsItemViewModel *viewModel = [[MRCNewsItemViewModel alloc] initWithEvent:event];
                    viewModel.didClickLinkCommand = self.viewModel.didClickLinkCommand;
                    return viewModel;
                }].array;

                self.viewModel.dataSource = @[ viewModels ];
                
                UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                maskView.backgroundColor = [UIColor whiteColor];
                [self.view insertSubview:maskView aboveSubview:self.tableView];
                
                [self.tableView beginUpdates];
                [self.tableView reloadData];
                [self.tableView endUpdatesAnimated:NO completion:^(BOOL completed) {
                    [UIView animateWithDuration:1 animations:^{
                        maskView.alpha = 0;
                    } completion:^(BOOL finished) {
                        [maskView removeFromSuperview];
                    }];
                }];
            } else {
                NSArray *viewModels = [[events.rac_sequence
                    map:^(OCTEvent *event) {
                        @strongify(self)
                        MRCNewsItemViewModel *viewModel = [[MRCNewsItemViewModel alloc] initWithEvent:event];
                        viewModel.didClickLinkCommand = self.viewModel.didClickLinkCommand;
                        return viewModel;
                    }]
                    concat:[self.viewModel.dataSource.firstObject rac_sequence]].array;

                self.viewModel.dataSource = @[ viewModels ];

                NSMutableArray *indexPaths = [[NSMutableArray alloc] init];

                [events enumerateObjectsUsingBlock:^(OCTEvent *event, NSUInteger idx, BOOL *stop) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
                    [indexPaths addObject:indexPath];
                }];

                [self.tableView beginUpdates];
                [self.tableView insertRowsAtIndexPaths:indexPaths.copy withRowAnimation:UITableViewRowAnimationFade];
                [self.tableView endUpdates];
            }
        }];

    [[[[NSNotificationCenter defaultCenter]
        rac_addObserverForName:UIApplicationWillEnterForegroundNotification object:nil]
        takeUntil:self.rac_willDeallocSignal]
        subscribeNext:^(id x) {
            @strongify(self)
            [self.viewModel.requestRemoteDataCommand execute:nil];
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
