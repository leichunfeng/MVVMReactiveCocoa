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

@property (nonatomic, strong, readonly) MRCSourceEditorViewModel *viewModel;
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;

@end

@implementation MRCSourceEditorViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.scalesPageToFit = self.viewModel.options & MRCSourceEditorViewModelOptionsScalesPageToFit;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"]
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:nil
                                                                          action:NULL];
    
    RAC(self.navigationItem, rightBarButtonItem) = [[RACObserve(self.viewModel, options)
        distinctUntilChanged]
        map:^(NSNumber *options) {
            if (options.unsignedIntegerValue & MRCSourceEditorViewModelOptionsEnableWrapping ||
                options.unsignedIntegerValue & MRCSourceEditorViewModelOptionsShowRawMarkdown) {
                return rightBarButtonItem;
            }
            return (UIBarButtonItem *)nil;
        }];

    @weakify(self)
    rightBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^(id input) {
        @strongify(self)
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
        
        if (self.viewModel.options & MRCSourceEditorViewModelOptionsEnableWrapping) {
            NSString *title = self.viewModel.lineWrapping ? @"Disable wrapping": @"Enable wrapping";
            UIAlertAction *action = [UIAlertAction actionWithTitle:title
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
                                                               @strongify(self)
                                                               self.viewModel.lineWrapping = !self.viewModel.lineWrapping;
                                                               [self reloadData];
                                                           }];
            [alertController addAction:action];
        }
        
        if (self.viewModel.options & MRCSourceEditorViewModelOptionsShowRawMarkdown) {
            NSString *title = self.viewModel.showRawMarkdown ? @"Render markdown": @"Show raw markdown";
            UIAlertAction *action = [UIAlertAction actionWithTitle:title
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
                                                               @strongify(self)
                                                               
                                                               self.viewModel.showRawMarkdown = !self.viewModel.showRawMarkdown;
                                                               if (self.viewModel.showRawMarkdown) {
                                                                   if (self.viewModel.UTF8String.length > 0) {
                                                                       [self reloadData];
                                                                   } else {
                                                                       if (self.viewModel.entry == MRCSourceEditorViewModelEntryGitTree) {
                                                                           [self.viewModel.requestContentsCommand execute:@(OCTClientMediaTypeRaw)];
                                                                       } else if (self.viewModel.entry == MRCSourceEditorViewModelEntryRepoDetail) {
                                                                           [self.viewModel.requestReadmeCommand execute:@(OCTClientMediaTypeRaw)];
                                                                       }
                                                                   }
                                                               } else {
                                                                   [self reloadData];
                                                               }
                                                           }];
            [alertController addAction:action];
        }
        
        if (!isPad) [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL]];
        
        alertController.popoverPresentationController.barButtonItem = rightBarButtonItem;
        [self presentViewController:alertController animated:YES completion:NULL];
        
        return [RACSignal empty];
    }];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView
                                            webViewDelegate:self
                                                    handler:^(id data, WVJBResponseCallback responseCallback) {
                                                        responseCallback(@"Response for message from ObjC");
                                                    }];
    
    [self.bridge registerHandler:@"getInitDataFromObjC" handler:^(id data, WVJBResponseCallback responseCallback) {
        @strongify(self)
        responseCallback(@{ @"title": self.viewModel.title ?: @"",
                            @"Base64String": self.viewModel.Base64String ?: @"",
                            @"UTF8String": self.viewModel.UTF8String ?: @"",
                            @"lineWrapping": @(self.viewModel.lineWrapping) });
    }];
    
    [[RACSignal
     	merge:@[
            self.viewModel.requestContentsCommand.executing,
            self.viewModel.requestReadmeCommand.executing,
        ]]
     	subscribeNext:^(NSNumber *executing) {
         	@strongify(self)
            if (executing.boolValue) {
                [MBProgressHUD showHUDAddedTo:self.view animated:YES].labelText = MBPROGRESSHUD_LABEL_TEXT;
            } else {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        }];
    
    [[RACObserve(self.viewModel, Base64String)
        ignore:nil]
        subscribeNext:^(id x) {
            @strongify(self)
            [self reloadData];
        }];
    
    [[RACObserve(self.viewModel, UTF8String)
        ignore:nil]
        subscribeNext:^(id x) {
            @strongify(self)
            [self reloadData];
        }];
    
    [[RACObserve(self.viewModel, HTMLString)
        ignore:nil]
        subscribeNext:^(id x) {
            @strongify(self)
            [self reloadData];
        }];
}

- (void)reloadData {
    if (self.viewModel.contentType == MRCSourceEditorViewModelContentTypeMarkdown &&
        !self.viewModel.showRawMarkdown) { // load HTMLString
        // baseURL
        // https://github.com/leichunfeng/MVVMReactiveCocoa/raw/master/
        // https://github.com/leichunfeng/MVVMReactiveCocoa/raw/v2.1.1/
        //
        // fullURL
        // https://github.com/leichunfeng/MVVMReactiveCocoa/raw/master/OmniGraffle/MVVMReactiveCocoa.png
        // https://github.com/leichunfeng/MVVMReactiveCocoa/raw/v2.1.1/OmniGraffle/MVVMReactiveCocoa.png
        
        NSString *domain     = [OCTServer dotComServer].baseWebURL.absoluteString;
        NSString *ownerLogin = self.viewModel.repository.ownerLogin;
        NSString *name       = self.viewModel.repository.name;
        NSString *branch     = [self.viewModel.reference.name componentsSeparatedByString:@"/"].lastObject;
        
        NSString *URLString = [NSString stringWithFormat:@"%@/%@/%@/raw/%@/", domain, ownerLogin, name, branch];
        NSURL *baseURL = [NSURL URLWithString:URLString];
        
        [self.webView loadHTMLString:[MRC_README_CSS_STYLE stringByAppendingString:self.viewModel.HTMLString] baseURL:baseURL];
    } else {
        [self.webView loadRequest:self.viewModel.request];
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return isPad ? UIInterfaceOrientationMaskLandscape : UIInterfaceOrientationMaskAllButUpsideDown;
}

@end
