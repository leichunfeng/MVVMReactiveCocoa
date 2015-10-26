//
//  JSPatch.h
//  JSPatch
//
//  Created by bang on 15/7/28.
//  Copyright (c) 2015 bang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSPatch : NSObject
+ (void)startWithAppKey:(NSString *)aAppKey;
+ (void)testScriptInBundle;
@end