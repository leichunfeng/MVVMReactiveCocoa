//
//  MRCRepoReadMeController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/26.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoReadMeController.h"
#import "MRCRepoReadMeViewModel.h"

@interface MRCRepoReadMeController ()

@property (strong, nonatomic, readonly) MRCRepoReadMeViewModel *viewModel;
@property (weak, nonatomic) IBOutlet DTAttributedTextView *textView;

@end

@implementation MRCRepoReadMeController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)bindViewModel {
    [super bindViewModel];
    RAC(self.textView, attributedString) = RACObserve(self.viewModel, attributedString);
}

@end
