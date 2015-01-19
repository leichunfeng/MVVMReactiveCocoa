//
//  MRCReposTableViewCell.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRCReactiveView.h"

@interface MRCReposTableViewCell : UITableViewCell <MRCReactiveView>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;
@property (weak, nonatomic) IBOutlet UILabel *starCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *forkCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *starIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *forkIconImageView;

@end
