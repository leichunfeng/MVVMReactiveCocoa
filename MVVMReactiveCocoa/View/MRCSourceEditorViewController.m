//
//  MRCSourceEditorViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/2/3.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCSourceEditorViewController.h"
#import "MRCSourceEditorViewModel.h"

@interface MRCSourceEditorViewController () <UIWebViewDelegate>

@property (strong, nonatomic, readonly) MRCSourceEditorViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) WebViewJavascriptBridge *bridge;

@end

@implementation MRCSourceEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [WebViewJavascriptBridge enableLogging];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@"Response for message from ObjC");
    }];
    
    @weakify(self)
    [self.bridge registerHandler:@"getInitDataFromObjC" handler:^(id data, WVJBResponseCallback responseCallback) {
        @strongify(self)
        responseCallback(@{@"name": self.title,
                           @"rawContent": self.viewModel.rawContent,
                           @"content": self.viewModel.content ?: @"",
                           @"lineWrapping": @(self.viewModel.isLineWrapping)});
    }];
    
    [[self.viewModel.fetchBlobCommand execute:nil] subscribeNext:^(id x) {
        @strongify(self)
        [self loadSource];
    }];
}

- (void)bindViewModel {
    [super bindViewModel];
}

- (void)loadSource {
    if (self.viewModel.isMarkdown) {
        [self.webView loadData:[self.viewModel.content dataUsingEncoding:NSUTF8StringEncoding]
                      MIMEType:@"text/html"
              textEncodingName:@"utf-8"
                       baseURL:nil];
    } else {
        NSString *path = [NSBundle.mainBundle pathForResource:@"source-editor" ofType:@"html" inDirectory:@"assets.bundle"];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
        [self.webView loadRequest:request];
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
    [self loadSource];
}

@end
