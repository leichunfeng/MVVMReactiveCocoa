//
//  MRCAboutViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/3/4.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCAboutViewController.h"
#import "MRCAboutHeaderView.h"
#import "MRCAboutViewModel.h"

@interface MRCAboutViewController ()

@property (strong, nonatomic, readonly) MRCAboutViewModel *viewModel;

@end

@implementation MRCAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 112)];
    MRCAboutHeaderView *aboutHeaderView = [NSBundle.mainBundle loadNibNamed:@"MRCAboutHeaderView" owner:nil options:nil].firstObject;
    aboutHeaderView.frame = tableHeaderView.bounds;
    [tableHeaderView addSubview:aboutHeaderView];
    
    self.tableView.tableHeaderView = tableHeaderView;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    cell.textLabel.text = @"Rate iGitHub";
    cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
}

#pragma mark - UITalbeViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

@end
