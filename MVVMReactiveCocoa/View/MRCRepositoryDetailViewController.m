//
//  MRCRepositoryDetailViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepositoryDetailViewController.h"

@interface MRCRepositoryDetailViewController ()

@end

@implementation MRCRepositoryDetailViewController

- (instancetype)initWithViewModel:(id<MRCViewModelProtocol>)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
