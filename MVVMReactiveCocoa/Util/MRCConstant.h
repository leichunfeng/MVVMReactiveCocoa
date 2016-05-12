//
//  MRCConstant.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#ifndef MVVMReactiveCocoa_MRCConstant_h
#define MVVMReactiveCocoa_MRCConstant_h

///------
/// NSLog
///------

#ifdef DEBUG
    #define NSLog(...) NSLog(__VA_ARGS__)
#else
    #define NSLog(...) {}
#endif

#define MRCLogError(error) NSLog(@"Error: %@", error)

///------
/// Block
///------

typedef void (^VoidBlock)();
typedef BOOL (^BoolBlock)();
typedef int  (^IntBlock) ();
typedef id   (^IDBlock)  ();

typedef void (^VoidBlock_int)(int);
typedef BOOL (^BoolBlock_int)(int);
typedef int  (^IntBlock_int) (int);
typedef id   (^IDBlock_int)  (int);

typedef void (^VoidBlock_string)(NSString *);
typedef BOOL (^BoolBlock_string)(NSString *);
typedef int  (^IntBlock_string) (NSString *);
typedef id   (^IDBlock_string)  (NSString *);

typedef void (^VoidBlock_id)(id);
typedef BOOL (^BoolBlock_id)(id);
typedef int  (^IntBlock_id) (id);
typedef id   (^IDBlock_id)  (id);

///------
/// Color
///------

#define RGB(r, g, b) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define colorA1 0xe14828
#define colorA2 0xdc2903
#define colorA3 0xf39800
#define colorA4 0xf34659
#define colorA5 0x53d769
#define colorA6 0x1c7efb
#define colorA7 0x00aff7
#define colorA8 0xeb8501
#define colorA9 0x2fc348
#define colorA10 0xce3b4a
#define colorA11 0x0bcbc3
#define colorA12 0x0ab8b4
#define colorA13 0xec8621
#define colorA14 0xfc3c39
#define colorA15 0xe8f6ef
#define colorA16 0x62c092
#define colorA17 0x168f54
#define colorA18 0x007b46

#define colorB0 0xffffff
#define colorB1 0xeeeeee
#define colorB2 0xC8C7CC
#define colorB3 0xbfbfbf
#define colorB4 0x959595
#define colorB5 0x707070
#define colorB6 0x000000
#define colorB7 0xe5e5e5
#define colorB8 0xf8f8f8
#define colorB9 0x434343

#define colorJ1 0xf15e4b
#define colorJ2 0xed2e66
#define colorJ3 0xffb430
#define colorJ4 0x2bb97d
#define colorJ5 0x30b8f3
#define colorJ6 0xe14828
#define colorJ7 0x8fcc0b

#define colorF1 0xd9403f
#define colorF2 0x47a9f0
#define colorF3 0x9cc551
#define colorF4 0x7d7d7d
#define colorF5 0xe14828
#define colorF6 0x39921a

#define colorT1a 0xed5565
#define colorT2a 0xfc8151
#define colorT3a 0xf6bb48
#define colorT4a 0xbcd85f
#define colorT5a 0x83c06b
#define colorT6a 0x48cfad
#define colorT7a 0x4fc0e8
#define colorT8a 0x5d9cec
#define colorT9a 0xac92ec
#define colorT10a 0xec87bf

#define colorT1b 0xda4453
#define colorT2b 0xe1602d
#define colorT3b 0xf6ab42
#define colorT4b 0x8cc152
#define colorT5b 0x5ea044
#define colorT6b 0x37bc9b
#define colorT7b 0x3aafda
#define colorT8b 0x4a89dc
#define colorT9b 0x967adc
#define colorT10b 0xd671ad

#define colorI1 0xBB0F23
#define colorI2 0x30434E
#define colorI3 0x4183C4
#define colorI4 0xe9dba5
#define colorI5 0x24AFFC
#define colorI6 0xEDEDED
//#define colorI6 0xE1E8ED
//#define colorI6 0xEFEDEA
#define colorI7 0xD9D9D9

#define MRC_PLACEHOLDER_IMAGE [HexRGB(0xEDEDED) color2Image]

#define MRC_EMPTY_PLACEHOLDER @"Not Set"

#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define MRC_ALERT_TITLE @"Tips"
#define MBPROGRESSHUD_LABEL_TEXT @"Loading..."

#define MRC_LEFT_IMAGE_SIZE CGSizeMake(25, 25)
#define MRC_1PX_WIDTH (1 / [UIScreen mainScreen].scale)

///---------
/// App Info
///---------

#define MRCApplicationVersionKey @"MRCApplicationVersionKey"

#define MRC_APP_ID               @"961330940"
#define MRC_APP_STORE_URL        @"https://itunes.apple.com/cn/app/id"MRC_APP_ID"?mt=8"
#define MRC_APP_STORE_REVIEW_URL @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id="MRC_APP_ID@"&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software"

#define MRC_APP_NAME    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])
#define MRC_APP_VERSION ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
#define MRC_APP_BUILD   ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])

///-----------------------------
/// MVVMReactiveCocoa Repository
///-----------------------------

#define MVVM_REACTIVECOCOA_OWNER_LOGIN @"leichunfeng"
#define MVVM_REACTIVECOCOA_NAME        @"MVVMReactiveCocoa"

#define MRC_README_CSS_STYLE @"<style type=\"text/css\">body { font-family: \"Helvetica Neue\", Helvetica, \"Segoe UI\", Arial, freesans, sans-serif; }</style>"

///------------
/// UMengSocial
///------------

#define MRC_UM_APP_KEY   @"553e402e67e58ed9f4004045"
#define MRC_UM_SHARE_URL @"http://www.umeng.com/social"

// Wechat
#define MRC_WX_APP_ID     @"wx738f343b7a8d1bdb"
#define MRC_WX_APP_SECRET @"a09ec93457abc134f769e37da4d8ad21"

// Sina Weibo
#define MRC_WEIBO_APP_KEY      @"2568724352"
#define MRC_WEIBO_APP_SECRET   @"ef15e9184ff294fc67a3240e960782f2"
#define MRC_WEIBO_REDIRECT_URL @"http://sns.whalecloud.com/sina2/callback"

// QQ
#define MRC_QQ_APP_ID            @"1104637080"
#define MRC_QQ_APP_KEY           @"WWGP247M3a7xIAUL"
#define MRC_TENCENT_REDIRECT_URL @"http://sns.whalecloud.com/tencent2/callback"

///-----
/// FMDB
///-----

#define MRC_FMDB_PATH [NSString stringWithFormat:@"%@/%@.db", MRC_DOCUMENT_DIRECTORY, MRC_APP_NAME]
#define MRCLogLastError(db) NSLog(@"lastError: %@, lastErrorCode: %d, lastErrorMessage: %@", [db lastError], [db lastErrorCode], [db lastErrorMessage]);

///-------------
/// Notification
///-------------

#define MRCStarredReposDidChangeNotification   @"MRCStarredReposDidChangeNotification"
#define MRCRecentSearchesDidChangeNotification @"MRCRecentSearchesDidChangeNotification"

///--------
/// Bugtags
///--------

#define MRC_BUGTAGS_APP_KEY @"69f973866d636e2b4b3f42ef1ec2caec"

///--------
/// JSPatch
///--------

#define MRC_JSPATCH_APP_KEY @"0b4fa7df769bf223"

#endif
