//
//  NSURL+MRCLink.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/13.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "NSURL+MRCLink.h"

#define MRCLinkUserScheme @"user"
#define MRCLinkRepositoryScheme @"repository"

@implementation NSURL (MRCLink)

- (MRCLinkType)type {
    if ([self.scheme isEqualToString:MRCLinkUserScheme]) {
        return MRCLinkTypeUser;
    } else if ([self.scheme isEqualToString:MRCLinkRepositoryScheme]) {
        return MRCLinkTypeRepository;
    }
    return MRCLinkTypeUnknown;
}

+ (instancetype)mrc_userLinkWithLogin:(NSString *)login {
    NSParameterAssert(login.length > 0);
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@", MRCLinkUserScheme, login]];;
}

+ (instancetype)mrc_repositoryLinkWithName:(NSString *)name branch:(NSString *)branch {
    NSParameterAssert(name.length > 0);
    
    branch = branch ?: @"master"; // FIXME
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@?branch=%@", MRCLinkRepositoryScheme, name, branch]];;
}

- (NSDictionary *)mrc_dictionary {
    if (self.type == MRCLinkTypeUser) {
        return @{ @"login": self.host ?: @"" };
    } else if (self.type == MRCLinkTypeRepository) {
        return @{ @"ownerLogin": self.host ?: @"",
                  @"name": [self.path substringFromIndex:1] ?: @"",
                  @"branch": [self.query componentsSeparatedByString:@"="].lastObject ?: @"" };
    }
    return nil;
}

@end
