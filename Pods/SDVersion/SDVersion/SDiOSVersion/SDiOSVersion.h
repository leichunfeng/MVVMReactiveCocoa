//
//  SDiOSVersion.h
//  SDVersion
//
//  Copyright (c) 2015 Sebastian Dobrincu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import <sys/utsname.h>

#define stringFromDeviceVersion(v) [@{@(3):@"iPhone 4", @(4):@"iPhone 4S", @(5):@"iPhone 5", @(6):@"iPhone 5C", @(7):@"iPhone 5S", @(8):@"iPhone 6", @(9): @"iPhone 6 Plus", @(10):@"iPhone 6S", @(11): @"iPhone 6S Plus", @(12):@"iPad 1", @(13):@"iPad 2", @(14):@"iPad Mini", @(15):@"iPad 3", @(16):@"iPad 4", @(17):@"iPad Air", @(18):@"iPad Mini 2", @(19):@"iPad Air 2", @(20):@"iPad Mini 3", @(21):@"iPad Mini 4", @(22):@"iPad Pro", @(23):@"iPod Touch 1st Gen", @(24):@"iPod Touch 2nd Gen", @(25):@"iPod Touch 3rd Gen", @(26):@"iPod Touch 4th Gen", @(27):@"iPod Touch 5th Gen", @(28):@"iPod Touch 6th Gen", @(0):@"Simulator"} objectForKey:[NSNumber numberWithInteger:v]]
#define stringFromDeviceSize(v) [@{@(0):@"Unknown Size", @(1):@"3.5 inch", @(2):@"4 inch", @(3):@"4.7 inch", @(4):@"5.5 inch"} objectForKey:[NSNumber numberWithInteger:v]]

@interface SDiOSVersion : NSObject

#define iOSVersionEqualTo(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define iOSVersionGreaterThan(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define iOSVersionGreaterThanOrEqualTo(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define iOSVersionLessThan(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define iOSVersionLessThanOrEqualTo(v)        ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

typedef NS_ENUM(NSInteger, DeviceVersion){
    iPhone4       = 3,
    iPhone4S      = 4,
    iPhone5       = 5,
    iPhone5C      = 6,
    iPhone5S      = 7,
    iPhone6       = 8,
    iPhone6Plus   = 9,
    iPhone6S      = 10,
    iPhone6SPlus  = 11,
    
    iPad1         = 12,
    iPad2         = 13,
    iPadMini      = 14,
    iPad3         = 15,
    iPad4         = 16,
    iPadAir       = 17,
    iPadMini2     = 18,
    iPadAir2      = 19,
    iPadMini3     = 20,
    iPadMini4     = 21,
    iPadPro       = 22,
    
    iPodTouch1Gen = 23,
    iPodTouch2Gen = 24,
    iPodTouch3Gen = 25,
    iPodTouch4Gen = 26,
    iPodTouch5Gen = 27,
    iPodTouch6Gen = 28,
    
    Simulator     = 0
};

typedef NS_ENUM(NSInteger, DeviceSize){
    UnknownSize     = 0,
    Screen3Dot5inch = 1,
    Screen4inch     = 2,
    Screen4Dot7inch = 3,
    Screen5Dot5inch = 4
};

+(DeviceVersion)deviceVersion;
+(DeviceSize)deviceSize;
+(NSString*)deviceName;

@end