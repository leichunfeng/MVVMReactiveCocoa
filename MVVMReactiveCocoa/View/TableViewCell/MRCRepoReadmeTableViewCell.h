//
//  MRCRepoReadmeTableViewCell.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/22.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRCRepoReadmeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *readmeButton;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *readmeAttributedLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end
