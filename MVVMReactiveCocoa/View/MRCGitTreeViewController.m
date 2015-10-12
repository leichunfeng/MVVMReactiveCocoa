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

@property (nonatomic, strong, readonly) MRCGitTreeViewModel *viewModel;

@end

@implementation MRCGitTreeViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
                                          backgroundColor:[UIColor clearColor]
                                                iconColor:HexRGB([dictionary[@"hexRGB"] integerValue])
                                                iconScale:1
                                                  andSize:MRC_LEFT_IMAGE_SIZE];
    
    cell.textLabel.text = dictionary[@"text"];
    
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.text = dictionary[@"detailText"];
    detailLabel.textColor = HexRGB(0x8E8E93);
    [detailLabel sizeToFit];
    
    cell.accessoryView = detailLabel;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

@end
