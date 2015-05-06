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
@property (strong, nonatomic) MRCAvatarHeaderView *tableHeaderView;

@end

@implementation MRCProfileViewController

@dynamic viewModel;

- (instancetype)initWithViewModel:(id<MRCViewModelProtocol>)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableHeaderView = [[NSBundle mainBundle] loadNibNamed:@"MRCAvatarHeaderView" owner:nil options:nil].firstObject;
    [self.tableHeaderView bindViewModel:self.viewModel.avatarHeaderViewModel];
    self.tableView.tableHeaderView = self.tableHeaderView;
    
    [self.viewModel.fetchUserInfoCommand execute:nil];
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
    
    NSDictionary *dictionary = self.viewModel.dataSource[indexPath.section][indexPath.row];
    
    cell.imageView.image = [UIImage octicon_imageWithIcon:dictionary[@"identifier"]
                                          backgroundColor:UIColor.clearColor
                                                iconColor:HexRGB([dictionary[@"hexRGB"] integerValue])
                                                iconScale:1
                                                  andSize:LEFT_IMAGE_SIZE];
    
    [self.viewModel.dataSource[indexPath.section][indexPath.row][@"textSignal"] subscribeNext:^(NSString *text) {
        cell.textLabel.text = text;
    }];
    
    cell.accessoryType  = indexPath.section == 0 ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = indexPath.section == 0 ? UITableViewCellSelectionStyleNone : UITableViewCellSelectionStyleDefault;
    
    return cell;
}

@end
