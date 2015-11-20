//
//  UIImage+MRCOcticons.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/16.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MRCOcticons)

/// Generating icon image using the GitHub's icons font.
///
/// identifier - The identifier of GitHub's icons font
/// size       - The size of icon image
///
/// Returns the icon image.
+ (UIImage *)octicon_imageWithIdentifier:(NSString *)identifier size:(CGSize)size;

@end
