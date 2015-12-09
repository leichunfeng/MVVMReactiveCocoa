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

@property (nonatomic, strong, readwrite) MRCViewModel *viewModel;
@property (nonatomic, strong, readwrite) UINavigationBar *navigationBar;
@property (nonatomic, strong, readwrite) UIPercentDrivenInteractiveTransition *interactivePopTransition;
//@property (nonatomic, strong, readwrite) UIView *snapshot;

@end

@implementation MRCViewController

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

- (MRCViewController *)initWithViewModel:(id)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
//    self.navigationBar = ({
//        UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
//        
//        UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:self.viewModel.title];
//        [navigationBar pushNavigationItem:navigationItem animated:YES];
//        [self.view addSubview:navigationBar];
//        
//        UIImage *image = [UIImage octicon_imageWithIcon:@""
//                                        backgroundColor:[UIColor colorWithRed:(48 - 40) / 215.0 green:(67 - 40) / 215.0 blue:(78 - 40) / 215.0 alpha:1]
//                                              iconColor:[UIColor clearColor]
//                                              iconScale:1
//                                                andSize:CGSizeMake(SCREEN_WIDTH, 64)];
//        [navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//        
//        navigationBar;
//    });
    
    UIScreenEdgePanGestureRecognizer *popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
    popRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:popRecognizer];
//    [self addGestureRecognizer:popRecognizer];
}

//- (void)addGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer {
//    [self.view addGestureRecognizer:gestureRecognizer];
//}

- (void)bindViewModel {
	// System title view
    RAC(self, title) = RACObserve(self.viewModel, title);

    UIView *titleView = self.navigationItem.titleView;

	// Double title view
    MRCDoubleTitleView *doubleTitleView = [[MRCDoubleTitleView alloc] init];

    RAC(doubleTitleView.titleLabel, text)    = RACObserve(self.viewModel, title);
    RAC(doubleTitleView.subtitleLabel, text) = RACObserve(self.viewModel, subtitle);

    @weakify(self)
    [[self
    	rac_signalForSelector:@selector(viewWillTransitionToSize:withTransitionCoordinator:)]
    	subscribeNext:^(id x) {
        	@strongify(self)
            doubleTitleView.titleLabel.text    = self.viewModel.title;
            doubleTitleView.subtitleLabel.text = self.viewModel.subtitle;
    	}];

	// Loading title view
    MRCLoadingTitleView *loadingTitleView = [[NSBundle mainBundle] loadNibNamed:@"MRCLoadingTitleView" owner:nil options:nil].firstObject;
    loadingTitleView.frame = CGRectMake((SCREEN_WIDTH - CGRectGetWidth(loadingTitleView.frame)) / 2.0, 0, CGRectGetWidth(loadingTitleView.frame), CGRectGetHeight(loadingTitleView.frame));

    RAC(self.navigationItem, titleView) = [RACObserve(self.viewModel, titleViewType).distinctUntilChanged map:^(NSNumber *value) {
        MRCTitleViewType titleViewType = value.unsignedIntegerValue;
        switch (titleViewType) {
            case MRCTitleViewTypeDefault:
                return titleView;
            case MRCTitleViewTypeDoubleTitle:
                return (UIView *)doubleTitleView;
            case MRCTitleViewTypeLoadingTitle:
                return (UIView *)loadingTitleView;
        }
    }];

    [self.viewModel.errors subscribeNext:^(NSError *error) {
        @strongify(self)

        MRCLogError(error);

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
    
    if ([self isMovingFromParentViewController]) {
        self.snapshot = [self.navigationController.view snapshotViewAfterScreenUpdates:NO];
    }
    
//    NSLog(@"isMovingToParentViewController: %@", @([self isMovingToParentViewController]));
//    NSLog(@"isMovingFromParentViewController: %@", @([self isMovingFromParentViewController]));
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return isPad ? UIInterfaceOrientationMaskLandscape : UIInterfaceOrientationMaskPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - UIScreenEdgePanGestureRecognizer handlers

- (void)handlePopRecognizer:(UIScreenEdgePanGestureRecognizer *)recognizer {
    CGFloat progress = [recognizer translationInView:self.view].x / CGRectGetWidth(self.view.frame);
    progress = MIN(1.0, MAX(0.0, progress));

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // Create a interactive transition and pop the view controller
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
//        [self.viewModel.services popViewModelAnimated:YES];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        // Update the interactive transition's progress
        [self.interactivePopTransition updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        // Finish or cancel the interactive transition
        if (progress > 0.3) {
            [self.interactivePopTransition finishInteractiveTransition];
        } else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }

        self.interactivePopTransition = nil;
    }
}

@end
