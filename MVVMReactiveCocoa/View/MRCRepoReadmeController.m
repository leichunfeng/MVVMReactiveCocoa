//
//  MRCRepoReadmeController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/26.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoReadmeController.h"
#import "MRCRepoReadmeViewModel.h"

@interface MRCRepoReadmeController ()

@property (strong, nonatomic, readonly) MRCRepoReadmeViewModel *viewModel;
@property (weak, nonatomic) IBOutlet DTAttributedTextView *textView;

@end

@implementation MRCRepoReadmeController

- (void)bindViewModel {
    [super bindViewModel];
    RAC(self.textView, attributedString) = RACObserve(self.viewModel, readmeAttributedString);
}

@end
