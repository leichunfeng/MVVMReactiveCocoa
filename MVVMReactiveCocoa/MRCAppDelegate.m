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

@interface MRCAppDelegate ()

@property (strong, nonatomic) MRCViewModelServicesImpl *services;
@property (strong, nonatomic) id<MRCViewModelProtocol> viewModel;

@end

@implementation MRCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.services = [MRCViewModelServicesImpl new];
    self.navigationControllerStack = [[MRCNavigationControllerStack alloc] initWithServices:self.services];

    UINavigationController *navigationController = [UINavigationController new];
    [self.navigationControllerStack pushNavigationController:navigationController];
    [navigationController pushViewController:[self createInitialViewController] animated:NO];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    [self configureAppearance];
    [self configureKeyboardManager];
    
    NSLog(@"MRC_DOCUMENT_DIRECTORY: %@", MRC_DOCUMENT_DIRECTORY);
    
    return YES;
}

- (UIViewController *)createInitialViewController {
//    [SSKeychain deletePasswordForService:MRC_SERVICE_NAME account:MRC_RAW_LOGIN];
//    [SSKeychain deletePasswordForService:MRC_SERVICE_NAME account:MRC_ACCESS_TOKEN];
    
    NSString *rawLogin    = [SSKeychain passwordForService:MRC_SERVICE_NAME account:MRC_RAW_LOGIN];
    NSString *accessToken = [SSKeychain passwordForService:MRC_SERVICE_NAME account:MRC_ACCESS_TOKEN];
    
    // The user has logged-in.
    if ([rawLogin isExist] && [accessToken isExist]) {
        OCTUser *user = [OCTUser userWithRawLogin:rawLogin server:OCTServer.dotComServer];

        OCTClient *authenticatedClient = [OCTClient authenticatedClientWithUser:user token:accessToken];
        self.services.client = authenticatedClient;
        self.viewModel = [[MRCHomepageViewModel alloc] initWithServices:self.services params:nil];
        
        return [[MRCHomepageViewController alloc] initWithViewModel:self.viewModel];
    } else {
        self.viewModel = [[MRCLoginViewModel alloc] initWithServices:self.services params:nil];
        return [[MRCLoginViewController alloc] initWithViewModel:self.viewModel];
    }
}

- (void)configureAppearance {
    UINavigationBar.appearance.barTintColor = HexRGB(colorA17);
    UINavigationBar.appearance.tintColor = UIColor.whiteColor;
    UINavigationBar.appearance.titleTextAttributes = @{ NSForegroundColorAttributeName: UIColor.whiteColor };
    UITableView.appearance.backgroundColor = HexRGB(0xf8f8f8);
}

- (void)configureKeyboardManager {
    IQKeyboardManager.sharedManager.enableAutoToolbar = NO;
    IQKeyboardManager.sharedManager.shouldResignOnTouchOutside = YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.scheme isEqual:MRC_URL_SCHEME]) {
        [OCTClient completeSignInWithCallbackURL:url];
        return YES;
    }
    return NO;
}

@end
