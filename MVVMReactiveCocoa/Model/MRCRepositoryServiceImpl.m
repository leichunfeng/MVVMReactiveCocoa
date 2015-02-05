//
//  MRCRepositoryServiceImpl.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/27.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepositoryServiceImpl.h"

@implementation MRCRepositoryServiceImpl

- (RACSignal *)requestRepositoryReadmeRenderedHTML:(OCTRepository *)repository reference:(NSString *)reference {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString *accessToken   = [SSKeychain passwordForService:MRC_SERVICE_NAME account:MRC_ACCESS_TOKEN];
        NSString *authorization = [NSString stringWithFormat:@"token %@", accessToken];
        
        MKNetworkEngine *networkEngine = [[MKNetworkEngine alloc] initWithHostName:@"api.github.com"
                                                                customHeaderFields:@{ @"Authorization": authorization}];
        
        NSString *path = [NSString stringWithFormat:@"repos/%@/%@/readme", repository.ownerLogin, repository.name];
        MKNetworkOperation *operation = [networkEngine operationWithPath:path
                                                                  params:@{@"ref": reference}
                                                              httpMethod:@"GET"
                                                                     ssl:YES];
        [operation addHeaders:@{ @"Accept": @"application/vnd.github.VERSION.html" }];
        [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            [subscriber sendNext:completedOperation.responseString];
            [subscriber sendCompleted];
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            [subscriber sendError:error];
        }];
        
        [networkEngine enqueueOperation:operation];
        
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }];
}

@end
