//
//  MRCNewsItemViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/5.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MRCNewsItemViewModelType) {
    MRCNewsItemViewModelTypeStarred,
    MRCNewsItemViewModelTypeCommented,
    MRCNewsItemViewModelTypePullRequest,
    MRCNewsItemViewModelTypePushed
};

@interface MRCNewsItemViewModel : NSObject

@property (assign, nonatomic, readonly) MRCNewsItemViewModelType type;
@property (strong, nonatomic, readonly) OCTEvent *event;
@property (strong, nonatomic, readonly) NSAttributedString *contentAttributedString;
@property (copy, nonatomic, readonly) NSString *occurTime;

- (instancetype)initWithEvent:(OCTEvent *)event;

@end
