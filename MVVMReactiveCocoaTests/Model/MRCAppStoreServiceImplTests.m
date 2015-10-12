//
//  MRCAppStoreServiceImplTests.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/3/6.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MRCAppStoreServiceImpl.h"

@interface MRCAppStoreServiceImplTests : XCTestCase

@property (nonatomic, strong) MRCAppStoreServiceImpl *appStoreService;

@end

@implementation MRCAppStoreServiceImplTests

- (void)setUp {
    [super setUp];
    self.appStoreService = [[MRCAppStoreServiceImpl alloc] init];
}

- (void)testRequestAppInfoFromAppStoreWithAppID {
    XCTestExpectation *expectation = [self expectationWithDescription:nil];
    
    [[self.appStoreService requestAppInfoFromAppStoreWithAppID:@"901665459"] subscribeNext:^(id x) {
        [expectation fulfill];
    } error:^(NSError *error) {
        
    } completed:^{
        
    }];
    
    [self waitForExpectationsWithTimeout:60 handler:nil];
}

@end
