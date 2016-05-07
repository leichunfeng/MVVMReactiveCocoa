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

@interface MRCTrendingReposViewController ()

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, strong) MRCTrendingReposViewModel *viewModel;

@end

@implementation MRCTrendingReposViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage octicon_imageWithIdentifier:@"Gear" size:CGSizeMake(22, 22)]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:nil
                                                                             action:NULL];
    self.navigationItem.rightBarButtonItem.rac_command = self.viewModel.rightBarButtonItemCommand;
    
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.contentView];
    
    UIView *wrapperView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 45)];
    [self.view addSubview:wrapperView];

    wrapperView.backgroundColor = [UIColor whiteColor];
    [wrapperView addBottomBorderWithHeight:MRC_1PX_WIDTH andColor:HexRGB(colorB2)];

    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[ @"Daily", @"Weekly", @"Monthly" ]];
    [wrapperView addSubview:self.segmentedControl];
    
    self.segmentedControl.frame = CGRectMake(10, 8, SCREEN_WIDTH - 10 * 2, 29);
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.tintColor = HexRGB(colorI3);

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
    [[self.segmentedControl
    	rac_newSelectedSegmentIndexChannelWithNilValue:@0]
    	subscribeNext:^(NSNumber *selectedSegmentIndex) {
            @strongify(self)
            
            UIViewController *toViewController = viewControllers[selectedSegmentIndex.unsignedIntegerValue];
            
            [self transitionFromViewController:self.currentViewController
                              toViewController:toViewController
                                      duration:0
                                       options:0
                                    animations:NULL
                                    completion:^(BOOL finished) {
                                    	@strongify(self)
                                    	self.currentViewController = toViewController;
                                    }];
     }];
}

@end
