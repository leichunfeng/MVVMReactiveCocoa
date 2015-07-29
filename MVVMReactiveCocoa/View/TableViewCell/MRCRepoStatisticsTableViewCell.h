//
//  MRCRepoStatisticsTableViewCell.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/22.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRCRepoStatisticsTableViewCell : UITableViewCell

@property (weak, nonatomic, readonly) UILabel *watchLabel;
@property (weak, nonatomic, readonly) UILabel *starLabel;
@property (weak, nonatomic, readonly) UILabel *forkLabel;

@end
