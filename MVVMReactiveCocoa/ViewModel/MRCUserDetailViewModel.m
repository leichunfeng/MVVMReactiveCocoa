//
//  MRCUserDetailViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/16.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCUserDetailViewModel.h"

@interface MRCUserDetailViewModel ()

@property (strong, nonatomic, readwrite) NSString *company;
@property (strong, nonatomic, readwrite) NSString *location;
@property (strong, nonatomic, readwrite) NSString *email;
@property (strong, nonatomic, readwrite) NSString *blog;

@end

@implementation MRCUserDetailViewModel

@synthesize company = _company;
@synthesize location = _location;
@synthesize email = _email;
@synthesize blog = _blog;

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.user = params[@"user"];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    RAC(self, company, @"Not Set")  = RACObserve(self.user, company);
    RAC(self, location, @"Not Set") = RACObserve(self.user, location);
    RAC(self, email, @"Not Set")    = RACObserve(self.user, email);
    RAC(self, blog, @"Not Set")     = RACObserve(self.user, blog);
}

- (RACSignal *)requestRemoteDataSignal {
    return [[self.services.client
        fetchUserInfoWithUser:self.user]
        doNext:^(OCTUser *user) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.user mergeValuesForKeysFromModel:user];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self.user mrc_saveOrUpdate];
                });
            });
        }];
}

@end
