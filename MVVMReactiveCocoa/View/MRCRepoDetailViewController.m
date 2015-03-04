//
//  MRCRepoDetailViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoDetailViewController.h"
#import "MRCRepoStatisticsTableViewCell.h"
#import "MRCRepoViewCodeTableViewCell.h"
#import "MRCRepoReadmeTableViewCell.h"
#import "MRCRepoDetailViewModel.h"
#import "MRCWebViewModel.h"
#import "MRCRepositoryService.h"
#import "MRCDoubleTitleView.h"

@interface MRCRepoDetailViewController ()

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic, readonly) MRCRepoDetailViewModel *viewModel;
@property (strong, nonatomic) DTAttributedLabel *readmeAttributedLabel;

@end

@implementation MRCRepoDetailViewController

- (instancetype)initWithViewModel:(id<MRCViewModelProtocol>)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.estimatedRowHeight = 44;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCRepoStatisticsTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"MRCRepoStatisticsTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCRepoViewCodeTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"MRCRepoViewCodeTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCRepoReadmeTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"MRCRepoReadmeTableViewCell"];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
    [button setTitleColor:HexRGB(colorI2) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    
	[RACObserve(self.viewModel, reference) subscribeNext:^(OCTRef *reference) {
        [button setTitle:[self.viewModel.reference.name componentsSeparatedByString:@"/"].lastObject forState:UIControlStateNormal];
        [button setImage:[UIImage octicon_imageWithIcon:reference.octiconIdentifier backgroundColor:UIColor.clearColor iconColor:HexRGB(colorI2) iconScale:1 andSize:CGSizeMake(22, 22)] forState:UIControlStateNormal];
        [button sizeToFit];
    }];

    button.rac_command = self.viewModel.selectBranchOrTagCommand;
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.toolbar.items = @[ barButtonItem ];
}

- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self)
    [self.viewModel.selectBranchOrTagCommand.executing subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        if (executing.boolValue) {
            if (!self.viewModel.references) [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = @"Loading Branches & Tags...";
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
    
    [RACObserve(self.viewModel, readmeAttributedString) subscribeNext:^(id x) {
        @strongify(self)
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MRCRepoStatisticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MRCRepoStatisticsTableViewCell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [RACObserve(self.viewModel.repository, subscribersCount) subscribeNext:^(NSNumber *subscribersCount) {
            cell.watchLabel.text = subscribersCount.stringValue;
        }];
        [RACObserve(self.viewModel.repository, stargazersCount) subscribeNext:^(NSNumber *stargazersCount) {
            cell.starLabel.text = stargazersCount.stringValue;
        }];
        [RACObserve(self.viewModel.repository, forksCount) subscribeNext:^(NSNumber *forksCount) {
            cell.forkLabel.text = forksCount.stringValue;
        }];
        
        return cell;
    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.numberOfLines = 0;
        
        [RACObserve(self.viewModel.repository, repoDescription) subscribeNext:^(NSString *repoDescription) {
            cell.textLabel.text = repoDescription;
        }];
        
        return cell;
    } else if (indexPath.section == 2) {
        MRCRepoViewCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MRCRepoViewCodeTableViewCell" forIndexPath:indexPath];
        
        [RACObserve(self.viewModel, dateUpdated) subscribeNext:^(NSString *dateUpdated) {
            cell.timeLabel.text = dateUpdated;
        }];
        
        [cell.viewCodeButton setImage:[UIImage octicon_imageWithIdentifier:@"FileDirectory" size:CGSizeMake(22, 22)]
                             forState:UIControlStateNormal];
                
        cell.selectionStyle = UITableViewCellSelectionStyleNone;        
        cell.viewCodeButton.rac_command = self.viewModel.viewCodeCommand;

        return cell;
    } else if (indexPath.section == 3) {
        MRCRepoReadmeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MRCRepoReadmeTableViewCell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.readmeAttributedLabel.numberOfLines = 0;
        cell.readmeAttributedLabel.layoutFrameHeightIsConstrainedByBounds = NO;
        cell.readmeButton.rac_command = self.viewModel.readmeCommand;
        
        [cell.activityIndicatorView startAnimating];
        [self.viewModel.requestRemoteDataCommand.executing subscribeNext:^(NSNumber *executing) {
            cell.activityIndicatorView.hidden = !executing.boolValue;
        }];
        
        self.readmeAttributedLabel = cell.readmeAttributedLabel;
        
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 58;
        case 1:
            return UITableViewAutomaticDimension;
        case 2:
            return 77;
        case 3: {
            self.readmeAttributedLabel.attributedString = [self.viewModel.readmeAttributedString attributedSubstringFromRange:NSMakeRange(0, MIN(self.viewModel.readmeAttributedString.length, 350))];
            return self.viewModel.readmeAttributedString ? 40 + 8 + [self.readmeAttributedLabel suggestedFrameSizeToFitEntireStringConstraintedToWidth:SCREEN_WIDTH - 15*4].height + 8 + 40 : 117;
        }
        default:
            return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1) return 0.01;
    return 7.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) return 0.01;
    return 7.5;
}

@end
