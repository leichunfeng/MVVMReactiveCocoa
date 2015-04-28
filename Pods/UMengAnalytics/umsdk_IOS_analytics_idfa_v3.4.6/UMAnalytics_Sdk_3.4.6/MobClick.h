//
//  MobClick.h
//  Analytics
//
//  Copyright (C) 2010-2015 Umeng.com . All rights reserved.

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define UMOnlineConfigDidFinishedNotification @"OnlineConfigDidFinishedNotification"
#define XcodeAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/**
 REALTIME只在模拟器和DEBUG模式下生效，真机的release模式会自动改成BATCH。
 */
typedef enum {
    REALTIME = 0,       //实时发送              (只在测试模式下有效)
    BATCH = 1,          //启动发送
    SEND_INTERVAL = 6,  //最小间隔发送           ([90-86400]s, default 90s)
    
    // deprecated strategy:
    SENDDAILY = 4,      //每日发送              (not available)
    SENDWIFIONLY = 5,   //仅在WIFI下时启动发送   (not available)
    SEND_ON_EXIT = 7    //进入后台时发送         (not avilable, will be support later)
} ReportPolicy;

@class CLLocation;


@interface MobClick : NSObject <UIAlertViewDelegate>

#pragma mark basics

///---------------------------------------------------------------------------------------
/// @name  设置
///---------------------------------------------------------------------------------------

/** 设置app版本号。由于历史原因需要和xcode3工程兼容,友盟提取的是Build号(CFBundleVersion)，
 如果需要和App Store上的版本一致,请调用此方法。
 @param appVersion 版本号，例如设置成`XcodeAppVersion`.
 @return void.
 */
+ (void)setAppVersion:(NSString *)appVersion;

/** 开启CrashReport收集, 默认YES(开启状态).
 @param value 设置为NO,可关闭友盟CrashReport收集功能.
 @return void.
 */
+ (void)setCrashReportEnabled:(BOOL)value;

/** 设置是否打印sdk的log信息, 默认NO(不打印log).
 @param value 设置为YES,umeng SDK 会输出log信息可供调试参考. 除非特殊需要，否则发布产品时需改回NO.
 @return void.
 */
+ (void)setLogEnabled:(BOOL)value;

/** 设置是否开启background模式, 默认YES.
 @param value 为YES,SDK会确保在app进入后台的短暂时间保存日志信息的完整性，对于已支持background模式和一般app不会有影响.
 如果该模式影响某些App在切换到后台的功能，也可将该值设置为NO.
 @return void.
 */
+ (void)setBackgroundTaskEnabled:(BOOL)value;

/** 设置是否对日志信息进行加密, 默认NO(不加密).
 @param value 设置为YES, umeng SDK 会将日志信息做加密处理
 @return void.
 */
+ (void)setEncryptEnabled:(BOOL)value;

///---------------------------------------------------------------------------------------
/// @name  开启统计
///---------------------------------------------------------------------------------------

/** 初始化友盟统计模块
 @param appKey 友盟appKey.
 @return void
 */
+ (void)startWithAppkey:(NSString *)appKey;

/** 初始化友盟统计模块
 @param appKey 友盟appKey.
 @param reportPolicy 发送策略, 默认值为：BATCH，即“启动发送”模式
 @param channelId 渠道名称,为nil或@""时, 默认为@"App Store"渠道
 @return void
 */
+ (void)startWithAppkey:(NSString *)appKey reportPolicy:(ReportPolicy)rp channelId:(NSString *)cid;

/** 当reportPolicy == SEND_INTERVAL 时设定log发送间隔
 @param second 单位为秒,最小90秒,最大86400秒(24hour).
 @return void.
 */
+ (void)setLogSendInterval:(double)second;

/** 设置日志延迟发送
 @param second 设置一个[0, second]范围的延迟发送秒数，最大值1800s.
 @return void
 */
+ (void)setLatency:(int)second;

///---------------------------------------------------------------------------------------
/// @name  页面计时
///---------------------------------------------------------------------------------------

/** 手动页面时长统计, 记录某个页面展示的时长.
 @param pageName 统计的页面名称.
 @param seconds 单位为秒，int型.
 @return void.
 */
