//
//  SSKeychain+MRCUtil.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/2/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "SSKeychain+MRCUtil.h"

@implementation SSKeychain (MRCUtil)

+ (NSString *)rawLogin {
    return [[NSUserDefaults standardUserDefaults] objectForKey:MRC_RAW_LOGIN];
}

+ (NSString *)password {
    return [self passwordForService:MRC_SERVICE_NAME account:MRC_PASSWORD];
}

+ (NSString *)accessToken {
    return [self passwordForService:MRC_SERVICE_NAME account:MRC_ACCESS_TOKEN];
}

+ (BOOL)setRawLogin:(NSString *)rawLogin {
    if (rawLogin == nil) NSLog(@"+setRawLogin: %@", rawLogin);
    
    [[NSUserDefaults standardUserDefaults] setObject:rawLogin forKey:MRC_RAW_LOGIN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}

+ (BOOL)setPassword:(NSString *)password {
    return [self setPassword:password forService:MRC_SERVICE_NAME account:MRC_PASSWORD];
}

+ (BOOL)setAccessToken:(NSString *)accessToken {
    return [self setPassword:accessToken forService:MRC_SERVICE_NAME account:MRC_ACCESS_TOKEN];
}

+ (BOOL)deleteRawLogin {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:MRC_RAW_LOGIN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}

+ (BOOL)deletePassword {
    return [self deletePasswordForService:MRC_SERVICE_NAME account:MRC_PASSWORD];
}

+ (BOOL)deleteAccessToken {
    return [self deletePasswordForService:MRC_SERVICE_NAME account:MRC_ACCESS_TOKEN];
}

@end
