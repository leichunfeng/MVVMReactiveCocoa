/*
 File:       Bugtags/Bugtags.h
 
 Contains:   API for using Bugtags's SDK.
 
 Copyright:  (c) 2015 by Bugtags, Ltd., all rights reserved.
 
 Version:    1.1.3
 */

#import "BTGConstants.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface BugtagsOptions : NSObject

/**
 *  是否跟踪闪退，联机Debug状态下默认NO，其它情况默认YES
 */
@property(nonatomic, assign) BOOL trackingCrashes;

/**
 *  是否跟踪用户操作步骤，默认YES
 */
@property(nonatomic, assign) BOOL trackingUserSteps;

/**
 *  是否收集控制台日志，默认YES
 */
@property(nonatomic, assign) BOOL trackingConsoleLog;

/**
 *  是否收集用户位置信息，默认YES
 */
@property(nonatomic, assign) BOOL trackingUserLocation;

/**
 *  是否收集闪退时的界面截图，默认YES
 */
@property(nonatomic, assign) BOOL crashWithScreenshot;

/**
 * 支持的屏幕方向，默认UIInterfaceOrientationMaskAllButUpsideDown，请根据您的App支持的屏幕方向来设置
 * 1.1.2+ 不需要手动设置，SDK会自动设置
 */
@property(nonatomic, assign) UIInterfaceOrientationMask supportedInterfaceOrientations __attribute__((deprecated));

/**
 *  设置应用版本号，默认自动获取应用的版本号
 */
@property(nonatomic, strong) NSString *version;

/**
 *  设置应用build，默认自动获取应用的build
 */
@property(nonatomic, strong) NSString *build;

@end

@interface Bugtags : NSObject

/**
 * 初始化Bugtags
 * @param appKey - 通过bugtags.com申请的应用appKey
 * @param invocationEvent - 呼出方式
 * @return none
 */
+ (void)startWithAppKey:(NSString *)appKey invocationEvent:(BTGInvocationEventEvent)invocationEvent;

/**
 * 初始化Bugtags
 * @param appKey - 通过bugtags.com申请的应用appKey
 * @param invocationEvent - 呼出方式
 * @param options - 启动选项
 * @return none
 */
+ (void)startWithAppKey:(NSString *)appKey invocationEvent:(BTGInvocationEventEvent)invocationEvent options:(BugtagsOptions *)options;

/**
 * 设置Bugtags呼出方式
 * @param invocationEvent - 呼出方式
 * @return none
 */
+ (void)setInvocationEvent:(BTGInvocationEventEvent)invocationEvent;

/**
 * Bugtags日志工具，添加自定义日志，不会在控制台输出
 * @param format
 * @param ...
 * @return none
 */
void BTGLog(NSString *format, ...);

/**
 * 设置是否收集Crash信息
 * @param trackingCrashes - 默认 YES
 * @return none
 */
+ (void)setTrackingCrashes:(BOOL)trackingCrashes;

/**
 * 设置是否跟踪用户操作步骤
 * @param trackingUserSteps - 默认 YES
 * @return none
 */
+ (void)setTrackingUserSteps:(BOOL)trackingUserSteps;

/**
 * 设置是否收集控制台日志
 * @param trackingConsoleLog - 默认 YES
 * @return none
 */
+ (void)setTrackingConsoleLog:(BOOL)trackingConsoleLog;

/**
* 设置是否收集用户位置信息
* @param trackingUserLocation - 默认 YES
* @return none
*/
+ (void)setTrackingUserLocation:(BOOL)trackingUserLocation;

/**
 * 设置自定义数据，会与问题一起提交
 * @param data
 * @param key
 * @return none
 */
+ (void)setUserData:(NSString *)data forKey:(NSString *)key;

/**
 * 移除指定key的自定义数据
 * @param key
 * @return none
 */
+ (void)removeUserDataForKey:(NSString *)key;

/**
 * 移除所有自定义数据
 * @return none
 */
+ (void)removeAllUserData;

/**
 * 手动发送Exception
 * @param exception
 * @return none
 */
+ (void)sendException:(NSException *)exception;

/**
 * 发送用户反馈
 * @param content - 反馈内容
 * @return none
 */
+ (void)sendFeedback:(NSString *)content;

@end