+ (void)logPageView:(NSString *)pageName seconds:(int)seconds;

/** 自动页面时长统计, 开始记录某个页面展示时长.
 使用方法：必须配对调用beginLogPageView:和endLogPageView:两个函数来完成自动统计，若只调用某一个函数不会生成有效数据。
 在该页面展示时调用beginLogPageView:，当退出该页面时调用endLogPageView:
 @param pageName 统计的页面名称.
 @return void.
 */
+ (void)beginLogPageView:(NSString *)pageName;

/** 自动页面时长统计, 结束记录某个页面展示时长.
 使用方法：必须配对调用beginLogPageView:和endLogPageView:两个函数来完成自动统计，若只调用某一个函数不会生成有效数据。
 在该页面展示时调用beginLogPageView:，当退出该页面时调用endLogPageView:
 @param pageName 统计的页面名称.
 @return void.
 */
+ (void)endLogPageView:(NSString *)pageName;

#pragma mark event logs

///---------------------------------------------------------------------------------------
/// @name  事件统计
///---------------------------------------------------------------------------------------

/** 自定义事件,数量统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID
 
 @param  eventId 网站上注册的事件Id.
 @param  label 分类标签。不同的标签会分别进行统计，方便同一事件的不同标签的对比,为nil或空字符串时后台会生成和eventId同名的标签.
 @param  accumulation 累加值。为减少网络交互，可以自行对某一事件ID的某一分类标签进行累加，再传入次数作为参数。
 @return void.
 */
+ (void)event:(NSString *)eventId; //等同于 event:eventId label:eventId;
/** 自定义事件,数量统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID
 */
+ (void)event:(NSString *)eventId label:(NSString *)label; // label为nil或@""时，等同于 event:eventId label:eventId;

/** 自定义事件,数量统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID
 */
+ (void)event:(NSString *)eventId attributes:(NSDictionary *)attributes;

+ (void)event:(NSString *)eventId attributes:(NSDictionary *)attributes counter:(int)number;

/** 自定义事件,时长统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID.
 beginEvent,endEvent要配对使用,也可以自己计时后通过durations参数传递进来
 
 @param  eventId 网站上注册的事件Id.
 @param  label 分类标签。不同的标签会分别进行统计，方便同一事件的不同标签的对比,为nil或空字符串时后台会生成和eventId同名的标签.
 @param  primarykey 这个参数用于和event_id一起标示一个唯一事件，并不会被统计；对于同一个事件在beginEvent和endEvent 中要传递相同的eventId 和 primarykey
 @param millisecond 自己计时需要的话需要传毫秒进来
 @return void.
 
 
 @warning 每个event的attributes不能超过10个
 eventId、attributes中key和value都不能使用空格和特殊字符，且长度不能超过255个字符（否则将截取前255个字符）
 id， ts， du是保留字段，不能作为eventId及key的名称
 
 */
+ (void)beginEvent:(NSString *)eventId;
/** 自定义事件,时长统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID.
 */
+ (void)endEvent:(NSString *)eventId;
/** 自定义事件,时长统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID.
 */

+ (void)beginEvent:(NSString *)eventId label:(NSString *)label;
/** 自定义事件,时长统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID.
 */

+ (void)endEvent:(NSString *)eventId label:(NSString *)label;
/** 自定义事件,时长统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID.
 */

+ (void)beginEvent:(NSString *)eventId primarykey :(NSString *)keyName attributes:(NSDictionary *)attributes;
/** 自定义事件,时长统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID.
 */

+ (void)endEvent:(NSString *)eventId primarykey:(NSString *)keyName;
/** 自定义事件,时长统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID.
 */

+ (void)event:(NSString *)eventId durations:(int)millisecond;
/** 自定义事件,时长统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID.
 */

+ (void)event:(NSString *)eventId label:(NSString *)label durations:(int)millisecond;
/** 自定义事件,时长统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID.
 */
+ (void)event:(NSString *)eventId attributes:(NSDictionary *)attributes durations:(int)millisecond;


