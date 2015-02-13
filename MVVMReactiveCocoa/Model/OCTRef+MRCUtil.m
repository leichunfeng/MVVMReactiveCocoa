//
//  OCTRef+MRCUtil.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/2/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "OCTRef+MRCUtil.h"

@implementation OCTRef (MRCUtil)

- (NSString *)octiconIdentifier {
    NSArray *components = [self.name componentsSeparatedByString:@"/"];
    if (components.count == 3) {
        if ([components[1] isEqualToString:@"heads"]) { // refs/heads/master
            return @"GitBranch";
        } else if ([components[1] isEqualToString:@"tags"]) { // refs/tags/v0.0.1
            return @"Tag";
        }
    }
    return @"GitBranch";
}

@end
