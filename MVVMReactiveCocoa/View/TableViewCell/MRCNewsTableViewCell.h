//
//  MRCNewsTableViewCell.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/5.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRCNewsItemViewModel.h"

@interface MRCNewsTableViewCell : UITableViewCell <MRCReactiveView>

+ (CGFloat)heightWithViewModel:(MRCNewsItemViewModel *)viewModel;

@end
