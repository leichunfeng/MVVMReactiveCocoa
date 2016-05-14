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
#import "SDWebImagePrefetcher.h"

@interface MRCProfileViewController ()

@property (nonatomic, strong, readonly) MRCProfileViewModel *viewModel;
@property (nonatomic, strong) MRCAvatarHeaderView *tableHeaderView;

@end

@implementation MRCProfileViewController

@dynamic viewModel;

- (instancetype)initWithViewModel:(MRCViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        if (self.viewModel.avatarHeaderViewModel.user.avatarURL) {
            SDWebImagePrefetcher *imagePrefetcher = [SDWebImagePrefetcher sharedImagePrefetcher];
            imagePrefetcher.options = SDWebImageRefreshCached;
            [imagePrefetcher prefetchURLs:@[ self.viewModel.avatarHeaderViewModel.user.avatarURL ?: [NSNull null] ]];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableHeaderView = [[NSBundle mainBundle] loadNibNamed:@"MRCAvatarHeaderView" owner:nil options:nil].firstObject;
    [self.tableHeaderView bindViewModel:self.viewModel.avatarHeaderViewModel];
    self.tableView.tableHeaderView = self.tableHeaderView;
    
    @weakify(self)
    [RACObserve(self.viewModel, user) subscribeNext:^(id x) {
        @strongify(self)
        [self.tableView reloadData];
    }];
}

- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(0, 0, 49, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y);
    self.viewModel.avatarHeaderViewModel.contentOffset = contentOffset;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return section == 0 ? 4 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"MRCTableViewCellStyleValue1" forIndexPath:indexPath];
    
    cell.accessoryType  = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                             
    if (indexPath.section == 0) {
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
    } else if (indexPath.section == 1) {
        cell.imageView.image = [UIImage octicon_imageWithIcon:@"Gear"
                                              backgroundColor:UIColor.clearColor
                                                    iconColor:HexRGB(0x24AFFC)
                                                    iconScale:1
                                                      andSize:MRC_LEFT_IMAGE_SIZE];
        cell.textLabel.text = @"Settings";
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 20 : 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return (section == tableView.numberOfSections - 1) ? 20 : 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", self.viewModel.email]]];
        } else if (indexPath.row == 3) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.viewModel.blog]];
        }
    } else {
        [self.viewModel.didSelectCommand execute:indexPath];
    }
}

@end
