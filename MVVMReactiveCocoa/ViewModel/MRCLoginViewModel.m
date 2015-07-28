//
//  MRCLoginViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCLoginViewModel.h"
#import "MRCHomepageViewModel.h"

@interface MRCLoginViewModel ()

@property (copy, nonatomic, readwrite) NSURL *avatarURL;

@property (strong, nonatomic, readwrite) RACSignal *validLoginSignal;
@property (strong, nonatomic, readwrite) RACCommand *loginCommand;
@property (strong, nonatomic, readwrite) RACCommand *browserLoginCommand;

@end

@implementation MRCLoginViewModel

- (void)initialize {
    [super initialize];
    
    RAC(self, avatarURL) = [[RACObserve(self, username)
        map:^id(NSString *username) {
            return [[OCTUser mrc_fetchUserWithRawLogin:username] avatarURL];
        }]
        distinctUntilChanged];
    
    self.validLoginSignal = [[RACSignal
    	combineLatest:@[RACObserve(self, username), RACObserve(self, password)] reduce:^id(NSString *username, NSString *password) {
        	return @(username.length > 0 && password.length > 0);
        }]
        distinctUntilChanged];
    
    @weakify(self)
    void (^doNext)(OCTClient *) = ^(OCTClient *authenticatedClient) {
        @strongify(self)
        [[MRCMemoryCache sharedInstance] setObject:authenticatedClient.user forKey:@"currentUser"];

        self.services.client = authenticatedClient;

        [authenticatedClient.user mrc_saveOrUpdate];
        [authenticatedClient.user mrc_updateRawLogin]; // The only place to update rawLogin, I hate the logic of rawLogin.
        
        SSKeychain.rawLogin = authenticatedClient.user.rawLogin;
        SSKeychain.password = self.password;
        SSKeychain.accessToken = authenticatedClient.token;
        
        MRCHomepageViewModel *viewModel = [[MRCHomepageViewModel alloc] initWithServices:self.services params:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.services resetRootViewModel:viewModel];
        });
    };
    
    [OCTClient setClientID:MRC_CLIENT_ID clientSecret:MRC_CLIENT_SECRET];
    
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString *oneTimePassword) {
    	@strongify(self)
        OCTUser *user = [OCTUser userWithRawLogin:self.username server:OCTServer.dotComServer];
        return [[OCTClient
        	signInAsUser:user password:self.password oneTimePassword:oneTimePassword scopes:OCTClientAuthorizationScopesUser | OCTClientAuthorizationScopesRepository note:nil noteURL:nil fingerprint:nil]
            doNext:doNext];
    }];

    self.browserLoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[OCTClient
        	signInToServerUsingWebBrowser:OCTServer.dotComServer scopes:OCTClientAuthorizationScopesUser | OCTClientAuthorizationScopesRepository]
            doNext:doNext];
    }];    
}

@end
