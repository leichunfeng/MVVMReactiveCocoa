//
//  MRCLoginViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCLoginViewModel.h"
#import "MRCHomepageViewModel.h"

@implementation MRCLoginViewModel

- (void)initialize {
    [super initialize];
    
    RAC(self, avatarURL) = [[RACObserve(self, username)
        map:^id(NSString *username) {
            return [[OCTUser fetchUserWithRawLogin:username] avatarURL];
        }]
        distinctUntilChanged];
    
    RACSignal *validLoginSignal = [[RACSignal
    	combineLatest:@[RACObserve(self, username), RACObserve(self, password)] reduce:^id(NSString *username, NSString *password) {
        	return @(username.length > 0 && password.length > 0);
        }]
        distinctUntilChanged];
    
    @weakify(self)
    void (^doNext)(OCTClient *) = ^(OCTClient *authenticatedClient) {
        @strongify(self)
        self.services.client = authenticatedClient;
        [authenticatedClient.user save];
        
        SSKeychain.rawLogin    = authenticatedClient.user.rawLogin;
        SSKeychain.password    = self.password;
        SSKeychain.accessToken = authenticatedClient.token;
        
        MRCHomepageViewModel *viewModel = [[MRCHomepageViewModel alloc] initWithServices:self.services params:nil];
        [self.services resetRootViewModel:viewModel];
    };
    
    [OCTClient setClientID:MRC_CLIENT_ID clientSecret:MRC_CLIENT_SECRET];
    
    self.loginCommand = [[RACCommand alloc] initWithEnabled:validLoginSignal signalBlock:^RACSignal *(NSString *oneTimePassword) {
    	@strongify(self)
        OCTUser *user = [OCTUser userWithRawLogin:self.username server:OCTServer.dotComServer];
        return [[[OCTClient
        	signInAsUser:user password:self.password oneTimePassword:oneTimePassword scopes:OCTClientAuthorizationScopesUser note:nil noteURL:nil fingerprint:nil]
            deliverOnMainThread]
            doNext:doNext];
    }];

    self.browserLoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[[OCTClient
        	signInToServerUsingWebBrowser:OCTServer.dotComServer scopes:OCTClientAuthorizationScopesUser]
            deliverOnMainThread]
            doNext:doNext];
    }];
    
    [[RACSignal merge:@[ self.loginCommand.errors, self.browserLoginCommand.errors ]] subscribe:self.errors];
}

@end
