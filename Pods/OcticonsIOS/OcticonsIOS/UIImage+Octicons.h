//
//  UIImage+Octions.h
//  OcticonsIOS
//
//  Created by Jackson Harper on 9/24/13.
//  Copyright (c) 2013 Harper Semiconductors, Inc.
//

#import <UIKit/UIKit.h>

@interface UIImage (Octions)

+ (UIImage *)octicon_imageWithIcon:(NSString *)identifier
				 backgroundColor:(UIColor *)bgColor
					   iconColor:(UIColor *)iconColor
					   iconScale:(CGFloat)scale
						 andSize:(CGSize)size;

@end
