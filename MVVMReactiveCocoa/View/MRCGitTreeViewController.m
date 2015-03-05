//
//  MRCGitTreeViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/29.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCGitTreeViewController.h"
#import "MRCGitTreeViewModel.h"

@interface MRCGitTreeViewController ()

@property (strong, nonatomic, readonly) MRCGitTreeViewModel *viewModel;

@end

@implementation MRCGitTreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    
    if (!self.viewModel.tree) {
        @weakify(self)
        [self.viewModel.requestRemoteDataCommand.executing subscribeNext:^(NSNumber *executing) {
            @strongify(self)
            if (executing.boolValue) {
                if (!self.viewModel.tree) [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = MBPROGRESSHUD_LABEL_TEXT;
            } else {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        }];
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(NSDictionary *)dictionary {
    cell.imageView.image = [UIImage octicon_imageWithIcon:dictionary[@"identifier"]
                                          backgroundColor:UIColor.clearColor
                                                iconColor:HexRGB([dictionary[@"hexRGB"] integerValue])
                                                iconScale:1
                                                  andSize:LEFT_IMAGE_SIZE];
    
    cell.textLabel.text = dictionary[@"text"];
    cell.textLabel.numberOfLines = 0;
    
    cell.detailTextLabel.text = dictionary[@"detailText"];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

@end
