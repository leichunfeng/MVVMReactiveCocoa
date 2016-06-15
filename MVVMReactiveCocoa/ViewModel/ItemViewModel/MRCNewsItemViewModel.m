//
//  MRCNewsItemViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/5.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCNewsItemViewModel.h"
#import "TTTTimeIntervalFormatter.h"

@interface MRCNewsItemViewModel ()

@property (nonatomic, strong, readwrite) OCTEvent *event;
@property (nonatomic, copy, readwrite) NSAttributedString *attributedString;

@end

@implementation MRCNewsItemViewModel

- (instancetype)initWithEvent:(OCTEvent *)event {
    self = [super init];
    if (self) {
        self.event = event;
        self.attributedString = event.mrc_attributedString;
        
        // Create text container
        YYTextContainer *container = [[YYTextContainer alloc] init];
        
        container.size = CGSizeMake(SCREEN_WIDTH - 10 - 40 - 10 - 10, HUGE);
        container.maximumNumberOfRows = 10;
        container.truncationType = YYTextTruncationTypeEnd;
        
        // Generate a text layout.
        self.textLayout = [YYTextLayout layoutWithContainer:container text:event.mrc_attributedString];
        
        self.height = ({
            CGFloat height = 0;
            
            height += 10;
            height += self.textLayout.textBoundingSize.height;
            height += 10;
            
            height;
        });
    }
    return self;
}

@end
