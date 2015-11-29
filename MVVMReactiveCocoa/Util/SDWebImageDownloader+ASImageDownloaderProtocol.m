//
//  SDWebImageDownloader+ASImageDownloaderProtocol.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/11/29.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import "SDWebImageDownloader+ASImageDownloaderProtocol.h"

@implementation SDWebImageDownloader (ASImageDownloaderProtocol)

- (id<SDWebImageOperation>)downloadImageWithURL:(NSURL *)URL
                                  callbackQueue:(dispatch_queue_t)callbackQueue
                          downloadProgressBlock:(void (^)(CGFloat progress))downloadProgressBlock
                                     completion:(void (^)(CGImageRef image, NSError *error))completion {
    dispatch_queue_t queue = callbackQueue ?: dispatch_get_main_queue();
    return [self downloadImageWithURL:URL
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 if (expectedSize != NSURLResponseUnknownLength) {
                                     dispatch_async(queue, ^{
                                         if (downloadProgressBlock) {
                                             downloadProgressBlock(1.0 * receivedSize / expectedSize);
                                         }
                                     });
                                 }
                             }
                            completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                if (finished) {
                                    if (image != nil) {
                                        [[SDImageCache sharedImageCache] storeImage:image forKey:URL.absoluteString];
                                    }
                                    dispatch_async(queue, ^{
                                        if (completion) {
                                            completion(image.CGImage, error);
                                        }
                                    });
                                }
                            }];
}

- (void)cancelImageDownloadForIdentifier:(id<SDWebImageOperation>)downloadIdentifier {
    [downloadIdentifier cancel];
}

@end
