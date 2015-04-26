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
@property (strong, nonatomic) WebViewJavascriptBridge *bridge;

@end

@implementation MRCSourceEditorViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"]
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:nil
                                                                          action:NULL];
    @weakify(self)
    rightBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
        if (!self.viewModel.isMarkdown || self.viewModel.showRawMarkdown) {
            [alertController addAction:[UIAlertAction actionWithTitle:self.viewModel.wrappingActionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                @strongify(self)
                self.viewModel.lineWrapping = !self.viewModel.isLineWrapping;
                [self loadSource];
            }]];
        }
        if (self.viewModel.isMarkdown) {
            [alertController addAction:[UIAlertAction actionWithTitle:self.viewModel.markdownActionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                @strongify(self)
                self.viewModel.showRawMarkdown = !self.viewModel.showRawMarkdown;
                if (self.viewModel.showRawMarkdown && !self.viewModel.rawContent) {
                    if (self.viewModel.type == MRCSourceEditorViewModelTypeBlob) {
                        [[self.viewModel.requestBlobCommand execute:nil] subscribeNext:^(id x) {
                            @strongify(self)
                            [self loadSource];
                        }];
                    } else if (self.viewModel.type == MRCSourceEditorViewModelTypeReadme) {
                        [[self.viewModel.requestReadmeCommand execute:nil] subscribeNext:^(id x) {
                            @strongify(self)
                            [self loadSource];
                        }];
                    }
                } else {
                    [self loadSource];
                }
            }]];
        }
        
        if (!isPad) [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL]];
        
        alertController.popoverPresentationController.barButtonItem = rightBarButtonItem;
        [self presentViewController:alertController animated:YES completion:NULL];
        
        return [RACSignal empty];
    }];
    
    [WebViewJavascriptBridge enableLogging];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@"Response for message from ObjC");
    }];
    
    [self.bridge registerHandler:@"getInitDataFromObjC" handler:^(id data, WVJBResponseCallback responseCallback) {
        @strongify(self)
        responseCallback(@{@"name": self.viewModel.title,
                           @"rawContent": self.viewModel.rawContent ?: @"",
                           @"content": self.viewModel.content ?: @"",
                           @"lineWrapping": @(self.viewModel.isLineWrapping)});
    }];
    
    [[RACSignal
     	merge:@[
            self.viewModel.requestReadmeCommand.executing,
            self.viewModel.requestBlobCommand.executing,
            self.viewModel.requestRenderedMarkdownCommand.executing
        ]]
     	subscribeNext:^(NSNumber *executing) {
         	@strongify(self)
            if (executing.boolValue) {
                [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = MBPROGRESSHUD_LABEL_TEXT;
            } else {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        }];
    
    if (self.viewModel.isMarkdown) {
        if (self.viewModel.readmeHTMLString) {
            self.navigationItem.rightBarButtonItem = rightBarButtonItem;
            [self loadSource];
        } else {
            [[self.viewModel.requestRenderedMarkdownCommand execute:nil] subscribeNext:^(id x) {
                @strongify(self)
                self.navigationItem.rightBarButtonItem = rightBarButtonItem;
                [self loadSource];
            }];
        }
    } else {
        [[[self.viewModel.requestBlobCommand
           	execute:nil]
            deliverOnMainThread]
            subscribeNext:^(id x) {
                @strongify(self)
                self.navigationItem.rightBarButtonItem = rightBarButtonItem;
                [self loadSource];
            }];
    }
}

- (void)loadSource {
    if (self.viewModel.isMarkdown && !self.viewModel.showRawMarkdown) {
        [self.webView loadHTMLString:[MRC_README_CSS_STYLE stringByAppendingString:self.viewModel.content] baseURL:nil];
    } else {
        [self.webView loadRequest:self.viewModel.request];
    }
}

- (NSUInteger)supportedInterfaceOrientations {
    return isPad ? UIInterfaceOrientationMaskLandscape : UIInterfaceOrientationMaskAllButUpsideDown;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return navigationType == UIWebViewNavigationTypeOther;
}

@end
