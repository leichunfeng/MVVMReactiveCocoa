//
//  MRCLoginViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCLoginViewController.h"
#import "MRCLoginViewModel.h"
#import "MRCHomepageViewController.h"
#import "MRCHomepageViewModel.h"
#import "IQKeyboardReturnKeyHandler.h"

@interface MRCLoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic) IBOutlet UIImageView *usernameImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *browserLoginButton;

@property (strong, nonatomic, readonly) MRCLoginViewModel *viewModel;
@property (strong, nonatomic) IQKeyboardReturnKeyHandler *returnKeyHandler;

@end

@implementation MRCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.avatarImageView.layer.borderWidth = 2.0f;
    
    self.usernameImageView.image = [UIImage octicon_imageWithIdentifier:@"Person" size:CGSizeMake(22, 22)];
    self.passwordImageView.image = [UIImage octicon_imageWithIdentifier:@"Lock" size:CGSizeMake(22, 22)];
    
    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyGo;
    
    self.usernameTextField.text = SSKeychain.rawLogin;
    self.passwordTextField.text = SSKeychain.password;
    
    @weakify(self)
    [[self rac_signalForSelector:@selector(textFieldShouldReturn:) fromProtocol:@protocol(UITextFieldDelegate)]
    	subscribeNext:^(RACTuple *tuple) {
            @strongify(self)
            if (tuple.first == self.passwordTextField)	[self.viewModel.loginCommand execute:nil];
        }];
    
    self.passwordTextField.delegate = self;
}

- (void)bindViewModel {
    [super bindViewModel];
    
	@weakify(self)
    [RACObserve(self.viewModel, avatarURL) subscribeNext:^(NSURL *avatarURL) {
    	@strongify(self)
        [self.avatarImageView sd_setImageWithURL:avatarURL placeholderImage:[UIImage imageNamed:@"default-avatar"]];
    }];
    
    RAC(self.viewModel, username) = self.usernameTextField.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;
    
    [[RACSignal
      	merge:@[self.viewModel.loginCommand.executing, self.viewModel.browserLoginCommand.executing]]
    	subscribeNext:^(NSNumber *executing) {
            @strongify(self)
            if (executing.boolValue) {
                [self.view endEditing:YES];
                [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES].labelText = @"Logging in...";
            } else {
                @strongify(self)
                [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
            }
        }];
    
    [self.viewModel.errors subscribeNext:^(NSError *error) {
        @strongify(self)
        if ([error.domain isEqual:OCTClientErrorDomain] && error.code == OCTClientErrorTwoFactorAuthenticationOneTimePasswordRequired) {
            NSString *message = @"Please enter the 2FA code you received via SMS or read from an authenticator app";
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips"
                                                                                     message:message
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.returnKeyType = UIReturnKeyGo;
                textField.placeholder = @"2FA code";
                textField.secureTextEntry = YES;
            }];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"Login" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                @strongify(self)
                [self.viewModel.loginCommand execute:[alertController.textFields.firstObject text]];
            }]];
            
            [self presentViewController:alertController animated:YES completion:NULL];
        }
    }];
    
    self.loginButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        [self.viewModel.loginCommand execute:nil];
        return [RACSignal empty];
    }];
    
    self.browserLoginButton.rac_command = self.viewModel.browserLoginCommand;
}

@end
