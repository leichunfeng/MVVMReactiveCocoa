//
//  MRCTrendingViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/10/20.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import "MRCTrendingViewController.h"

@interface MRCTrendingViewController ()

@end

@implementation MRCTrendingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIImage *image = [UIImage octicon_imageWithIdentifier:@"Settings" size:CGSizeMake(22, 22)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(didClickSettingsButton:)];
}

- (void)didClickSettingsButton:(id)sender {
    
}

@end
