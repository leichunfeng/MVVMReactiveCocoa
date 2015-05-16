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

@property (weak, nonatomic) IBOutlet UIImageView *starIconImageView;

@end
