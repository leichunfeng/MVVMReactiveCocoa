//
//  LCFInfiniteScrollViewItem.h
//  LCFInfiniteScrollView
//
//  Created by leichunfeng on 16/4/16.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCFInfiniteScrollViewItem : NSObject

@property (nonatomic, copy, readonly) NSString *imageURL;
@property (nonatomic, copy, readonly) NSString *text;

+ (instancetype)itemWithImageURL:(NSString *)imageURL text:(NSString *)text;

@end
