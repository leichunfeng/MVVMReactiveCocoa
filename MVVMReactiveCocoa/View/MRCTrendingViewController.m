//
//  MRCTrendingViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/10/20.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import "MRCTrendingViewController.h"
#import "MRCTrendingViewModel.h"
#import "MRCTrendingSettingsViewModel.h"

@interface MRCTrendingViewController ()

@property (nonatomic, strong, readonly) MRCTrendingViewModel *viewModel;

@end

@implementation MRCTrendingViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
        
    UIImage *image = [UIImage octicon_imageWithIdentifier:@"Settings" size:CGSizeMake(22, 22)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(didClickSettingsButton:)];
}

- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(64, 0, 0, 0);
}

- (void)didClickSettingsButton:(id)sender {
    NSDictionary *params = @{
		@"since": self.viewModel.since ?: @"",
        @"language": self.viewModel.language ?: @""
	};

    MRCTrendingSettingsViewModel *settingsViewModel = [[MRCTrendingSettingsViewModel alloc] initWithServices:self.viewModel.services params:params];
    
    @weakify(self)
    settingsViewModel.callback = ^(RACTuple *tuple) {
        @strongify(self)
        
        RACTupleUnpack(NSDictionary *since, NSDictionary *language) = tuple;
        
        [[NSUserDefaults standardUserDefaults] setValue:since forKey:@"since"];
        [[NSUserDefaults standardUserDefaults] setValue:language forKey:@"language"];
        
        self.viewModel.since    = since;
        self.viewModel.language = language;
    };
    
    [self.viewModel.services presentViewModel:settingsViewModel animated:YES completion:NULL];
}

@end
