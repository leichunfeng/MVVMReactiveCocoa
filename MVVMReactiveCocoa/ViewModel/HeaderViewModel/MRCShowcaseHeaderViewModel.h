//
//  MRCShowcaseHeaderViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/4/24.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRCShowcaseHeaderViewModel : NSObject

@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign, readonly) CGFloat height;

@end
