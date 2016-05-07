//
//  MRCLanguageViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/4/24.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCTableViewModel.h"

@interface MRCLanguageViewModel : MRCTableViewModel

@property (nonatomic, copy) NSDictionary *item;

- (NSString *)resourceName;

@end
