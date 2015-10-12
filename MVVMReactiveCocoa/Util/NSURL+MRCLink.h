//
//  NSURL+MRCLink.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/13.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MRCLinkType) {
    MRCLinkTypeUnknown,
    MRCLinkTypeUser,
    MRCLinkTypeRepository
};

@interface NSURL (MRCLink)

@property (nonatomic, assign, readonly) MRCLinkType type;

+ (instancetype)mrc_userLinkWithLogin:(NSString *)login;
+ (instancetype)mrc_repositoryLinkWithName:(NSString *)name referenceName:(NSString *)referenceName;

- (NSDictionary *)mrc_dictionary;

@end

@interface OCTEvent (MRCLink)

- (NSURL *)mrc_Link;

@end
