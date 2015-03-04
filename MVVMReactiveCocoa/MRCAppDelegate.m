//
//  MRCAppDelegate.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCAppDelegate.h"
#import "MRCViewModelServicesImpl.h"
#import "MRCLoginViewModel.h"
#import "MRCLoginViewController.h"
#import "MRCHomepageViewModel.h"
#import "MRCHomepageViewController.h"
#import "MRCNavigationControllerStack.h"
#import "MRCWebViewModel.h"
#import "MRCWebViewController.h"
#import "MRCNavigationController.h"

@interface MRCAppDelegate ()

@property (strong, nonatomic) MRCViewModelServicesImpl *services;
@property (strong, nonatomic) id<MRCViewModelProtocol> viewModel;

@end

@implementation MRCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.services = [MRCViewModelServicesImpl new];
    self.navigationControllerStack = [[MRCNavigationControllerStack alloc] initWithServices:self.services];

    UINavigationController *navigationController = [[MRCNavigationController alloc] initWithRootViewController:self.createInitialViewController];
    [self.navigationControllerStack pushNavigationController:navigationController];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    [self configureAppearance];
    [self configureKeyboardManager];
    
    AFNetworkActivityIndicatorManager.sharedManager.enabled = YES;
    
    NSLog(@"MRC_DOCUMENT_DIRECTORY: %@", MRC_DOCUMENT_DIRECTORY);
    
    return YES;
}

- (UIViewController *)createInitialViewController {
    [SSKeychain deleteAccessToken];
    
    // The user has logged-in.
    if (SSKeychain.rawLogin.isExist && SSKeychain.accessToken.isExist) {
        OCTUser *user = [OCTUser userWithRawLogin:SSKeychain.rawLogin server:OCTServer.dotComServer];

        OCTClient *authenticatedClient = [OCTClient authenticatedClientWithUser:user token:SSKeychain.accessToken];
        self.services.client = authenticatedClient;
        self.viewModel = [[MRCHomepageViewModel alloc] initWithServices:self.services params:nil];
        
        return [[MRCHomepageViewController alloc] initWithViewModel:self.viewModel];
    } else {
        self.viewModel = [[MRCLoginViewModel alloc] initWithServices:self.services params:nil];
        return [[MRCLoginViewController alloc] initWithViewModel:self.viewModel];
    }
}

- (void)configureAppearance {
    self.window.backgroundColor = UIColor.whiteColor;
    
    UINavigationBar.appearance.barTintColor = [UIColor colorWithRed:(48 - 40) / 215.0 green:(67 - 40) / 215.0 blue:(78 - 40) / 215.0 alpha:1];
    UINavigationBar.appearance.barStyle = UIBarStyleBlack;
    UINavigationBar.appearance.tintColor = UIColor.whiteColor;
    
    UISegmentedControl.appearance.tintColor = UIColor.whiteColor;
    
    UITabBar.appearance.tintColor = HexRGB(colorI2);
}

- (void)configureKeyboardManager {
    IQKeyboardManager.sharedManager.enableAutoToolbar = NO;
    IQKeyboardManager.sharedManager.shouldResignOnTouchOutside = YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.scheme isEqual:MRC_URL_SCHEME]) {
        [OCTClient completeSignInWithCallbackURL:url];
        return YES;
    } else {
        return NO;
    }
}

@end
