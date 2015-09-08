//
//  MRCRepoStatisticsTableViewCell.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/22.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRCRepoStatisticsTableViewCell : UITableViewCell

@property (nonatomic, weak, readonly) UILabel *watchLabel;
@property (nonatomic, weak, readonly) UILabel *starLabel;
@property (nonatomic, weak, readonly) UILabel *forkLabel;

@end
