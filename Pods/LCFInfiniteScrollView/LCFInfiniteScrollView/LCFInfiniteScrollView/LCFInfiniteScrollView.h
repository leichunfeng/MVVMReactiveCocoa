//
//  LCFInfiniteScrollView.h
//  LCFInfiniteScrollView
//
//  Created by leichunfeng on 16/4/16.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCFInfiniteScrollViewItem.h"

@class LCFInfiniteScrollView;

@protocol LCFInfiniteScrollViewDelegate <NSObject>

@optional

- (void)infiniteScrollView:(LCFInfiniteScrollView *)infiniteScrollView didDisplayItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface LCFInfiniteScrollView : UIView

@property (nonatomic, copy) NSArray<LCFInfiniteScrollViewItem *> *items;

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat itemSpacing;

@property (nonatomic, assign) BOOL autoscroll;
@property (nonatomic, assign) NSTimeInterval timeInterval;

@property (nonatomic, strong) UIImage *placeholderImage;

@property (nonatomic, copy) void (^didSelectItemAtIndex)(NSUInteger index);

@property (nonatomic, weak) id<LCFInfiniteScrollViewDelegate> delegate;

@end