#pragma mark AutoUpdate and Online Configure
///---------------------------------------------------------------------------------------
/// @name  按渠道自动更新
///---------------------------------------------------------------------------------------

/** 按渠道检测更新
 检查当前app是否有更新，有则弹出UIAlertView提示用户,当用户点击升级按钮时app会跳转到您预先设置的网址。
 无更新不做任何操作。
 需要先在服务器端设置app版本信息，默认渠道是App Store.
 @return void.
 */
+ (void)checkUpdate;

/** 按渠道检测更新
 检查当前app是否有更新，有则弹出UIAlertView提示用户,当用户点击升级按钮时app会跳转到您预先设置的网址。
 无更新不做任何操作。
 需要先在服务器端设置app版本信息，默认渠道是App Store.
 
 @param title 对应UIAlertView的title.
 @param cancelTitle 对应UIAlertView的cancelTitle.
 @param otherTitle 对应UIAlertView的otherTitle.
 @return void.
 */
+ (void)checkUpdate:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSString *)otherTitle;

/** 设置自由控制更新callback函数
 若程序需要自由控制收到更新内容后的流程可设置delegate和callback函数来完成
 
 @param delegate 需要自定义checkUpdate的对象.
 @param callBackSelectorWithDictionary 当checkUpdate事件完成时此方法会被调用,同时标记app更新信息的字典被传回.
 */
+ (void)checkUpdateWithDelegate:(id)delegate selector:(SEL)callBackSelectorWithDictionary;


///---------------------------------------------------------------------------------------
/// @name  在线参数：可以动态设定应用中的参数值
///---------------------------------------------------------------------------------------

/** 此方法会检查并下载服务端设置的在线参数,例如可在线更改SDK端发送策略。
 请在[MobClick startWithAppkey:]方法之后调用;
 监听在线参数更新是否完成，可注册UMOnlineConfigDidFinishedNotification通知
 @param .
 @return void.
 */
+ (void)updateOnlineConfig;

/** 返回已缓存的在线参数值
 带参数的方法获取某个key的值，不带参数的获取所有的在线参数.
 需要先调用updateOnlineConfig才能使用,如果想知道在线参数是否完成完成，请监听UMOnlineConfigDidFinishedNotification
 @param key
 @return (NSString *) .
 */
+ (NSString *)getConfigParams:(NSString *)key;
+ (NSDictionary *)getConfigParams;
+ (NSString *)getAdURL;

///---------------------------------------------------------------------------------------
/// @name 地理位置设置
/// 需要链接 CoreLocation.framework 并且 #import <CoreLocation/CoreLocation.h>
///---------------------------------------------------------------------------------------

/** 设置经纬度信息
 @param latitude 纬度.
 @param longitude 经度.
 @return void
 */
+ (void)setLatitude:(double)latitude longitude:(double)longitude;

/** 设置经纬度信息
 @param location CLLocation 经纬度信息
 @return void
 */
+ (void)setLocation:(CLLocation *)location;


///---------------------------------------------------------------------------------------
/// @name Utility函数
///---------------------------------------------------------------------------------------

/** 判断设备是否越狱，依据是否存在apt和Cydia.app
 */
+ (BOOL)isJailbroken;

/** 判断App是否被破解
 */
+ (BOOL)isPirated;

#pragma mark DEPRECATED

+ (void)event:(NSString *)eventId acc:(NSInteger)accumulation;
/** 自定义事件,数量统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID
 */
+ (void)event:(NSString *)eventId label:(NSString *)label acc:(NSInteger)accumulation;
/** 自定义事件,数量统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID
 */

/** 友盟模块启动
 [MobClick startWithAppkey:]通常在application:didFinishLaunchingWithOptions:里被调用监听App启动和退出事件，
 如果开发者无法在此处添加友盟的[MobClick startWithAppkey:]方法，App的启动事件可能会无法监听，此时需要手动调用[MobClick startSession:nil]来启动友盟的session。
 上述情况通常发生在某些第三方框架生成的app里，普通app不用关注该API.
 */
+ (void)startSession:(NSNotification *)notification;

@end
