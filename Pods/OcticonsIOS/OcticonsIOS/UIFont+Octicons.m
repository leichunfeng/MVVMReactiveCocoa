//
//  UIFont+OcticonsIOS.m
//  OcticonsIOS
//
//  Created by Jackson Harper on 9/24/13.
//  Copyright (c) 2013 Harper Semiconductors, Inc.
//

#import "UIFont+Octicons.h"
#import "NSString+Octicons.h"


@implementation UIFont (Octicons)

+ (UIFont *)octicon_fontOfSize:(CGFloat)size
{
	return [UIFont fontWithName:kOcticonsFamilyName size:size];
}

@end
