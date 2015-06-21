//
//  MRCOwnedReposViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCOwnedReposViewController.h"
#import "MRCOwnedReposViewModel.h"
#import "MRCReposTableViewCell.h"
#import "MRCNetworkHeaderView.h"
#import "MRCReposItemViewModel.h"

@interface MRCOwnedReposViewController ()

@property (strong, nonatomic, readonly) MRCOwnedReposViewModel *viewModel;

@end

@implementation MRCOwnedReposViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];    
    
    if (self.viewModel.isCurrentUser) {
        if (self.viewModel.type != MRCReposViewModelTypePublic) {
            self.tableView.contentOffset = CGPointMake(0, -64);
            
            if (self.viewModel.type == MRCReposViewModelTypeOwned || self.viewModel.type == MRCReposViewModelTypeStarred) {
                self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
            } else if (self.viewModel.type == MRCReposViewModelTypeSearch) {
                self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
            }
            
            self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
        }
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCReposTableViewCell" bundle:nil] forCellReuseIdentifier:@"MRCReposTableViewCell"];
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    MRCNetworkHeaderView *networkHeaderView = [NSBundle.mainBundle loadNibNamed:@"MRCNetworkHeaderView" owner:nil options:nil].firstObject;
    networkHeaderView.frame = tableHeaderView.bounds;
    [tableHeaderView addSubview:networkHeaderView];
    
    @weakify(self)
    [RACObserve(MRCSharedAppDelegate, networkStatus) subscribeNext:^(NSNumber *networkStatus) {
        @strongify(self)
        self.tableView.tableHeaderView = (networkStatus.integerValue == NotReachable ? tableHeaderView : nil);
    }];
    
    [self.viewModel.requestRemoteDataCommand.executing subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        if (executing.boolValue && self.viewModel.dataSource == nil) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = self.labelText;
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
}

- (NSString *)labelText {
    return MBPROGRESSHUD_LABEL_TEXT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"MRCReposTableViewCell" forIndexPath:indexPath];
}

- (void)configureCell:(MRCReposTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(MRCReposItemViewModel *)viewModel {
    [cell bindViewModel:viewModel];
}

#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel.dataSource[indexPath.section][indexPath.row] height];
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    MRCReposItemViewModel *viewModel = self.viewModel.dataSource[indexPath.section][indexPath.row];

    @weakify(self)
    void (^handlerStar)(UITableViewRowAction *, NSIndexPath *) = ^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        @strongify(self)
        tableView.editing = false;
        [[[self.viewModel.services client] mrc_starRepository:viewModel.repository] subscribeNext:^(id x) {}];
    };
    
    UITableViewRowAction *starAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                          title:@"Star"
                                                                        handler:handlerStar];
    
    void (^handlerUnstar)(UITableViewRowAction *, NSIndexPath *) = ^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        @strongify(self)
        tableView.editing = false;
        [[[self.viewModel.services client] mrc_unstarRepository:viewModel.repository] subscribeNext:^(id x) {}];
    };
    
    UITableViewRowAction *unstarAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                            title:@"Unstar"
                                                                          handler:handlerUnstar];
    
    if (viewModel.repository.starredStatus == OCTRepositoryStarredStatusYES) {
        return @[ unstarAction ];
    } else {
        return @[ starAction ];
    }
}

@end
