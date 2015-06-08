//
//  MRCAppStoreServiceImpl.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/3/6.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCAppStoreServiceImpl.h"

@implementation MRCAppStoreServiceImpl

- (RACSignal *)requestAppInfoFromAppStoreWithAppID:(NSString *)appID {
    return [[[RACSignal
        createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            MKNetworkEngine *networkEngine = [[MKNetworkEngine alloc] initWithHostName:@"itunes.apple.com"];
            
            MKNetworkOperation *operation = [networkEngine operationWithPath:@"lookup"
                                                                      params:@{ @"id": appID }
                                                                  httpMethod:@"GET"];
            
            [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
                [subscriber sendNext:completedOperation.responseJSON];
                [subscriber sendCompleted];
            } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
                [subscriber sendError:error];
            }];
            
            [networkEngine enqueueOperation:operation];
            
            return [RACDisposable disposableWithBlock:^{
                [operation cancel];
            }];
        }]
        replayLazily]
        setNameWithFormat:@"-requestAppInfoFromAppStoreWithAppID: %@", appID];
}

@end
