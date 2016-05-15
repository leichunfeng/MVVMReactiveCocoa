//
//  MRCSelectBranchOrTagViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/29.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCSelectBranchOrTagViewController.h"
#import "MRCSelectBranchOrTagViewModel.h"

@interface MRCSelectBranchOrTagViewController ()

@property (nonatomic, strong, readonly) MRCSelectBranchOrTagViewModel *viewModel;

@end

@implementation MRCSelectBranchOrTagViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:nil action:NULL];
    @weakify(self)
    leftBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^(id input) {
        @strongify(self)
        [self.viewModel.services dismissViewModelAnimated:YES completion:NULL];
        return [RACSignal empty];
    }];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    self.tableView.tintColor = HexRGB(colorI3);
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSDictionary *dictionary = self.viewModel.dataSource[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage octicon_imageWithIdentifier:dictionary[@"identifier"] size:MRC_LEFT_IMAGE_SIZE];
    cell.textLabel.text  = dictionary[@"name"];
    
    if ([[dictionary[@"reference"] name] isEqualToString:self.viewModel.selectedReference.name]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

@end
