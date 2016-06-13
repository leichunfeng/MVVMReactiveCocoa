//
//  MRCNewsItemViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/5.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRCNewsItemViewModel : NSObject

@property (nonatomic, strong, readonly) OCTEvent *event;
@property (nonatomic, copy, readonly) NSAttributedString *attributedString;

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) RACCommand *didClickLinkCommand;
@property (nonatomic, strong) YYTextLayout *textLayout;

- (instancetype)initWithEvent:(OCTEvent *)event;

@end
