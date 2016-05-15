//
//  MRCOAuthViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/5/15.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCOAuthViewModel.h"

@interface MRCOAuthViewModel ()

@property (nonatomic, copy, readwrite) NSString *UUIDString;

@end

@implementation MRCOAuthViewModel

- (void)initialize {
    [super initialize];
    
    self.title = @"OAuth2 Authorization Login";

    CFUUIDRef UUID = CFUUIDCreate(NULL);
    self.UUIDString = CFBridgingRelease(CFUUIDCreateString(NULL, UUID));
    CFRelease(UUID);
    
    NSString *URLString = [[NSString alloc] initWithFormat:@"https://github.com/login/oauth/authorize?client_id=%@&scope=%@&state=%@", MRC_CLIENT_ID, @"user,repo", self.UUIDString];
    NSURL *URL = [NSURL URLWithString:URLString];
    
    self.request = [NSURLRequest requestWithURL:URL];
}

@end
