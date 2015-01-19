//
//  UIImage+Octions.m
//  OcticonsIOS
//
//  Created by Jackson Harper on 9/24/13.
//  Copyright (c) 2013 Harper Semiconductors, Inc.
//
//
// Lifted from ios-fontawesome:
//  https://github.com/pepibumur/ios-fontawesome
//

#import "UIImage+Octicons.h"
#import "NSString+Octicons.h"

@implementation UIImage (Octions)

+ (UIImage *)octicon_imageWithIcon:(NSString *)identifier
				   backgroundColor:(UIColor *)bgColor
						 iconColor:(UIColor *)iconColor
						 iconScale:(CGFloat)scale
						   andSize:(CGSize)size
{
	if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
		UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
	} else {
		UIGraphicsBeginImageContext(size);
	}

    // Abstracted Attributes
	NSString* textContent = [NSString octicon_iconStringForIconIdentifier:identifier];

	// Rectangle Drawing
	UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, size.width, size.height)];
	[bgColor setFill];
	[rectanglePath fill];

    // Text Drawing
	float fontSize=(MIN(size.height,size.width))*scale;
	CGRect textRect = CGRectMake(size.width/2-(fontSize/2)*1.2, size.height/2-fontSize/2, fontSize*1.2, fontSize);

	UIFont *font = [UIFont fontWithName:kOcticonsFamilyName size:(float)((int)fontSize)];
	NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	[paragraphStyle setAlignment:NSTextAlignmentCenter];
	[paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];

	[textContent drawInRect:textRect withAttributes:@{
		NSFontAttributeName:			font,
		NSParagraphStyleAttributeName:	paragraphStyle,
		NSForegroundColorAttributeName:	iconColor,
	}];

	// Image returns
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

@end
