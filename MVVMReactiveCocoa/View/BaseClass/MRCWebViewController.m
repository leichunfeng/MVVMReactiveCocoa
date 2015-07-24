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
@property (assign, nonatomic) BOOL showProgressHUD;

@end

@implementation MRCWebViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    @weakify(self)
//    [[[RACObserve(self, showProgressHUD)
//        skip:1]
//        distinctUntilChanged]
//        subscribeNext:^(NSNumber *showProgressHUD) {
//            @strongify(self)
//            if (showProgressHUD.boolValue) {
//                [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = MBPROGRESSHUD_LABEL_TEXT;
//            } else {
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
//            }
//        }];
    
    NSParameterAssert(self.viewModel.request);
    
    [self.webView loadRequest:self.viewModel.request];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeOther) {
        if ([request.URL.scheme isEqualToString:@"http"] || [request.URL.scheme isEqualToString:@"https"]) {
//            self.showProgressHUD = YES;
            self.viewModel.titleViewType = MRCTitleViewTypeLoadingTitle;
        }
        return YES;
    } else {
        [UIApplication.sharedApplication openURL:request.URL];
        return NO;
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    self.showProgressHUD = NO;
    self.viewModel.titleViewType = MRCTitleViewTypeDefault;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    self.showProgressHUD = NO;
    self.viewModel.titleViewType = MRCTitleViewTypeDefault;

    [self.viewModel.errors sendNext:error];
}

@end
