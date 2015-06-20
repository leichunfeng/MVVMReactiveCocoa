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
@property (strong, nonatomic) RACSignal *webViewExecuting;

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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:nil
                                                                             action:NULL];
    self.navigationItem.rightBarButtonItem.rac_command = self.viewModel.rightBarButtonItemCommand;
}

- (MRCRepoReadmeTableViewCell *)readmeTableViewCell {
    if (_readmeTableViewCell == nil) {
        _readmeTableViewCell = [[NSBundle mainBundle] loadNibNamed:@"MRCRepoReadmeTableViewCell" owner:nil options:nil].firstObject;
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
        ignore:nil]
        deliverOnMainThread]
        subscribeNext:^(NSString *summaryReadmeHTMLString) {
            @strongify(self)
            [self.readmeTableViewCell.webView loadHTMLString:summaryReadmeHTMLString baseURL:nil];
        }];
    
    // UIWebViewDelegate
    RACSignal *startLoadSignal  = [self rac_signalForSelector:@selector(webViewDidStartLoad:) fromProtocol:@protocol(UIWebViewDelegate)];
    RACSignal *finishLoadSignal = [self rac_signalForSelector:@selector(webViewDidFinishLoad:) fromProtocol:@protocol(UIWebViewDelegate)];
    RACSignal *failLoadSignal   = [self rac_signalForSelector:@selector(webView:didFailLoadWithError:) fromProtocol:@protocol(UIWebViewDelegate)];
   
    self.readmeTableViewCell.webView.delegate = self;
    
    // webView hidden or not
    RAC(self.readmeTableViewCell.webView, hidden) = [[[finishLoadSignal mapReplace:@NO] distinctUntilChanged] startWith:@YES];
    
    // once `webViewDidFinishLoad:` reload table
    [finishLoadSignal subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
        UIWebView *webView = tuple.first;
        
        CGRect webViewFrame = webView.frame;
        webViewFrame.size.height = webView.scrollView.contentSize.height + 3;
        webView.frame = webViewFrame;
        
        [self.tableView reloadData];
    }];
    
    self.webViewExecuting = [[RACSignal
        createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [[startLoadSignal mapReplace:@YES] subscribe:subscriber];
            [[[RACSignal merge:@[ finishLoadSignal, failLoadSignal ]] mapReplace:@NO] subscribe:subscriber];
            return nil;
        }]
        startWith:@NO];
    
    RAC(self.readmeTableViewCell.activityIndicatorView, hidden) = [RACSignal
        combineLatest:@[ self.viewModel.requestRemoteDataCommand.executing, self.webViewExecuting ]
        reduce:^id(NSNumber *reqExecuting, NSNumber *webViewExecuting) {
            return @(!reqExecuting.boolValue && !webViewExecuting.boolValue);
        }];
    
    [RACObserve(self.viewModel, repository) subscribeNext:^(id x) {
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
        cell.watchLabel.text = @(self.viewModel.repository.subscribersCount).stringValue;
        cell.starLabel.text  = @(self.viewModel.repository.stargazersCount).stringValue;
        cell.forkLabel.text  = @(self.viewModel.repository.forksCount).stringValue;
        
        return cell;
    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = self.viewModel.repository.repoDescription;
        
        return cell;
    } else if (indexPath.section == 2) {
        MRCRepoViewCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MRCRepoViewCodeTableViewCell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.timeLabel.text = self.viewModel.dateUpdated;
        
        [cell.viewCodeButton setImage:[UIImage octicon_imageWithIdentifier:@"FileDirectory" size:CGSizeMake(22, 22)]
                             forState:UIControlStateNormal];
        cell.viewCodeButton.rac_command = self.viewModel.viewCodeCommand;

        return cell;
    } else if (indexPath.section == 3) {
        MRCRepoReadmeTableViewCell *cell = self.readmeTableViewCell;
        
        cell.readmeButton.rac_command = self.viewModel.readmeCommand;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.webView.userInteractionEnabled = NO;
        cell.webView.scrollView.scrollEnabled = NO;
        
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

- (void)dealloc {
    self.readmeTableViewCell.webView.delegate = nil;
}

@end
