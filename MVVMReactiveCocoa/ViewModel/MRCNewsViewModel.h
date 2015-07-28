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

@property (copy, nonatomic, readonly) NSArray *events;
@property (assign, nonatomic, readonly) BOOL isCurrentUser;
@property (assign, nonatomic, readonly) MRCNewsViewModelType type;
@property (strong, nonatomic, readonly) RACCommand *didClickLinkCommand;

- (NSArray *)dataSourceWithEvents:(NSArray *)events;

@end
