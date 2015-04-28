//
//  MRCWebViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/24.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCWebViewController.h"
#import "MRCWebViewModel.h"

@interface MRCWebViewController ()

@property (strong, nonatomic, readonly) MRCWebViewModel *viewModel;

@end

@implementation MRCWebViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.viewModel.request != nil) {
        [self.webView loadRequest:self.viewModel.request];
    }
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeOther) {
        return YES;
    } else {
        [UIApplication.sharedApplication openURL:request.URL];
        return NO;
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {}

- (void)webViewDidFinishLoad:(UIWebView *)webView {}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {}

@end
