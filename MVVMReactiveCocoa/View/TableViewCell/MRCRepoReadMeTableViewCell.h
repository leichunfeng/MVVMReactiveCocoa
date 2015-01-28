//
//  MRCRepoReadMeTableViewCell.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/22.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRCRepoReadMeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *readMeImageView;
@property (weak, nonatomic) IBOutlet UIView *separatorView1;
@property (weak, nonatomic) IBOutlet UIView *separatorView2;
@property (weak, nonatomic) IBOutlet UIButton *readMeButton;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *contentLabel;

@end
