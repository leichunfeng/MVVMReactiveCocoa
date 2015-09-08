//
//  MRCRepoReadmeTableViewCell.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/22.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRCRepoReadmeTableViewCell : UITableViewCell

@property (nonatomic, weak, readonly) UIButton *readmeButton;
@property (nonatomic, weak, readonly) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, weak, readonly) UIWebView *webView;

@end
