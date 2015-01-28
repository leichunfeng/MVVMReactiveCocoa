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
#import "MRCRepoReadMeTableViewCell.h"
#import "MRCRepoDetailViewModel.h"
#import "MRCWebViewModel.h"
#import "MRCRepoReadMeViewModel.h"
#import "MRCRepositoryService.h"

@interface MRCRepoDetailViewController ()

@property (strong, nonatomic, readonly) MRCRepoDetailViewModel *viewModel;
@property (strong, nonatomic) NSAttributedString *attributedString;

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
    self.tableView.backgroundColor = [UIColor whiteColor];
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCRepoStatisticsTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"MRCRepoStatisticsTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCRepoViewCodeTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"MRCRepoViewCodeTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MRCRepoReadMeTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"MRCRepoReadMeTableViewCell"];
    
    @weakify(self)
    [[[self.viewModel.services getRepositoryService]
      	requestRepositoryReadmeRenderedHTML:self.viewModel.repository]
     	subscribeNext:^(NSString *htmlString) {
    		@strongify(self)
         	self.attributedString = [self attributedStringFromHTMLString:htmlString];
            [self.tableView reloadData];
     	}];
}

- (NSAttributedString *)attributedStringFromHTMLString:(NSString *)htmlString {
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    // example for setting a willFlushCallback, that gets called before elements are written to the generated attributed string
    void (^callBackBlock)(DTHTMLElement *element) = ^(DTHTMLElement *element) {
        // the block is being called for an entire paragraph, so we check the individual elements
        for (DTHTMLElement *oneChildElement in element.childNodes) {
            // if an element is larger than twice the font size put it in it's own block
            if (oneChildElement.displayStyle == DTHTMLElementDisplayStyleInline && oneChildElement.textAttachment.displaySize.height > 2.0 * oneChildElement.fontDescriptor.pointSize) {
                oneChildElement.displayStyle = DTHTMLElementDisplayStyleBlock;
                oneChildElement.paragraphStyle.minimumLineHeight = element.textAttachment.displaySize.height;
                oneChildElement.paragraphStyle.maximumLineHeight = element.textAttachment.displaySize.height;
            }
        }
    };
    
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:@1, NSTextSizeMultiplierDocumentOption, @"Times New Roman", DTDefaultFontFamily, @"purple", DTDefaultLinkColor, @"red", DTDefaultLinkHighlightColor, callBackBlock, DTWillFlushBlockCallBack, @17, DTDefaultFontSize, nil];
    
    NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
    
    return string;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 1;
        default:
            return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MRCRepoStatisticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MRCRepoStatisticsTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addTopBorderWithHeight:0.5 andColor:HexRGB(colorB2)];
        [cell addBottomBorderWithHeight:0.5 andColor:HexRGB(colorB2)];
        return cell;
    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        cell.textLabel.text = @"GitHub API client for Objective-C";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 2) {
        MRCRepoViewCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MRCRepoViewCodeTableViewCell" forIndexPath:indexPath];
        [cell.viewCodeButton setImage:[UIImage octicon_imageWithIdentifier:@"FileDirectory" size:CGSizeMake(22, 22)]
                             forState:UIControlStateNormal];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 3) {
        MRCRepoReadMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MRCRepoReadMeTableViewCell" forIndexPath:indexPath];
        cell.readMeImageView.image = [UIImage octicon_imageWithIdentifier:@"Book" size:CGSizeMake(22, 22)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.contentLabel.text = @"jfjdslfjdslfjsdlfjdksljfjdslfkdsjfldsjflsdfjklsdfjskldfjskldfjskldfjksldfjksldfjklsfjlskdfjksldfnsldfnslkdfnsdklfnslkdfnsdklfnslkdfnsklnfklsnfksndfklsndflksdnfklsnfeoijfioehfuohkkfdsklfdjsklfjdsklfsdjklfjslkdfjlskafjklasnflkdsnk";
        cell.contentLabel.numberOfLines = 0;
        cell.contentLabel.attributedString = self.attributedString;
        [cell.contentLabel sizeToFit];
        @weakify(self)
        cell.readMeButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            MRCRepoReadMeViewModel *readMeViewModel = [[MRCRepoReadMeViewModel alloc] initWithServices:self.viewModel.services
                                                                                                params:@{@"repository": self.viewModel.repository}];
            [self.viewModel.services pushViewModel:readMeViewModel animated:YES];
            return [RACSignal empty];
        }];
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
            return 44;
        case 2:
            return 77;
        case 3:
            return UITableViewAutomaticDimension;
        default:
            return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    } else if (section == 1) {
        return 0.01;
    }
    return 7.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 0.01;
    }
    return 7.5;
}

@end
