//
//  MRCUtil.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCUtil.h"

@implementation MRCUtil

@end

@implementation NSString (Util)

- (BOOL)isExist {
    return self && ![self isEqualToString:@""];
}

- (BOOL)isImage {
    if (!self.isExist) return NO;
    
    NSArray *imageExtensions = @[ @".png", @".gif", @".jpg", @".jpeg" ];
    for (NSString *extension in imageExtensions) {
        if ([self.lowercaseString hasSuffix:extension]) return YES;
    }
    
    return NO;
}

- (BOOL)isMarkdown {
    if (!self.isExist) return NO;
    
    NSArray *markdownExtensions = @[ @".md", @".mkdn", @".mdwn", @".mdown", @".markdown", @".mkd", @".mkdown", @".ron" ];
    for (NSString *extension in markdownExtensions) {
        if ([self.lowercaseString hasSuffix:extension]) return YES;
    }
    
    return NO;
}

- (NSString *)firstLetter {
    return [[self substringToIndex:1] uppercaseString];
}

@end

@implementation UIColor (Util)

- (UIImage *)color2Image {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)color2ImageSized:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

@implementation NSMutableArray (MRCSafeAdditions)

- (void)mrc_addObject:(id)object {
    if (!object) return;
    [self addObject:object];
}

@end
