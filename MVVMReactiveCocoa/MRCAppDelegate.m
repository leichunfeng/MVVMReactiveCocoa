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
#import "MRCNavigationController.h"

@interface MRCAppDelegate ()

@property (strong, nonatomic) MRCViewModelServicesImpl *services;
@property (strong, nonatomic) id<MRCViewModelProtocol> viewModel;
@property (strong, nonatomic) Reachability *reachability;

@end

@implementation MRCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initializeFMDB];

    AFNetworkActivityIndicatorManager.sharedManager.enabled = YES;
    
    self.services = [MRCViewModelServicesImpl new];
    self.navigationControllerStack = [[MRCNavigationControllerStack alloc] initWithServices:self.services];

    UINavigationController *navigationController = [[MRCNavigationController alloc] initWithRootViewController:self.createInitialViewController];
    [self.navigationControllerStack pushNavigationController:navigationController];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    [self configureAppearance];
    [self configureKeyboardManager];
    [self configureReachability];
    [self configureUMAnalytics];
    
    NSLog(@"MRC_DOCUMENT_DIRECTORY: %@", MRC_DOCUMENT_DIRECTORY);
    
//    UIImage *image = [UIImage octicon_imageWithIcon:@"GitMerge"
//                                    backgroundColor:UIColor.whiteColor
//                                          iconColor:HexRGB(colorI2)
//                                          iconScale:1
//                                            andSize:CGSizeMake(1024, 1024)];
    
    return YES;
}

- (UIViewController *)createInitialViewController {
    // The user has logged-in.
    if ([SSKeychain rawLogin].isExist && [SSKeychain accessToken].isExist) {
        OCTUser *user = [OCTUser userWithRawLogin:[SSKeychain rawLogin] server:OCTServer.dotComServer];

        OCTClient *authenticatedClient = [OCTClient authenticatedClientWithUser:user token:[SSKeychain accessToken]];
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

- (void)configureReachability {
    self.reachability = Reachability.reachabilityForInternetConnection;
    
    RAC(self, networkStatus) = [[[[NSNotificationCenter.defaultCenter
    	rac_addObserverForName:kReachabilityChangedNotification object:nil]
        map:^id(NSNotification *notification) {
            return @([notification.object currentReachabilityStatus]);
        }]    	
    	startWith:@(self.reachability.currentReachabilityStatus)]
        distinctUntilChanged];
    
    @weakify(self)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self)
        [self.reachability startNotifier];
    });
}

- (void)configureUMAnalytics {
    [MobClick startWithAppkey:MRC_UM_APP_KEY reportPolicy:BATCH channelId:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *adURL = [MobClick getAdURL];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.adURL = adURL;
        });
    });
}

- (void)initializeFMDB {
    FMDatabase *db = [FMDatabase databaseWithPath:MRC_FMDB_PATH];
    if ([db open]) {
        @onExit {
            [db close];
        };
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"update_v1_0_1" ofType:@"sql"];
        NSString *sql = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        if (![db executeStatements:sql]) {
            mrcLogLastError(db);
        }
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.scheme isEqual:MRC_URL_SCHEME]) {
        [OCTClient completeSignInWithCallbackURL:url];
        return YES;
    }
    return NO;
}

@end
