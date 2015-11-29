//
//  SDImageCache+ASImageCacheProtocol.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/11/29.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import "SDImageCache+ASImageCacheProtocol.h"

@implementation SDImageCache (ASImageCacheProtocol)

- (void)fetchCachedImageWithURL:(NSURL *)URL
                  callbackQueue:(dispatch_queue_t)callbackQueue
                     completion:(void (^)(CGImageRef))completion {
    [[SDImageCache sharedImageCache] queryDiskCacheForKey:URL.absoluteString
                                                     done:^(UIImage *image, SDImageCacheType cacheType) {
                                                         dispatch_queue_t queue = callbackQueue ?: dispatch_get_main_queue();
                                                         dispatch_async(queue, ^{
                                                             if (completion) {
                                                                 completion(image.CGImage);
                                                             }
                                                         });
                                                     }];
}

@end
