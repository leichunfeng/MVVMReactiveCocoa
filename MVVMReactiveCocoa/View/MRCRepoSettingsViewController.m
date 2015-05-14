//
//  MRCRepoSettingsViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/11.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoSettingsViewController.h"
#import "MRCRepoSettingsViewModel.h"

@interface MRCRepoSettingsViewController ()

@property (strong, nonatomic, readonly) MRCRepoSettingsViewModel *viewModel;

@end

@implementation MRCRepoSettingsViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tintColor = HexRGB(colorI3);
    
    @weakify(self)
    [[RACObserve(self.viewModel, isStarred) deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self)
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage octicon_imageWithIcon:@"Star"
                                                  backgroundColor:[UIColor clearColor]
                                                        iconColor:HexRGB(colorI3)
                                                        iconScale:1
                                                          andSize:MRC_LEFT_IMAGE_SIZE];
            cell.textLabel.text = @"Star";
            cell.accessoryType  = self.viewModel.isStarred ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        } else if (indexPath.row == 1) {
            cell.imageView.image = [UIImage octicon_imageWithIcon:@"Star"
                                                  backgroundColor:[UIColor clearColor]
                                                        iconColor:[UIColor lightGrayColor]
                                                        iconScale:1
                                                          andSize:MRC_LEFT_IMAGE_SIZE];
            cell.textLabel.text = @"Unstar";
            cell.accessoryType  = !self.viewModel.isStarred ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        }
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"Share To Friends";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.section == 2) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Watchers Count";
            cell.detailTextLabel.text = [@(self.viewModel.repository.watchersCount) stringValue];
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"Open Issues Count";
            cell.detailTextLabel.text = [@(self.viewModel.repository.openIssuesCount) stringValue];
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 1 ? 1 : 2;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 20 : 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return (section == tableView.numberOfSections - 1) ? 20 : 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if (indexPath.section == 1) {
        [UMSocialData defaultData].extConfig.wechatSessionData.title = self.viewModel.repository.name;
        [UMSocialData defaultData].extConfig.wechatSessionData.shareText = self.viewModel.repository.repoDescription;
        [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeApp;
       
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = self.viewModel.repository.name;
        [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = self.viewModel.repository.repoDescription;
        [UMSocialData defaultData].extConfig.wechatTimelineData.shareImage = [UIImage imageNamed:@"icon320"];
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.viewModel.repository.HTMLURL.absoluteString;
       
        [UMSocialData defaultData].extConfig.wechatFavoriteData.title = self.viewModel.repository.name;
        [UMSocialData defaultData].extConfig.wechatFavoriteData.shareText = self.viewModel.repository.repoDescription;
        [UMSocialData defaultData].extConfig.wechatFavoriteData.shareImage = [UIImage imageNamed:@"icon320"];
        [UMSocialData defaultData].extConfig.wechatFavoriteData.url = self.viewModel.repository.HTMLURL.absoluteString;
       
        [UMSocialData defaultData].extConfig.qqData.title = self.viewModel.repository.name;
        [UMSocialData defaultData].extConfig.qqData.shareText = self.viewModel.repository.repoDescription;
        [UMSocialData defaultData].extConfig.qqData.url = self.viewModel.repository.HTMLURL.absoluteString;
        
        [UMSocialData defaultData].extConfig.sinaData.urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:self.viewModel.repository.HTMLURL.absoluteString];
        [UMSocialData defaultData].extConfig.sinaData.shareText = [self.viewModel.repository.repoDescription stringByAppendingString:self.viewModel.repository.HTMLURL.absoluteString];
        
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:nil
                                          shareText:nil
                                         shareImage:nil
                                    shareToSnsNames:@[ UMShareToWechatSession, UMShareToWechatTimeline, UMShareToWechatFavorite, UMShareToQQ, UMShareToQzone, UMShareToTencent, UMShareToSina ]
                                           delegate:nil];
    }
}

@end
