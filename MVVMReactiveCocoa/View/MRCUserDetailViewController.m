//
//  MRCUserDetailViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/16.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCUserDetailViewController.h"
#import "MRCUserDetailViewModel.h"

@interface MRCUserDetailViewController ()

@property (strong, nonatomic, readonly) MRCUserDetailViewModel *viewModel;

@end

@implementation MRCUserDetailViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
    self.tableView.contentInset = UIEdgeInsetsMake(-44, 0, 0, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y - 44);
    self.viewModel.avatarHeaderViewModel.contentOffset = contentOffset;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 2 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"MRCTableViewCellStyleValue1" forIndexPath:indexPath];
    
    if (indexPath.section == 2) {
        cell.textLabel.text = @"Name";
        [RACObserve(self.viewModel.user, name) subscribeNext:^(NSString *name) {
            cell.detailTextLabel.text = name;
        }];
    } else if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage octicon_imageWithIcon:@"Person"
                                                  backgroundColor:[UIColor clearColor]
                                                        iconColor:HexRGB(colorI3)
                                                        iconScale:1
                                                          andSize:MRC_LEFT_IMAGE_SIZE];
            cell.textLabel.text = @"Follow";
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"Unfollow";
            cell.imageView.image = [UIImage octicon_imageWithIcon:@"Person"
                                                  backgroundColor:[UIColor clearColor]
                                                        iconColor:[UIColor lightGrayColor]
                                                        iconScale:1
                                                          andSize:MRC_LEFT_IMAGE_SIZE];
        }
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"Starred Repos";
    }
    
    return cell;
}

@end
