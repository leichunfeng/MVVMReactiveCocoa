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

@property (nonatomic, strong, readonly) MRCUserDetailViewModel *viewModel;

@end

@implementation MRCUserDetailViewController

@dynamic viewModel;

- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsZero;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 4;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"MRCTableViewCellStyleValue1" forIndexPath:indexPath];
    
    cell.accessoryType  = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage octicon_imageWithIcon:@"Person"
                                                  backgroundColor:UIColor.clearColor
                                                        iconColor:HexRGB(0x24AFFC)
                                                        iconScale:1
                                                          andSize:MRC_LEFT_IMAGE_SIZE];
            
            cell.textLabel.text = @"Name";
            cell.detailTextLabel.text = self.viewModel.user.name;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else if (indexPath.row == 1) {
            cell.imageView.image = [UIImage octicon_imageWithIcon:@"Star"
                                                  backgroundColor:UIColor.clearColor
                                                        iconColor:HexRGB(colorI3)
                                                        iconScale:1
                                                          andSize:MRC_LEFT_IMAGE_SIZE];
            cell.textLabel.text = @"Starred Repos";
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 2) {
            cell.imageView.image = [UIImage octicon_imageWithIcon:@"Rss"
                                                  backgroundColor:UIColor.clearColor
                                                        iconColor:HexRGB(0x4078c0)
                                                        iconScale:1
                                                          andSize:MRC_LEFT_IMAGE_SIZE];
            cell.textLabel.text = @"Public Activity";

            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage octicon_imageWithIcon:@"Organization"
                                                  backgroundColor:UIColor.clearColor
                                                        iconColor:HexRGB(0x24AFFC)
                                                        iconScale:1
                                                          andSize:MRC_LEFT_IMAGE_SIZE];
            cell.textLabel.text = self.viewModel.company;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else if (indexPath.row == 1) {
            cell.imageView.image = [UIImage octicon_imageWithIcon:@"Location"
                                                  backgroundColor:UIColor.clearColor
                                                        iconColor:HexRGB(0x30C931)
                                                        iconScale:1
                                                          andSize:MRC_LEFT_IMAGE_SIZE];
            cell.textLabel.text = self.viewModel.location;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else if (indexPath.row == 2) {
            cell.imageView.image = [UIImage octicon_imageWithIcon:@"Mail"
                                                  backgroundColor:UIColor.clearColor
                                                        iconColor:HexRGB(0x5586ED)
                                                        iconScale:1
                                                          andSize:MRC_LEFT_IMAGE_SIZE];
            cell.textLabel.text = self.viewModel.email;
            
            if ([self.viewModel.email isEqualToString:MRC_EMPTY_PLACEHOLDER]) {
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            } else {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        } else if (indexPath.row == 3) {
            cell.imageView.image = [UIImage octicon_imageWithIcon:@"Link"
                                                  backgroundColor:UIColor.clearColor
                                                        iconColor:HexRGB(0x90DD2F)
                                                        iconScale:1
                                                          andSize:MRC_LEFT_IMAGE_SIZE];
            cell.textLabel.text = self.viewModel.blog;
            
            if ([self.viewModel.blog isEqualToString:MRC_EMPTY_PLACEHOLDER]) {
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            } else {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        if (indexPath.row == 2) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", self.viewModel.email]]];
        } else if (indexPath.row == 3) {
            [UIApplication.sharedApplication openURL:[NSURL URLWithString:self.viewModel.blog]];
        }
    } else {
        [self.viewModel.didSelectCommand execute:indexPath];
    }
}

@end
