//
//  MRCCountryAndLanguageViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/5/7.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCCountryAndLanguageViewController.h"
#import "MRCCountryAndLanguageViewModel.h"
#import "MRCCountryViewController.h"
#import "MRCLanguageViewController.h"
#import "MRCCountryViewModel.h"
#import "MRCLanguageViewModel.h"

@interface MRCCountryAndLanguageViewController ()

@property (nonatomic, strong) MRCCountryAndLanguageViewModel *viewModel;

@end

@implementation MRCCountryAndLanguageViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MRCCountryViewController *countryViewController = [[MRCCountryViewController alloc] initWithViewModel:self.viewModel.viewModels.firstObject];
    countryViewController.segmentedControlItem = @"Country";
    
    MRCLanguageViewController *languageViewController = [[MRCLanguageViewController alloc] initWithViewModel:self.viewModel.viewModels.lastObject];
    languageViewController.segmentedControlItem = @"Language";
    
    self.viewControllers = @[ countryViewController, languageViewController ];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([self isBeingDismissed] || [self isMovingFromParentViewController]) {
        if (self.viewModel.callback) {
            MRCCountryViewModel *countryViewModel   = (MRCCountryViewModel *)self.viewModel.viewModels.firstObject;
            MRCLanguageViewModel *languageViewModel = (MRCLanguageViewModel *)self.viewModel.viewModels.lastObject;
            
            NSDictionary *output = @{
                @"country": countryViewModel.item ?: @{},
                @"language": languageViewModel.item ?: @{}
            };
            
            self.viewModel.callback(output);
        }
    }
}

@end
