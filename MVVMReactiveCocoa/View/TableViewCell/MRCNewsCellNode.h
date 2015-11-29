//
//  MRCNewsCellNode.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/11/29.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import "ASCellNode.h"
#import "MRCNewsItemViewModel.h"

@interface MRCNewsCellNode : ASCellNode

- (instancetype)initWithViewModel:(MRCNewsItemViewModel *)viewModel;

@end
