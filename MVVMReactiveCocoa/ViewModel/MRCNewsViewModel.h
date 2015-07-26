//
//  MRCNewsViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCTableViewModel.h"

typedef NS_ENUM(NSUInteger, MRCNewsViewModelType) {
    MRCNewsViewModelTypeNews,
    MRCNewsViewModelTypePublicActivity
};

@interface MRCNewsViewModel : MRCTableViewModel

@property (assign, nonatomic, readonly) BOOL isCurrentUser;
@property (assign, nonatomic, readonly) MRCNewsViewModelType type;
@property (strong, nonatomic, readonly) RACCommand *didClickLinkCommand;
@property (copy, nonatomic, readonly) NSArray *events;

- (NSArray *)dataSourceWithEvents:(NSArray *)events;

@end
