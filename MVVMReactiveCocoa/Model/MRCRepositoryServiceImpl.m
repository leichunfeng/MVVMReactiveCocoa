//
//  MRCRepositoryServiceImpl.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/27.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepositoryServiceImpl.h"

@implementation MRCRepositoryServiceImpl

- (RACSignal *)requestRepositoryReadmeHTML:(OCTRepository *)repository reference:(NSString *)reference {
    return [[[RACSignal
        createSignal:^(id<RACSubscriber> subscriber) {
            NSString *accessToken   = [SSKeychain accessToken];
            NSString *authorization = [NSString stringWithFormat:@"token %@", accessToken];
            
            MKNetworkEngine *networkEngine = [[MKNetworkEngine alloc] initWithHostName:@"api.github.com"
                                                                    customHeaderFields:@{ @"Authorization": authorization}];
            
            NSString *path = [NSString stringWithFormat:@"repos/%@/%@/readme", repository.ownerLogin, repository.name];
            MKNetworkOperation *operation = [networkEngine operationWithPath:path
                                                                      params:@{ @"ref": reference }
                                                                  httpMethod:@"GET"
                                                                         ssl:YES];
            [operation addHeaders:@{ @"Accept": @"application/vnd.github.VERSION.html" }];
            [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [subscriber sendNext:completedOperation.responseString];
                    [subscriber sendCompleted];
                });
            } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [subscriber sendError:error];
                });
            }];
            
            [networkEngine enqueueOperation:operation];
            
            return [RACDisposable disposableWithBlock:^{
                [operation cancel];
            }];
        }]
        replayLazily]
        setNameWithFormat:@"-requestRepositoryReadmeHTML: %@ reference: %@", repository, reference];
}

- (RACSignal *)requestTrendingRepositoriesSince:(NSString *)since language:(NSString *)language {
    since    = since ?: @"";
    language = language ?: @"";
    
    return [[[[RACSignal
        createSignal:^(id<RACSubscriber> subscriber) {
            MKNetworkEngine *networkEngine = [[MKNetworkEngine alloc] init];
            
            NSString *URLString = [NSString stringWithFormat:@"http://trending.codehub-app.com/v2/trending?since=%@&language=%@", since, language];
            URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            MKNetworkOperation *operation = [networkEngine operationWithURLString:URLString];

            [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSArray *JSONArray = completedOperation.responseJSON;
                    if (JSONArray.count > 0) {
                        NSError *error = nil;
                        NSArray *repositories = [MTLJSONAdapter modelsOfClass:[OCTRepository class] fromJSONArray:JSONArray error:&error];

                        if (error) {
                            MRCLogError(error);
                        } else {
                            [subscriber sendNext:repositories];
                        }
                    }
                    [subscriber sendCompleted];
                });
            } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                	[subscriber sendError:error];
                });
            }];

            [networkEngine enqueueOperation:operation];

            return [RACDisposable disposableWithBlock:^{
            	[operation cancel];
            }];
        }]
        replayLazily]
        doNext:^(NSArray *repositories) {
            [[YYCache sharedCache] setObject:repositories forKey:MRCExploreTrendingReposCacheKey withBlock:NULL];
        }]
        setNameWithFormat:@"-requestTrendingRepositoriesSince: %@ language: %@", since, language];
}

- (RACSignal *)requestShowcases {
    return [[[RACSignal
        createSignal:^(id<RACSubscriber> subscriber) {
            MKNetworkEngine *networkEngine = [[MKNetworkEngine alloc] init];
            
            NSString *URLString = @"http://trending.codehub-app.com/v2/showcases";
            MKNetworkOperation *operation = [networkEngine operationWithURLString:URLString];
            
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
        doNext:^(NSArray *showcases) {
            [[YYCache sharedCache] setObject:showcases forKey:MRCExploreShowcasesCacheKey withBlock:NULL];
        }];
}

- (RACSignal *)requestShowcaseRepositoriesWithSlug:(NSString *)slug {
    NSParameterAssert(slug.length > 0);
    return [[RACSignal
        createSignal:^(id<RACSubscriber> subscriber) {
            MKNetworkEngine *networkEngine = [[MKNetworkEngine alloc] init];
            
            NSString *URLString = [NSString stringWithFormat:@"http://trending.codehub-app.com/v2/showcases/%@", slug];
            MKNetworkOperation *operation = [networkEngine operationWithURLString:URLString];
            
            [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
                NSArray *JSONArray = completedOperation.responseJSON[@"repositories"];
                
                NSError *error = nil;
                NSArray *repositories = [MTLJSONAdapter modelsOfClass:[OCTRepository class] fromJSONArray:JSONArray error:&error];
                
                if (error) {
                    MRCLogError(error);
                } else {
                    [subscriber sendNext:repositories];
                }
                
                [subscriber sendCompleted];
            } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
                [subscriber sendError:error];
            }];
            
            [networkEngine enqueueOperation:operation];
            
            return [RACDisposable disposableWithBlock:^{
                [operation cancel];
            }];
        }]
        replayLazily];
}

@end
