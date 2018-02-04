//
//  MRCReposSearchResultsViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCReposSearchResultsViewController.h"
#import "MRCReposSearchResultsViewModel.h"
#import "MRCReposTableViewCell.h"
#import "MRCReposSearchResultsItemViewModel.h"

@interface MRCReposSearchResultsViewController ()

@property (nonatomic, strong, readonly) MRCReposSearchResultsViewModel *viewModel;

@end

@implementation MRCReposSearchResultsViewController

@dynamic viewModel;

- (NSString *)labelText {
    return @"Searching";
}

- (UIEdgeInsets)contentInset {
    CGFloat top = 0;
    
    top += iPhoneX ? 88 : 64;
    
    if (IOS11) {
        top += 12;
    }
    
    CGFloat bottom = iPhoneX ? 83 : 49;
    
    return UIEdgeInsetsMake(top, 0, bottom, 0);
}

#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return [[NSAttributedString alloc] initWithString:@"No Results"];
}

@end
