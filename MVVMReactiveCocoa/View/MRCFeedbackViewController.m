//
//  MRCFeedbackViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/3/7.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCFeedbackViewController.h"
#import "MRCFeedbackViewModel.h"

@interface MRCFeedbackViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic, readonly) MRCFeedbackViewModel *viewModel;

@end

@implementation MRCFeedbackViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:nil action:NULL];
    rightBarButtonItem.rac_command = self.viewModel.submitFeedbackCommand;
    rightBarButtonItem.tintColor = HexRGB(0x24AFFC);
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    __block MBProgressHUD *progressHUD = nil;
    
    @weakify(self)
    [self.viewModel.submitFeedbackCommand.executing subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        if (executing.boolValue) {
            progressHUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            progressHUD.labelText = @"Submitting...";
        }
    }];
    
    [[self.viewModel.submitFeedbackCommand.executionSignals.flatten deliverOnMainThread] subscribeNext:^(id x) {
        progressHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
        
        progressHUD.mode = MBProgressHUDModeCustomView;
        progressHUD.labelText = @"Completed";
        
        [progressHUD hide:YES afterDelay:3];
    }];
    
    [self.viewModel.submitFeedbackCommand.errors subscribeNext:^(id x) {
        @strongify(self)
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    }];
}

- (void)bindViewModel {
    [super bindViewModel];
    
    RAC(self.viewModel, content) = self.textView.rac_textSignal;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

@end
