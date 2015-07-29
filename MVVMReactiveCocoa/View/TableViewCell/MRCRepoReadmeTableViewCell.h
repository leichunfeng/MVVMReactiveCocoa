//
//  MRCRepoReadmeTableViewCell.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/22.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRCRepoReadmeTableViewCell : UITableViewCell

@property (weak, nonatomic, readonly) UIButton *readmeButton;
@property (weak, nonatomic, readonly) UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic, readonly) UIWebView *webView;

@end
