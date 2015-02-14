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
    return [self passwordForService:MRC_SERVICE_NAME account:MRC_RAW_LOGIN];
}

+ (NSString *)password {
    return [self passwordForService:MRC_SERVICE_NAME account:MRC_PASSWORD];
}

+ (NSString *)accessToken {
    return [self passwordForService:MRC_SERVICE_NAME account:MRC_ACCESS_TOKEN];
}

+ (BOOL)setRawLogin:(NSString *)rawLogin {
    return [self setPassword:rawLogin forService:MRC_SERVICE_NAME account:MRC_RAW_LOGIN];
}

+ (BOOL)setPassword:(NSString *)password {
    return [self setPassword:password forService:MRC_SERVICE_NAME account:MRC_PASSWORD];
}

+ (BOOL)setAccessToken:(NSString *)accessToken {
    return [self setPassword:accessToken forService:MRC_SERVICE_NAME account:MRC_ACCESS_TOKEN];
}

+ (BOOL)deleteRawLogin {
    return [self deletePasswordForService:MRC_SERVICE_NAME account:MRC_RAW_LOGIN];
}

+ (BOOL)deletePassword {
    return [self deletePasswordForService:MRC_SERVICE_NAME account:MRC_PASSWORD];
}

+ (BOOL)deleteAccessToken {
    return [self deletePasswordForService:MRC_SERVICE_NAME account:MRC_ACCESS_TOKEN];
}

@end
