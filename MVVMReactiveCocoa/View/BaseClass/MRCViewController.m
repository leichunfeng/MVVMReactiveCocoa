//
//  MRCViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCViewController.h"
#import "MRCViewModel.h"
#import "MRCLoginViewModel.h"
#import "MRCDoubleTitleView.h"

@interface MRCViewController ()

@property (strong, nonatomic, readwrite) MRCViewModel *viewModel;

@end

@implementation MRCViewController

@synthesize viewModel = _viewModel;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    MRCViewController *viewController = [super allocWithZone:zone];

    [[viewController
        rac_signalForSelector:@selector(viewDidLoad)]
        subscribeNext:^(id x) {
            [viewController bindViewModel];
        }];
    
    return viewController;
}

- (id<MRCViewProtocol>)initWithViewModel:(id)viewModel {
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];    
    self.extendedLayoutIncludesOpaqueBars = YES;
}

- (void)bindViewModel {
    @weakify(self)
    switch (self.viewModel.titleViewType) {
        case MRCTitleViewTypeDefault:
            RAC(self, title) = RACObserve(self.viewModel, title);
            break;
        case MRCTitleViewTypeDoubleTitle: {
            MRCDoubleTitleView *titleView = MRCDoubleTitleView.new;
            
            titleView.titleLabel.text = self.viewModel.title;
            titleView.subtitleLabel.text = self.viewModel.subtitle;
            
            self.navigationItem.titleView = titleView;
            
            [[self
            	rac_signalForSelector:@selector(viewWillTransitionToSize:withTransitionCoordinator:)]
            	subscribeNext:^(id x) {
                    @strongify(self)
                    titleView.titleLabel.text = self.viewModel.title;
                    titleView.subtitleLabel.text = self.viewModel.subtitle;
                }];
        }
            break;
        default:
            break;
    }
    
    [self.viewModel.errors subscribeNext:^(NSError *error) {
        @strongify(self)
        if ([error.domain isEqual:OCTClientErrorDomain] && error.code == OCTClientErrorAuthenticationFailed) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:MRC_ALERT_TITLE
                                                                                     message:@"Your authorization has expired, please login again"
                                                                              preferredStyle:UIAlertControllerStyleAlert];
           
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                @strongify(self)
                [SSKeychain deleteAccessToken];
                
                MRCLoginViewModel *loginViewModel = [[MRCLoginViewModel alloc] initWithServices:self.viewModel.services params:nil];                
                [self.viewModel.services resetRootViewModel:loginViewModel];
            }]];
            
            [self presentViewController:alertController animated:YES completion:NULL];
        } else if (error.code != OCTClientErrorTwoFactorAuthenticationOneTimePasswordRequired && error.code != OCTClientErrorConnectionFailed) {
            MRCError(error.localizedDescription);
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.viewModel.willDisappearSignal sendNext:nil];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return isPad ? UIInterfaceOrientationMaskLandscape : UIInterfaceOrientationMaskPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
