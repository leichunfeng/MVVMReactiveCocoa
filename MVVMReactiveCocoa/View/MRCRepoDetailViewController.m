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

@interface MRCRepoDetailViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic, readonly) MRCRepoDetailViewModel *viewModel;
@property (strong, nonatomic) MRCRepoReadmeTableViewCell *readmeTableViewCell;

@end

@implementation MRCRepoDetailViewController

@dynamic viewModel;

- (instancetype)initWithViewModel:(id<MRCViewModelProtocol>)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCRepoStatisticsTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"MRCRepoStatisticsTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCRepoViewCodeTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"MRCRepoViewCodeTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCRepoReadmeTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"MRCRepoReadmeTableViewCell"];
    
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.estimatedRowHeight = 44;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
    [button setTitleColor:HexRGB(colorI2) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    @weakify(self)
	[RACObserve(self.viewModel, reference) subscribeNext:^(OCTRef *reference) {
        @strongify(self)
        [button setTitle:[self.viewModel.reference.name componentsSeparatedByString:@"/"].lastObject forState:UIControlStateNormal];
        [button setImage:[UIImage octicon_imageWithIcon:reference.octiconIdentifier backgroundColor:UIColor.clearColor iconColor:HexRGB(colorI2) iconScale:1 andSize:CGSizeMake(23, 23)] forState:UIControlStateNormal];
        [button sizeToFit];
    }];

    button.rac_command = self.viewModel.selectBranchOrTagCommand;
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.toolbar.items = @[ barButtonItem ];
}

- (MRCRepoReadmeTableViewCell *)readmeTableViewCell {
    if (_readmeTableViewCell == nil) {
        _readmeTableViewCell = [[NSBundle mainBundle] loadNibNamed:@"MRCRepoReadmeTableViewCell" owner:nil options:nil].firstObject;
        _readmeTableViewCell.webView.hidden = YES;
    }
    return _readmeTableViewCell;
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
    
    [[[RACObserve(self.viewModel, summaryReadmeHTMLString)
        filter:^BOOL(NSString *summaryReadmeHTMLString) {
            return summaryReadmeHTMLString != nil;
        }]
        distinctUntilChanged]
        subscribeNext:^(NSString *summaryReadmeHTMLString) {
            @strongify(self)
            [self.readmeTableViewCell.webView loadHTMLString:summaryReadmeHTMLString baseURL:nil];
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
        MRCRepoReadmeTableViewCell *cell = self.readmeTableViewCell;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.readmeButton.rac_command = self.viewModel.readmeCommand;
        
        cell.webView.userInteractionEnabled = NO;
        cell.webView.scrollView.scrollEnabled = NO;
        cell.webView.delegate = self;
        
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
        case 3:
            return 40 + CGRectGetHeight(self.readmeTableViewCell.webView.frame) + 40;
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
    if (section == 3) return 15;
    return 7.5;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.readmeTableViewCell.activityIndicatorView.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.readmeTableViewCell.activityIndicatorView.hidden = YES;
    webView.hidden = NO;
    
    CGRect webViewFrame = webView.frame;
    webViewFrame.size.height = webView.scrollView.contentSize.height + 3;
    webView.frame = webViewFrame;
    
    [self.tableView reloadData];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
   self.readmeTableViewCell.activityIndicatorView.hidden = YES;
}

- (void)dealloc {
    self.readmeTableViewCell.webView.delegate = nil;
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

@end
