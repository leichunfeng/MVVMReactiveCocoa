//
//  MRCLoginViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCLoginViewModel.h"
#import "MRCHomepageViewModel.h"
#import "MRCOAuthViewModel.h"

@interface MRCLoginViewModel ()

@property (nonatomic, copy, readwrite) NSURL *avatarURL;

@property (nonatomic, strong, readwrite) RACSignal *validLoginSignal;
@property (nonatomic, strong, readwrite) RACCommand *loginCommand;
@property (nonatomic, strong, readwrite) RACCommand *browserLoginCommand;
@property (nonatomic, strong, readwrite) RACCommand *exchangeTokenCommand;

@end

@implementation MRCLoginViewModel

- (void)initialize {
    [super initialize];
    
    RAC(self, avatarURL) = [[RACObserve(self, username)
        map:^(NSString *username) {
            return [[OCTUser mrc_fetchUserWithRawLogin:username] avatarURL];
        }]
        distinctUntilChanged];
    
    self.validLoginSignal = [[RACSignal
    	combineLatest:@[ RACObserve(self, username), RACObserve(self, password) ]
        reduce:^(NSString *username, NSString *password) {
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
    
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^(NSString *oneTimePassword) {
    	@strongify(self)
        OCTUser *user = [OCTUser userWithRawLogin:self.username server:OCTServer.dotComServer];
        return [[OCTClient
        	signInAsUser:user password:self.password oneTimePassword:oneTimePassword scopes:OCTClientAuthorizationScopesUser | OCTClientAuthorizationScopesRepository note:nil noteURL:nil fingerprint:nil]
            doNext:doNext];
    }];

    self.browserLoginCommand = [[RACCommand alloc] initWithSignalBlock:^(id input) {
        @strongify(self)
        
        MRCOAuthViewModel *viewModel = [[MRCOAuthViewModel alloc] initWithServices:self.services params:nil];
        
        viewModel.callback = ^(NSString *code) {
            @strongify(self)
            [self.services popViewModelAnimated:YES];
            [self.exchangeTokenCommand execute:code];
        };
        
        [self.services pushViewModel:viewModel animated:YES];
        
        return [RACSignal empty];
    }];
    
    self.exchangeTokenCommand = [[RACCommand alloc] initWithSignalBlock:^(NSString *code) {
        OCTClient *client = [[OCTClient alloc] initWithServer:[OCTServer dotComServer]];
        
        return [[[[[client
            exchangeAccessTokenWithCode:code]
            doNext:^(OCTAccessToken *accessToken) {
                [client setValue:accessToken.token forKey:@"token"];
            }]
            flattenMap:^(id value) {
                return [[client
                    fetchUserInfo]
                    doNext:^(OCTUser *user) {
                        NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
                        
                        [mutableDictionary addEntriesFromDictionary:user.dictionaryValue];
                        
                        if (user.rawLogin.length == 0) {
                            mutableDictionary[@keypath(user.rawLogin)] = user.login;
                        }
                        
                        user = [OCTUser modelWithDictionary:mutableDictionary error:NULL];
                        
                        [client setValue:user forKey:@"user"];
                    }];
            }]
            mapReplace:client]
            doNext:doNext];
    }];
}

- (void)setUsername:(NSString *)username {
    _username = [username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
