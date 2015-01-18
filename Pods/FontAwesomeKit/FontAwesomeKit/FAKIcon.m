#import "FAKIcon.h"
#import <CoreText/CoreText.h>

@interface FAKIcon ()

@property (strong, nonatomic) NSMutableAttributedString *mutableAttributedString;

@end

@implementation FAKIcon

+ (void)registerIconFontWithURL:(NSURL *)url
{
    NSAssert([[NSFileManager defaultManager] fileExistsAtPath:[url path]], @"Font file doesn't exist");
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)url);
    CGFontRef newFont = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CFErrorRef error;
    CTFontManagerRegisterGraphicsFont(newFont, &error);
    CGFontRelease(newFont);
}

+ (NSDictionary *)allIcons
{
    @throw @"You need to implement this method in subclass.";
}

+ (UIFont *)iconFontWithSize:(CGFloat)size
{
    @throw @"You need to implement this method in subclass.";
}

+ (instancetype)iconWithCode:(NSString *)code size:(CGFloat)size
{
    FAKIcon *icon = [[self alloc] init];
    icon.mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:code attributes:@{NSFontAttributeName: [self iconFontWithSize:size]}];
    return icon;
}

- (NSAttributedString *)attributedString
{ 
    return [self.mutableAttributedString copy];
}

- (NSString *)characterCode
{
    return [self.mutableAttributedString string];
}

- (NSString *)iconName
{
    return [[self class] allIcons][[self characterCode]];
}

- (CGFloat)iconFontSize
{
    return [self iconFont].pointSize;
}

- (void)setIconFontSize:(CGFloat)iconSize
{
    [self addAttribute:NSFontAttributeName value:[[self iconFont] fontWithSize:iconSize]];
}

#pragma mark - Setting and Getting Attributes

- (void)setAttributes:(NSDictionary *)attrs;
{
    if (!attrs[NSFontAttributeName]) {
        NSMutableDictionary *mutableAttrs = [attrs mutableCopy];
        mutableAttrs[NSFontAttributeName] = self.iconFont;
        attrs = [mutableAttrs copy];
    }
    [self.mutableAttributedString setAttributes:attrs range:[self rangeForMutableAttributedText]] ;
}

- (void)addAttribute:(NSString *)name value:(id)value
{
    [self.mutableAttributedString addAttribute:name value:value range:[self rangeForMutableAttributedText]];
}

- (void)addAttributes:(NSDictionary *)attrs
{
    [self.mutableAttributedString addAttributes:attrs range:[self rangeForMutableAttributedText]];
}

- (void)removeAttribute:(NSString *)name
{
    [self.mutableAttributedString removeAttribute:name range:[self rangeForMutableAttributedText]];
}

- (NSDictionary *)attributes
{
    return [self.mutableAttributedString attributesAtIndex:0 effectiveRange:NULL];
}

- (id)attribute:(NSString *)attrName
{
    return [self.mutableAttributedString attribute:attrName atIndex:0 effectiveRange:NULL];
}

- (NSRange)rangeForMutableAttributedText
{
    return NSMakeRange(0, [self.mutableAttributedString length]);
}

- (UIFont *)iconFont
{
    return [self attribute:NSFontAttributeName];
}

#pragma mark - Image Drawing

- (UIImage *)imageWithSize:(CGSize)imageSize
{
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
	
	// ---------- begin context ----------
	CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self fillBackgroundForContext:context backgroundSize:imageSize];
    
    [self.mutableAttributedString drawInRect:[self drawingRectWithImageSize:imageSize]];	
	UIImage *iconImage = UIGraphicsGetImageFromCurrentImageContext();
	
	// ---------- end context ----------
	UIGraphicsEndImageContext();
	
	return iconImage;
}

- (void)fillBackgroundForContext:(CGContextRef)context backgroundSize:(CGSize)size
{
    if (self.drawingBackgroundColor) {
		[self.drawingBackgroundColor setFill];
		CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
	}
}

// Calculate the correct drawing position
- (CGRect)drawingRectWithImageSize:(CGSize)imageSize
{
    CGSize iconSize = [self.mutableAttributedString size];
    CGFloat xOffset = (imageSize.width - iconSize.width) / 2.0;
    xOffset += self.drawingPositionAdjustment.horizontal;
    CGFloat yOffset = (imageSize.height - iconSize.height) / 2.0;
    yOffset += self.drawingPositionAdjustment.vertical;
    return CGRectMake(xOffset, yOffset, iconSize.width, iconSize.height);
}

@end

#pragma mark - Stacked Icons

@implementation UIImage (FAKAddon)

+ (UIImage *)imageWithStackedIcons:(NSArray *)icons imageSize:(CGSize)imageSize
{
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
	
	// ---------- begin context ----------
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (FAKIcon *icon in icons) {
        NSAssert([icon isKindOfClass:[FAKIcon class]], @"You can only stack FAKIcon derived objects.");
        [icon fillBackgroundForContext:context backgroundSize:imageSize];
        [icon.mutableAttributedString drawInRect:[icon drawingRectWithImageSize:imageSize]];
    }
    
	UIImage *iconImage = UIGraphicsGetImageFromCurrentImageContext();
	
	// ---------- end context ----------
	UIGraphicsEndImageContext();
	
	return iconImage;
}

@end

