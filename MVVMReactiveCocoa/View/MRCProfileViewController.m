//
//  MRCProfileViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCProfileViewController.h"
#import "MRCProfileViewModel.h"
#import "MRCAvatarHeaderView.h"
#import "MRCAvatarHeaderViewModel.h"

@interface MRCProfileViewController ()

@property (strong, nonatomic, readonly) MRCProfileViewModel *viewModel;

@end

@implementation MRCProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MRCAvatarHeaderView *avatarHeaderView = [[NSBundle mainBundle] loadNibNamed:@"MRCAvatarHeaderView" owner:nil options:nil].firstObject;
    [avatarHeaderView bindViewModel:self.viewModel.avatarHeaderViewModel];
    self.tableView.tableHeaderView = avatarHeaderView;
}

- (void)bindViewModel {
    [super bindViewModel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    @weakify(self)
    [[self.viewModel.services.client fetchUserInfo] subscribeNext:^(OCTUser *user) {
    	@strongify(self)
        OCTUser *currentUser = OCTUser.currentUser;
        [currentUser mergeValuesForKeysFromModel:user];
        [currentUser save];
        self.viewModel.currentUser = currentUser;
    } error:^(NSError *error) {
        [self.viewModel.errors sendNext:error];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y + 64);
    self.viewModel.avatarHeaderViewModel.contentOffset = contentOffset;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text  = self.viewModel.dataSource[indexPath.section][indexPath.row][@"title"];
    cell.accessoryType   = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage octicon_imageWithIdentifier:self.viewModel.dataSource[indexPath.section][indexPath.row][@"identifier"]
                                                           size:CGSizeMake(22, 22)];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
