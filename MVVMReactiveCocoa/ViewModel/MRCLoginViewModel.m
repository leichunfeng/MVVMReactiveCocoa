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
        	return @(username.length >= 6 && password.length >= 6);
        }]
        distinctUntilChanged];
    
    [OCTClient setClientID:MRC_CLIENT_ID clientSecret:MRC_CLIENT_SECRET];
    
    @weakify(self)
    self.loginCommand = [[RACCommand alloc] initWithEnabled:validLoginSignal signalBlock:^RACSignal *(id input) {
    	@strongify(self)
        OCTUser *user = [OCTUser userWithRawLogin:self.username server:OCTServer.dotComServer];
        return [[OCTClient
        	signInAsUser:user password:self.password oneTimePassword:nil scopes:OCTClientAuthorizationScopesUser note:nil noteURL:nil fingerprint:nil]
            doNext:^(OCTClient *authenticatedClient) {
                @strongify(self)
                [self handleWithAuthenticatedClient:authenticatedClient];
            }];
    }];

    self.browserLoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[OCTClient
        	signInToServerUsingWebBrowser:OCTServer.dotComServer scopes:OCTClientAuthorizationScopesUser]
            doNext:^(OCTClient *authenticatedClient) {
            	@strongify(self)
                [self handleWithAuthenticatedClient:authenticatedClient];
            }];
    }];
}

- (void)handleWithAuthenticatedClient:(OCTClient *)authenticatedClient {
    [self.services setClient:authenticatedClient];
    
    [authenticatedClient.user save];
    
    [SSKeychain setPassword:authenticatedClient.user.rawLogin forService:MRC_SERVICE_NAME account:MRC_RAW_LOGIN];
    [SSKeychain setPassword:authenticatedClient.token forService:MRC_SERVICE_NAME account:MRC_ACCESS_TOKEN];
    
    MRCHomepageViewModel *viewModel = [[MRCHomepageViewModel alloc] initWithServices:self.services params:nil];
    [self.services resetRootViewModel:viewModel];
}

@end
