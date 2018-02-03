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

@property (nonatomic, weak, readwrite) IBOutlet UIWebView *webView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *webViewTopConstraint;
@property (nonatomic, strong, readonly) MRCWebViewModel *viewModel;

@end

@implementation MRCWebViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (iPhoneX) {
        if (IOS11) {
            self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    RACSignal *didFinishLoadSignal   = [self rac_signalForSelector:@selector(webViewDidFinishLoad:) fromProtocol:@protocol(UIWebViewDelegate)];
    RACSignal *didFailLoadLoadSignal = [self rac_signalForSelector:@selector(webView:didFailLoadWithError:) fromProtocol:@protocol(UIWebViewDelegate)];
    
    MRCTitleViewType type = self.viewModel.titleViewType;
    RAC(self.viewModel, titleViewType) = [[RACSignal
        merge:@[ didFinishLoadSignal, didFailLoadLoadSignal ]]
        mapReplace:@(type)];
    
    NSParameterAssert(self.viewModel.request);
    
    [self.webView loadRequest:self.viewModel.request];
}

#ifdef __IPHONE_11_0

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    
    if (iPhoneX) {
        self.webViewTopConstraint.constant = self.view.safeAreaInsets.top;
    }
}

#endif

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeOther) {
        if ([request.URL.scheme isEqualToString:@"http"] || [request.URL.scheme isEqualToString:@"https"]) {
            self.viewModel.titleViewType = MRCTitleViewTypeLoadingTitle;
        }
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
