//
//  MRCPopularReposViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/4/24.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCPopularReposViewController.h"
#import "MRCPopularReposViewModel.h"

@interface MRCPopularReposViewController ()

@property (nonatomic, strong) MRCPopularReposViewModel *viewModel;

@end

@implementation MRCPopularReposViewController

@synthesize viewModel = _viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage octicon_imageWithIdentifier:@"Gear" size:CGSizeMake(22, 22)]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:nil
                                                                             action:NULL];
    self.navigationItem.rightBarButtonItem.rac_command = self.viewModel.rightBarButtonItemCommand;
}

- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(64, 0, 0, 0);
}

@end
