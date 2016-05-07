//
//  MRCTrendingReposViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/5/7.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCTrendingReposViewController.h"
#import "MRCTrendingReposViewModel.h"
#import "MRCTrendingViewController.h"
#import "HMSegmentedControl.h"

@interface MRCTrendingReposViewController ()

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, strong) MRCTrendingReposViewModel *viewModel;

@end

@implementation MRCTrendingReposViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.contentView];

    self.segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44)];
    [self.view addSubview:self.segmentedControl];
    
    self.segmentedControl.sectionTitles = @[ @"Daily", @"Weekly", @"Monthly" ];
    [self.segmentedControl addBottomBorderWithHeight:MRC_1PX_WIDTH andColor:HexRGB(colorB2)];

    MRCTrendingViewController *dailyViewController   = [[MRCTrendingViewController alloc] initWithViewModel:self.viewModel.dailyViewModel];
    MRCTrendingViewController *weeklyViewController  = [[MRCTrendingViewController alloc] initWithViewModel:self.viewModel.weeklyViewModel];
    MRCTrendingViewController *monthlyViewController = [[MRCTrendingViewController alloc] initWithViewModel:self.viewModel.monthlyViewModel];
    
    NSArray *viewControllers = @[ dailyViewController, weeklyViewController, monthlyViewController ];
    
    for (UIViewController *viewController in viewControllers) {
        viewController.view.frame = self.contentView.bounds;
        [self addChildViewController:viewController];
    }
    
    self.currentViewController = dailyViewController;
    [self.contentView addSubview:dailyViewController.view];
    
    @weakify(self)
    self.segmentedControl.indexChangeBlock = ^(NSInteger index) {
        @strongify(self)
        
        UIViewController *toViewController = viewControllers[index];
        
        [self transitionFromViewController:self.currentViewController
                          toViewController:toViewController
                                  duration:0
                                   options:0
                                animations:NULL
                                completion:^(BOOL finished) {
                                    @strongify(self)
                                    self.currentViewController = toViewController;
                                }];
    };
}

@end
