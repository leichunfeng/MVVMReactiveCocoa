//
//  MRCRepoSettingsViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/11.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoSettingsViewController.h"
#import "MRCRepoSettingsViewModel.h"
#import "MRCRepoSettingsOwnerTableViewCell.h"
#import "TGRImageViewController.h"
#import "TGRImageZoomAnimationController.h"

@interface MRCRepoSettingsViewController () <UMSocialUIDelegate, UIViewControllerTransitioningDelegate>

@property (strong, nonatomic, readonly) MRCRepoSettingsViewModel *viewModel;
@property (strong, nonatomic) UIImageView *avatarImageView;

@end

@implementation MRCRepoSettingsViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tintColor = HexRGB(colorI3);
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCRepoSettingsOwnerTableViewCell" bundle:nil] forCellReuseIdentifier:@"MRCRepoSettingsOwnerTableViewCell"];
    
    @weakify(self)
    [[RACObserve(self.viewModel, isStarred) deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self)
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [tableView dequeueReusableCellWithIdentifier:@"MRCRepoSettingsOwnerTableViewCell" forIndexPath:indexPath];
    }
    return [super tableView:tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.hidden = NO;
    
    if (indexPath.section == 0) {
        MRCRepoSettingsOwnerTableViewCell *ownerTableViewCell = (MRCRepoSettingsOwnerTableViewCell *)cell;
        
        self.avatarImageView = ownerTableViewCell.avatarImageView;

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [ownerTableViewCell.avatarImageView setImageWithURL:self.viewModel.repository.ownerAvatarURL
                                           placeholderImage:[UIImage imageNamed:@"default-avatar"]
                                usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        @weakify(self)
        [[ownerTableViewCell.avatarButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            TGRImageViewController *viewController = [[TGRImageViewController alloc] initWithImage:ownerTableViewCell.avatarImageView.image];
            
            viewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            viewController.transitioningDelegate = self;
           
            [self presentViewController:viewController animated:YES completion:NULL];
        }];
        
        ownerTableViewCell.topTextLabel.text = self.viewModel.repository.ownerLogin;
        ownerTableViewCell.bottomTextLabel.text = self.viewModel.repository.name;
    } else if (indexPath.section == 1) {
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
        
        if ([self.viewModel.repository.ownerLogin isEqualToString:[OCTUser mrc_currentUser].login]) {
            cell.hidden = YES;
        }
    } else if (indexPath.section == 2) {
        cell.textLabel.text = @"Share To Friends";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.section == 3) {
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0 || section == 2) ? 1 : 2;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 && [self.viewModel.repository.ownerLogin isEqualToString:[OCTUser mrc_currentUser].login]) {
        return 0.01;
    }
    return section == 0 ? 20 : 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1 && [self.viewModel.repository.ownerLogin isEqualToString:[OCTUser mrc_currentUser].login]) {
        return 0.01;
    }
    return (section == tableView.numberOfSections - 1) ? 20 : 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && [self.viewModel.repository.ownerLogin isEqualToString:[OCTUser mrc_currentUser].login]) {
        return 0;
    }
    return indexPath.section == 0 ? 90 : 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if (indexPath.section == 2) {
        // base property snsName、shareText、shareImage、urlResource
        
        UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:self.viewModel.repository.ownerAvatarURL.absoluteString];
        
        NSString *title = self.viewModel.repository.name;
        NSString *shareText = self.viewModel.repository.repoDescription;
        NSString *url = self.viewModel.repository.HTMLURL.absoluteString;
        
        // Wechat Session
        [UMSocialData defaultData].extConfig.wechatSessionData.urlResource = urlResource;
        [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
        [UMSocialData defaultData].extConfig.wechatSessionData.shareText = shareText;
        [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeApp;
       
        // Wechat Timeline
        [UMSocialData defaultData].extConfig.wechatTimelineData.urlResource = urlResource;
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
        [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = shareText;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
       
        // Wechat Favorite
        [UMSocialData defaultData].extConfig.wechatFavoriteData.urlResource = urlResource;
        [UMSocialData defaultData].extConfig.wechatFavoriteData.title = title;
        [UMSocialData defaultData].extConfig.wechatFavoriteData.shareText = shareText;
        [UMSocialData defaultData].extConfig.wechatFavoriteData.url = url;
       
        // QQ
        [UMSocialData defaultData].extConfig.qqData.urlResource = urlResource;
        [UMSocialData defaultData].extConfig.qqData.title = title;
        [UMSocialData defaultData].extConfig.qqData.shareText = shareText;
        [UMSocialData defaultData].extConfig.qqData.url = url;
       
        // Qzone
        [UMSocialData defaultData].extConfig.qzoneData.urlResource = urlResource;
        [UMSocialData defaultData].extConfig.qzoneData.title = title;
        [UMSocialData defaultData].extConfig.qzoneData.shareText = shareText;
        [UMSocialData defaultData].extConfig.qzoneData.url = url;
       
        // Tencent Weibo
//        [UMSocialData defaultData].extConfig.tencentData.urlResource = urlResource;
//        [UMSocialData defaultData].extConfig.tencentData.title = title;
//        [UMSocialData defaultData].extConfig.tencentData.shareText = shareText;
        
        // Sina Weibo
        [UMSocialData defaultData].extConfig.sinaData.urlResource = urlResource;
        [UMSocialData defaultData].extConfig.sinaData.shareText = [NSString stringWithFormat:@"#%@# %@ %@", title, shareText, url];
        
        NSArray *snsNames = @[ UMShareToWechatSession, UMShareToWechatTimeline, UMShareToWechatFavorite, UMShareToQQ, UMShareToQzone, UMShareToSina ];
        [UMSocialSnsService presentSnsIconSheetView:self appKey:nil shareText:nil shareImage:nil shareToSnsNames:snsNames delegate:self];
    }
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if ([presented isKindOfClass:TGRImageViewController.class]) {
        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:self.avatarImageView];
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if ([dismissed isKindOfClass:TGRImageViewController.class]) {
        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:self.avatarImageView];
    }
    return nil;
}

@end
