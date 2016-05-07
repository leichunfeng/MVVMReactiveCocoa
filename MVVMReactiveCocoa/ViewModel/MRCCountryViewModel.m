//
//  MRCCountryViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/5/7.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCCountryViewModel.h"

@implementation MRCCountryViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(NSDictionary *)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.item = params[@"country"];
    }
    return self;
}

- (NSString *)title {
    return @"Country";
}

- (NSString *)resourceName {
    return @"Countries";
}

@end
