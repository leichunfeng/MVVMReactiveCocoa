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
#import "MRCLoadingTitleView.h"

@interface MRCViewController ()

@property (strong, nonatomic, readwrite) MRCViewModel *viewModel;

@end

@implementation MRCViewController

@synthesize viewModel = _viewModel;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    MRCViewController *viewController = [super allocWithZone:zone];

    @weakify(viewController)
    [[viewController
        rac_signalForSelector:@selector(viewDidLoad)]
        subscribeNext:^(id x) {
            @strongify(viewController)
            [viewController bindViewModel];
        }];
    
    return viewController;
}

- (id<MRCViewProtocol>)initWithViewModel:(id)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
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
            MRCDoubleTitleView *titleView = [[MRCDoubleTitleView alloc] init];
            
            [[[self
            	rac_signalForSelector:@selector(viewWillTransitionToSize:withTransitionCoordinator:)]
             	startWith:nil]
            	subscribeNext:^(id x) {
                    @strongify(self)
                    titleView.titleLabel.text = self.viewModel.title;
                    titleView.subtitleLabel.text = self.viewModel.subtitle;
                }];
            
            self.navigationItem.titleView = titleView;
        }
            break;
        default:
            break;
    }
    
    MRCLoadingTitleView *loadingTitleView = [[MRCLoadingTitleView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 1) / 2.0, 4, 1, 36)];
    [self.navigationController.navigationBar addSubview:loadingTitleView];
    
    RACSignal *showLoadingTitleSignal = [RACObserve(self.viewModel, titleViewType).distinctUntilChanged map:^(NSNumber *titleViewType) {
        return @(titleViewType.unsignedIntegerValue == MRCTitleViewTypeLoadingTitle);
    }];
    
    RAC(self.navigationItem.titleView, hidden) = showLoadingTitleSignal;
    RAC(loadingTitleView, hidden) = showLoadingTitleSignal.not;
    
    [self.viewModel.errors subscribeNext:^(NSError *error) {
        @strongify(self)
        
        NSLog(@"error.localizedDescription: %@", error.localizedDescription);
        
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
