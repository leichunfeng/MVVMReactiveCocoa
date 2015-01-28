//
//  MKNetworkKit.h
//  MKNetworkKit
//
//  Created by Mugunth Kumar (@mugunthkumar) on 11/11/11.
//  Copyright (C) 2011-2020 by Steinlogic Consulting and Training Pte Ltd

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#ifndef MKNetworkKit_MKNetworkKit_h
#define MKNetworkKit_MKNetworkKit_h

#ifndef __IPHONE_4_0
#error "MKNetworkKit uses features only available in iOS SDK 4.0 and later."
#endif

#if TARGET_OS_IPHONE
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#elif TARGET_OS_MAC
#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>
#if MAC_OS_X_VERSION_MIN_REQUIRED >= 1080
#define DO_GCD_RETAIN_RELEASE 0
#else
#define DO_GCD_RETAIN_RELEASE 1
#endif
#endif

#ifdef DEBUG
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif

// ALog always displays output regardless of the DEBUG setting
#define ALog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);};

#import "Categories/NSString+MKNetworkKitAdditions.h"
#import "Categories/NSDictionary+RequestEncoding.h"
#import "Categories/NSDate+RFC1123.h"
#import "Categories/NSData+MKBase64.h"

#if TARGET_OS_IPHONE
#import "Categories/UIAlertView+MKNetworkKitAdditions.h"
#elif TARGET_OS_MAC
#import "Categories/NSAlert+MKNetworkKitAdditions.h"
#endif

#import "Reachability/Reachability.h"

#import "MKNetworkOperation.h"
#import "MKNetworkEngine.h"

#define kMKNetworkEngineOperationCountChanged @"kMKNetworkEngineOperationCountChanged"
#define MKNETWORKCACHE_DEFAULT_COST 10
#define MKNETWORKCACHE_DEFAULT_DIRECTORY @"MKNetworkKitCache"
#define kMKNetworkKitDefaultCacheDuration 60 // 1 minute
#define kMKNetworkKitDefaultImageHeadRequestDuration 3600*24*1 // 1 day (HEAD requests with eTag are sent only after expiry of this. Not that these are not RFC compliant, but needed for performance tuning)
#define kMKNetworkKitDefaultImageCacheDuration 3600*24*7 // 1 day

// if your server takes longer than 30 seconds to provide real data,
// you should hire a better server developer.
// on iOS (or any mobile device), 30 seconds is already considered high.

#define kMKNetworkKitRequestTimeOutInSeconds 30
#endif


