//
//  MRCRepoSettingsViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/11.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoSettingsViewController.h"
#import "MRCRepoSettingsViewModel.h"

@interface MRCRepoSettingsViewController ()

@property (strong, nonatomic, readonly) MRCRepoSettingsViewModel *viewModel;

@end

@implementation MRCRepoSettingsViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tintColor = HexRGB(colorI3);
    
    @weakify(self)
    [[RACObserve(self.viewModel, isStarred) deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self)
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage octicon_imageWithIcon:@"Star"
                                              backgroundColor:[UIColor clearColor]
                                                    iconColor:HexRGB(colorI3)
                                                    iconScale:1
                                                      andSize:MRC_LEFT_IMAGE_SIZE];
        cell.textLabel.text = @"Star";
        cell.accessoryType  = self.viewModel.isStarred ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    } else if (indexPath.row == 1) {
        cell.imageView.image = [UIImage octicon_imageWithIcon:@"Star"
                                              backgroundColor:[UIColor clearColor]
                                                    iconColor:[UIColor lightGrayColor]
                                                    iconScale:1
                                                      andSize:MRC_LEFT_IMAGE_SIZE];
        cell.textLabel.text = @"Unstar";
        cell.accessoryType  = !self.viewModel.isStarred ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

@end
