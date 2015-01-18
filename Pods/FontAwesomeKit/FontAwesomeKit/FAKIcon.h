#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  Abstract superclass for icons, should not be used directly. You can subclass this class to provide new icon font support.
 */
@interface FAKIcon : NSObject

/**
 *  The drawing offset of the icon in the image. If you do not specify this property, the icon is centered horizontally and vertically inside the image.
 */
@property (nonatomic) UIOffset drawingPositionAdjustment;

/**
 *  The background color of the image while drawing. If you do not specify this property, no background color is drawn.
 */
@property (strong, nonatomic) UIColor *drawingBackgroundColor;

/**
 *  The icon font size for the icon.
 */
@property (nonatomic) CGFloat iconFontSize;

/**
 *  Register a icon font with it's file url.
 *
 *  @param url The file url for the font, file must exists.
 */
+ (void)registerIconFontWithURL:(NSURL *)url;

/**
 *  Returns an dictionary of icons available for this icon font.
 *
 *  @return A dictionary of icons. The keys are character codes of icons, the corresponding value for a key is the name for that icon.
 */
+ (NSDictionary *)allIcons;

/**
 *  Creates and returns an icon font object for the specified size. This is an abstract method and subclasses must provide an implementation.
 *
 *  @param size The size (in points) to which the font is scaled. This value must be greater than 0.0.
 *
 *  @return A font object of the specified name and size.
 */
+ (UIFont *)iconFontWithSize:(CGFloat)size;

/**
 *  Creates and returns a FAKIcon object for the specified character code and size.
 *
 *  @param code A string represents a character code. Like @"\uf000"
 *  @param size The desired size (in points) of the icon font that will be used for the icon. This value must be greater than 0.0.
 *
 *  @return Returns a FAKIcon object.
 */
+ (instancetype)iconWithCode:(NSString *)code size:(CGFloat)size;

/**
 *  Adds an attribute with the given name and value to the icon.
 *
 *  @param attrs A dictionary containing the text attributes to set. These attributes will be used to create attributedString when you call -attributedString on the receiver. For information about system-supplied attribute keys, See NSAttributedString UIKit Additions Reference (https://developer.apple.com/library/ios/documentation/UIKit/Reference/NSAttributedString_UIKit_Additions/Reference/Reference.html#//apple_ref/doc/uid/TP40011688-CH1-SW16)
 *  @warning You should not set the NSFontAttributeName attribute to another font.
 */
- (void)setAttributes:(NSDictionary *)attrs;

/**
 *  Adds an attribute with the given name and value to the icon.
 *
 *  @param name  A string specifying the attribute name. 
 *  @param value Adds an attribute with the given name and value to the icon.
 */
- (void)addAttribute:(NSString *)name value:(id)value;

/**
 *  Adds the given collection of attributes to the icon.
 *
 *  @param attrs A dictionary containing the attributes to add.
 */
- (void)addAttributes:(NSDictionary *)attrs;

/**
 *  Removes the named attribute from the icon.
 *
 *  @param name A string specifying the attribute name to remove.
 */
- (void)removeAttribute:(NSString *)name;

/**
 *  Returns the attributes for the icon.
 *
 *  @return The attributes for the icon.
 */
- (NSDictionary *)attributes;

/**
 *  Returns the value for an attribute with a given name of the icon.
 *
 *  @param attrName The name of an attribute.
 *
 *  @return The value for an attribute with a given name of the icon, or nil if there is no such attribute.
 */
- (id)attribute:(NSString *)attrName;

/**
 *  Creates and returns a NSAttributedString with specified attributes for the receiver.
 *
 *  @return A NSAttributedString with specifed attributes.
 */
- (NSAttributedString *)attributedString;

/**
 *  Returns the character code of the icon.
 *
 *  @return The character code of the icon.
 */
- (NSString *)characterCode;

/**
 *  Returns the name of the icon.
 *
 *  @return The name of the icon.
 */
- (NSString *)iconName;

/**
 *  Returns the icon font of the icon.
 *
 *  @return The icon font of the icon.
 */
- (UIFont *)iconFont;

/**
 *  Draws the icon on an image. The icon will be centered horizontally and vertically by default. You can set the drawingPostionAdjustment property to adjust drawing offset.
 *
 *  @param imageSize Height and width for the image.
 *
 *  @return An image with the icon.
 */
- (UIImage *)imageWithSize:(CGSize)imageSize;

@end

@interface UIImage (FAKAddon)

/**
 *  Draws the FAKIcons in an array on an image. These icons will be centered horizontally and vertically by default. You can set the drawingPostionAdjustment property to adjust drawing offset for each icon.
 *
 *  @param icons The icons to be drawn. The first icon will be drawn on the bottom and the last icon will be drawn on the top.
 *  @param imageSize Height and width for the generated image.
 *
 *  @return An image with the icons.
 */
+ (UIImage *)imageWithStackedIcons:(NSArray *)icons imageSize:(CGSize)imageSize;

@end
