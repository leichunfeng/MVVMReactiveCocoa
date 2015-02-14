//
//  SSKeychain+MRCUtil.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/2/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "SSKeychain.h"

@interface SSKeychain (MRCUtil)

+ (NSString *)rawLogin;
+ (NSString *)password;
+ (NSString *)accessToken;

+ (BOOL)setRawLogin:(NSString *)rawLogin;
+ (BOOL)setPassword:(NSString *)password;
+ (BOOL)setAccessToken:(NSString *)accessToken;

+ (BOOL)deleteRawLogin;
+ (BOOL)deletePassword;
+ (BOOL)deleteAccessToken;

@end
