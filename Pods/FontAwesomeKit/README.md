FontAwesomeKit
==============
Icon font library for iOS. Currently supports Font-Awesome, Foundation icons, Zocial, and ionicons.

![image](http://i.minus.com/i3vNn0fTwcJeI.png)

![image](http://i.minus.com/ivKqhOLJLVvmJ.png)

## Version 2.1 Notable Changes
### Not Just Awesome. New Icon Fonts Added

Currently FontAwesomeKit supports **4** different icon fonts.

- [FontAwesome](http://fortawesome.github.io/Font-Awesome/) Our old friend, contains **361** icons
- [Foundation icons](http://zurb.com/playground/foundation-icon-fonts-3) Contains **283** icons.
- [Zocial](http://zocial.smcllns.com/) Contains **42** social icons.
- [ionicons](http://i.minus.com/ivKqhOLJLVvmJ.png) Contains **440** icons, lots of iOS 7 style hollow icons.

### API Reforged, Take Advantage of NSAttributedString
Thanks to `NSAttributedString` the API is more clean and object oriented. All hail `NSAttributedString`!

### Notes on FontAwesome
Please notice that FontAwesome has renamed lots of it's icons in the recent 4.0 release, make sure to change you code accordingly if you're using FontAwesomeKit 2.1 version.

##Installation
### Requirements
- Xcode 5
- iOS 6.0 +
- ARC enabled
- CoreText framework

### Install with CocoaPods (Strongly Recommended)
FontAwesomeKit now supports sub spec, only get the fonts you need.

~~Add `pod 'FontAwesomeKit'` to Podfile to install all icon fonts.~~

The pod spec for version 2.1.0 haven't been merged yet, use this instead.
`pod 'FontAwesomeKit/IonIcons', :podspec => 'https://raw.github.com/PrideChung/FontAwesomeKit/master/FontAwesomeKit.podspec'`

Or select icon fonts with:  

`pod 'FontAwesomeKit/FontAwesome'`  
`pod 'FontAwesomeKit/FoundationIcons'`  
`pod 'FontAwesomeKit/Zocial'`  
`pod 'FontAwesomeKit/IonIcons'`  

Run `pod install` or `pod update` to install selected icon fonts.

#### Importing Headers

`#import FontAwesomeKit/FontAwesomeKit.h` If you installed all available icon fonts.   

Or import icon fonts you installed with sub specs

`#import FontAwesomeKit/FAKFontAwesome.h`  
`#import FontAwesomeKit/FAKFoundationIcons.h`  
`#import FontAwesomeKit/FAKZocial.h`  
`#import FontAwesomeKit/FAKIonIcons.h`  

#####*important:*
If you deleted a sub spec in Podfile, please delete Xcode's derived data in organizer(command+shift+2 to bring up). Otherwise Xcode will keep copying font files those supposed to be deleted to the app bundle.

### Install Manually

Download source code, then drag the folder `FontAwesomeKit` into your project, add CoreText framework to you project.

##Example Usage

### Grap An Icon.
```objective-c
FAKFontAwesome *starIcon = [FAKFontAwesome starIconWithSize:15];
FAKFoundationIcons *bookmarkIcon = [FAKFoundationIcons bookmarkIconWithSize:15];
FAKZocial *twitterIcon = [FAKZocial twitterIconWithSize:15];  
FAKIonIcons *mailIcon = [FAKIonIcons ios7EmailIconWithSize:48];
```
Now you can use these class methods and pass in the font size instead of finding an icon with constants. Corresponding icon fonts will automatically setup for you.

### Setting Attributes for Icon
```objective-c
[starIcon addAttribute:NSForegroundColorAttributeName value:[UIColor 
whiteColor]];
```
`NSAttributedString` did all the magics behind the scene. So you can set those attributes supported by `NSAttributedString` to an icon. For all available attributes, see [NSAttributedString UIKit Additions Reference](https://developer.apple.com/library/ios/documentation/UIKit/Reference/NSAttributedString_UIKit_Additions/Reference/Reference.html#//apple_ref/doc/uid/TP40011688-CH1-SW16)

#####*important:*
Some attributes apparently makes no sense for icon fonts, like `NSLigatureAttributeName` and `NSKernAttributeName`. You should not set these attributes, otherwise you app may crash. And you should not set the value of `NSFontAttributeName`, if you want to change the size of an icon, set it's `iconFontSize` property instead.

### Other Methods for Setting or Getting Attributes
These methods in fact are just shorthand versions for the standard `NSAttributedString` API, should be pretty straightforward.

`[starIcon setAttributes:attributes];` *Sets attributes with a dictionary, will override current attribute if there're different values for a same key.*

`[starIcon removeAttribute:NSForegroundColorAttributeName];` *Removes an attribute by name.*

`[starIcon attributes];` *Returns an dictionary contains the attribute values for the icon.*

`[starIcon attribute:NSForegroundColorAttributeName];` *Returns the attribute value for a given key.*

### Get The Attributed String
After you done setting attributes, you can get the attributed string by calling
`[starIcon attributedString]`. 

So you can use the icon on a label with one line of code: `self.label.attributedText = [starIcon attributedString];` You don't need to set the label's `font` property, it's already been taken care of.

### Drawing The Icon on Image

#### Basic Drawing
Instead of getting the attributed string, you can draw the icon onto an image like this: `UIImage *iconImage = [starIcon imageWithSize:CGSizeMake(15, 15)];` This will use the attributes you've set to draw that image, you only need to specify a size for the image.

#### Drawing Offset
By default the icon will be centered horizontally and vertically. I believe that's 99% what you want. However, if you think it's not centered properly, you can set the `drawingPositionAdjustment` property for the icon, like this:

`starIcon.drawingPositionAdjustment = UIOffsetMake(2, 2);`

#### Background Color
You can set the background color for the image like this:

`starIcon.drawingBackgroundColor = [UIColor blackColor];`

By default the background is transparent. As the name implies, this property only takes effect while drawing on image. You can specify a gradient color to create a gradient background, check the example project for details.

### For Those Controls Doesn't Support Attributed String

Some UI elements doesn't have an attributed string property, using images might be a better idea. Take UIBarButtonItem as an example.

```objective-c
FAKFontAwesome *cogIcon = [FAKFontAwesome cogIconWithSize:20];
[cogIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
UIImage *leftImage = [cogIcon imageWithSize:CGSizeMake(20, 20)];
cogIcon.iconFontSize = 15;
UIImage *leftLandscapeImage = [cogIcon imageWithSize:CGSizeMake(15, 15)];
self.navigationItem.leftBarButtonItem =
[[UIBarButtonItem alloc] initWithImage:leftImage
                   landscapeImagePhone:leftLandscapeImage
                                 style:UIBarButtonItemStylePlain
                                target:nil
                                action:nil];
```

Same idea can be applied to tab bar or segmented control.

### More Examples
Please clone the master repo and take a look at the example project, everything is in it, all public methods and properties are documented. Feel free to open an issue if you went into trouble.

## About Gradient Helpers
If you noticed, all gradient helpers are gone. I removed gradient helpers in the new version because I think they are useless. I've opened an issue for discussion, [leave a comment if you think otherwise.](https://github.com/PrideChung/FontAwesomeKit/issues/7)

## About The Old Version
As I promised I will keep it maintained, response to Font-Awesome new icon updates, but I won't provide any new function. If you must support iOS5 you can keep using it, otherwise 2.x version is a better choice.

##Change Log
- 2.1.0 Add Font-Awesome 4.0.1 support. Add ionicons support.
- 2.0.0 Major update, API changed, added support for new icon fonts.
- 1.1.4 Update Font-Awesome's font file to 3.2.1, Bug fixes.
- 1.1.3 Add Font-Awesome 3.2 support. 58 new icon added.
- 1.1.2 Add Font-Awesome 3.1.1 support. 54 new icon added.
- 1.1.1 Add Shadows option while drawing icons on image.

##[Contributors](https://github.com/PrideChung/FontAwesomeKit/contributors)
- [alladinian](https://github.com/alladinian)
- [Isak Sky](https://github.com/isaksky)
- [Dominik Grygiel](https://github.com/dominikgrygiel)


##License
FontAwesomeKit is available under the MIT license. See the LICENSE file for more information. Attribution isn't required but is much appreciated.

**Please notice that each icon font has it's own license agreement.**
