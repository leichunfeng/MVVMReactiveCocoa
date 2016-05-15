//
//  MRCAboutViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/3/4.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCAboutViewModel.h"
#import "MRCFeedbackViewModel.h"
#import "MRCWebViewModel.h"
#import "MRCRepoDetailViewModel.h"
#import "MRCUserDetailViewModel.h"

#define kAppStoreVersionKey @"appStoreVersion"

@interface MRCAboutViewModel ()

@property (nonatomic, assign, readwrite) BOOL isLatestVersion;

@end

@implementation MRCAboutViewModel

- (void)initialize {
    [super initialize];
    
    self.title = @"About";
    
    [self detectVersionUpgrade];
    
    @weakify(self)
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^(NSIndexPath *indexPath) {
        @strongify(self)
        if (indexPath.row == 2) {
            NSDictionary *params = @{
                @"repository": @{
                    @"ownerLogin": MVVM_REACTIVECOCOA_OWNER_LOGIN,
                    @"name": MVVM_REACTIVECOCOA_NAME
                },
                @"referenceName": @"refs/heads/master"
            };
            MRCRepoDetailViewModel *viewModel = [[MRCRepoDetailViewModel alloc] initWithServices:self.services params:params];
            [self.services pushViewModel:viewModel animated:YES];
        } else if (indexPath.row == 3) {
            NSDictionary *params = @{
                @"user": @{
                    @"login": MVVM_REACTIVECOCOA_OWNER_LOGIN
                }
            };
            MRCUserDetailViewModel *viewModel = [[MRCUserDetailViewModel alloc] initWithServices:self.services params:params];
            [self.services pushViewModel:viewModel animated:YES];
        } else if (indexPath.row == 4) {
            MRCFeedbackViewModel *feedbackViewModel = [[MRCFeedbackViewModel alloc] initWithServices:self.services params:nil];
            [self.services pushViewModel:feedbackViewModel animated:YES];
        }
        return [RACSignal empty];
    }];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    @weakify(self)
    return [[[self.services
        appStoreService]
        requestAppInfoFromAppStoreWithAppID:MRC_APP_ID]
        doNext:^(NSDictionary *appInfo) {
            @strongify(self)
            NSString *appStoreVersion = [appInfo[@"results"] firstObject][@"version"];
            
            [[NSUserDefaults standardUserDefaults] setValue:appStoreVersion forKey:kAppStoreVersionKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self detectVersionUpgrade];
        }];
}

- (void)detectVersionUpgrade {
    self.isLatestVersion = self.appStoreVersion ? [MRC_APP_VERSION isEqualToString:self.appStoreVersion] : YES;
}

- (NSString *)appStoreVersion {
    return [[NSUserDefaults standardUserDefaults] valueForKey:kAppStoreVersionKey];
}

@end
