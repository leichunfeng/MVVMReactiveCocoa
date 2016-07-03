//
//  LCFInfiniteScrollViewItem.m
//  LCFInfiniteScrollView
//
//  Created by leichunfeng on 16/4/16.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "LCFInfiniteScrollViewItem.h"

@interface LCFInfiniteScrollViewItem ()

@property (nonatomic, copy, readwrite) NSString *imageURL;
@property (nonatomic, copy, readwrite) NSString *text;

@end

@implementation LCFInfiniteScrollViewItem

+ (instancetype)itemWithImageURL:(NSString *)imageURL text:(NSString *)text {
    LCFInfiniteScrollViewItem *item = [[LCFInfiniteScrollViewItem alloc] init];
    
    item.imageURL = imageURL;
    item.text = text;
    
    return item;
}

@end
