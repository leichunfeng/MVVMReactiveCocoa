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
#import "MRCNewsTableViewCell.h"

@interface MRCNewsViewController ()

@property (nonatomic, strong, readonly) MRCNewsViewModel *viewModel;

@end

@implementation MRCNewsViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    [[[RACSignal
        combineLatest:@[ self.viewModel.requestRemoteDataCommand.executing, RACObserve(self.viewModel, dataSource) ]
        reduce:^(NSNumber *executing, NSArray *dataSource) {
            return @(executing.boolValue && dataSource.count == 0);
        }]
        deliverOnMainThread]
        subscribeNext:^(NSNumber *showHUD) {
            @strongify(self)
            if (showHUD.boolValue) {
                [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = MBPROGRESSHUD_LABEL_TEXT;
            } else {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        }];
    
    [[[RACObserve(self.viewModel, events)
        filter:^(NSArray *events) {
            return @(events.count > 0).boolValue;
        }]
        deliverOn:[RACScheduler scheduler]]
        subscribeNext:^(NSArray *events) {
            @strongify(self)
            
            if (self.viewModel.dataSource == nil) {
                self.viewModel.dataSource = @[ [self viewModelsWithEvents:events] ];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            } else {
                NSMutableArray *viewModels = [[NSMutableArray alloc] init];
                
                [viewModels addObjectsFromArray:[self viewModelsWithEvents:events]];
                [viewModels addObjectsFromArray:self.viewModel.dataSource.firstObject];

                self.viewModel.dataSource = @[ viewModels.copy ];

                NSMutableArray *indexPaths = [[NSMutableArray alloc] init];

                [events enumerateObjectsUsingBlock:^(OCTEvent *event, NSUInteger idx, BOOL *stop) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
                    [indexPaths addObject:indexPath];
                }];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView beginUpdates];
                    [self.tableView insertRowsAtIndexPaths:indexPaths.copy withRowAnimation:UITableViewRowAnimationFade];
                    [self.tableView endUpdates];
                });
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

- (void)reloadData {}

- (UIEdgeInsets)contentInset {
    return self.viewModel.type == MRCNewsViewModelTypeNews ? UIEdgeInsetsMake(64, 0, 49, 0) : [super contentInset];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    MRCNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MRCNewsTableViewCell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MRCNewsTableViewCell" owner:nil options:nil].firstObject;
    }
    return cell;
}

- (void)configureCell:(MRCNewsTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(MRCNewsItemViewModel *)viewModel {
    [cell bindViewModel:viewModel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MRCNewsItemViewModel *viewModel = self.viewModel.dataSource[indexPath.section][indexPath.row];
    return viewModel.height;
}

- (NSArray *)viewModelsWithEvents:(NSArray *)events {
    return [events.rac_sequence map:^(OCTEvent *event) {
        MRCNewsItemViewModel *viewModel = [[MRCNewsItemViewModel alloc] initWithEvent:event];
        viewModel.didClickLinkCommand = self.viewModel.didClickLinkCommand;
        return viewModel;
    }].array;
}

@end
