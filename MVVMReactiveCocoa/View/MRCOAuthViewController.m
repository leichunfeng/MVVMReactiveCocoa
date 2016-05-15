//
//  MRCOAuthViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/5/15.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCOAuthViewController.h"
#import "MRCOAuthViewModel.h"

@interface MRCOAuthViewController ()

@property (nonatomic, strong, readonly) MRCOAuthViewModel *viewModel;

@end

@implementation MRCOAuthViewController

@dynamic viewModel;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([request.URL.scheme isEqualToString:MRC_URL_SCHEME]) {
        NSDictionary *queryArguments = request.URL.oct_queryArguments;
        if ([queryArguments[@"state"] isEqual:self.viewModel.UUIDString]) {
            if (self.viewModel.callback) {
                self.viewModel.callback(queryArguments[@"code"]);
            }
        }
        return NO;
    }
    
    if (navigationType == UIWebViewNavigationTypeOther) {
        return [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    } else {
        return YES;
    }
}

@end
