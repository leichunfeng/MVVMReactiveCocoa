//
//  MRCSelectBranchViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/29.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCSelectBranchViewController.h"
#import "MRCSelectBranchViewModel.h"

@interface MRCSelectBranchViewController ()

@property (strong, nonatomic, readonly) MRCSelectBranchViewModel *viewModel;

@end

@implementation MRCSelectBranchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:nil action:NULL];
    @weakify(self)
    leftBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        [self.viewModel.services dismissViewModelAnimated:YES completion:NULL];
        return [RACSignal empty];
    }];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSDictionary *dictionary = self.viewModel.dataSource[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage octicon_imageWithIdentifier:dictionary[@"identifier"] size:CGSizeMake(29, 29)];
    cell.textLabel.text  = dictionary[@"name"];
    
    return cell;
}

@end
