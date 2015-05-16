//
//  UIImage+MRCOcticons.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/16.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "UIImage+MRCOcticons.h"
#import "UIImage+Octicons.h"

@implementation UIImage (MRCOcticons)

+ (UIImage *)octicon_imageWithIdentifier:(NSString *)identifier size:(CGSize)size {
    return [UIImage octicon_imageWithIcon:identifier
                          backgroundColor:[UIColor clearColor]
                                iconColor:[UIColor darkGrayColor]
                                iconScale:1
                                  andSize:size];
}

@end
