//
//  MRCRouter.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCRouter.h"

@interface MRCRouter ()

@property (nonatomic, copy) NSDictionary *viewModelViewMappings; // viewModel到view的映射

@end

@implementation MRCRouter

+ (instancetype)sharedInstance {
    static MRCRouter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (MRCViewController *)viewControllerForViewModel:(MRCViewModel *)viewModel {
    NSString *viewController = self.viewModelViewMappings[NSStringFromClass(viewModel.class)];
    
    NSParameterAssert([NSClassFromString(viewController) isSubclassOfClass:[MRCViewController class]]);
    NSParameterAssert([NSClassFromString(viewController) instancesRespondToSelector:@selector(initWithViewModel:)]);
    
    return [[NSClassFromString(viewController) alloc] initWithViewModel:viewModel];
}

- (NSDictionary *)viewModelViewMappings {
    return @{
    	@"MRCLoginViewModel": @"MRCLoginViewController",
        @"MRCHomepageViewModel": @"MRCHomepageViewController",
        @"MRCRepoDetailViewModel": @"MRCRepoDetailViewController",
        @"MRCWebViewModel": @"MRCWebViewController",
        @"MRCRepoReadmeViewModel": @"MRCRepoReadmeController",
        @"MRCSelectBranchOrTagViewModel": @"MRCSelectBranchOrTagViewController",
        @"MRCGitTreeViewModel": @"MRCGitTreeViewController",
        @"MRCSourceEditorViewModel": @"MRCSourceEditorViewController",
        @"MRCSettingsViewModel": @"MRCSettingsViewController",
        @"MRCAboutViewModel": @"MRCAboutViewController",
        @"MRCFeedbackViewModel": @"MRCFeedbackViewController",
        @"MRCRepoSettingsViewModel": @"MRCRepoSettingsViewController",
        @"MRCUserListViewModel": @"MRCUserListViewController",
        @"MRCUserDetailViewModel": @"MRCUserDetailViewController",
        @"MRCOwnedReposViewModel": @"MRCOwnedReposViewController",
        @"MRCStarredReposViewModel": @"MRCStarredReposViewController",
        @"MRCPublicReposViewModel": @"MRCPublicReposViewController",
        @"MRCNewsViewModel": @"MRCNewsViewController",
        @"MRCSearchViewModel": @"MRCSearchViewController",
        @"MRCTrendingViewModel": @"MRCTrendingViewController",
        @"MRCTrendingSettingsViewModel": @"MRCTrendingSettingsViewController",
        @"MRCShowcaseReposViewModel": @"MRCShowcaseReposViewController",
        @"MRCPopularReposViewModel": @"MRCPopularReposViewController",
        @"MRCLanguageViewModel": @"MRCLanguageViewController",
        @"MRCCountryViewModel": @"MRCCountryViewController",
        @"MRCCountryAndLanguageViewModel": @"MRCCountryAndLanguageViewController",
        @"MRCTrendingReposViewModel": @"MRCTrendingReposViewController",
        @"MRCOAuthViewModel": @"MRCOAuthViewController",
    };
}

@end
