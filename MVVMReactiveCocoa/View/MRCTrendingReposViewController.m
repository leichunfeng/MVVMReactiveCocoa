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
    
    self.contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.contentView];
    
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIView *wrapperView = [[UIView alloc] initWithFrame:CGRectMake(0, iPhoneX ? 88 : 64, CGRectGetWidth(self.view.frame), 45)];
    [self.view addSubview:wrapperView];

    wrapperView.backgroundColor  = [UIColor whiteColor];
    wrapperView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[ @"Daily", @"Weekly", @"Monthly" ]];
    [wrapperView addSubview:self.segmentedControl];
    
    self.segmentedControl.frame = CGRectMake(10, 8, CGRectGetWidth(wrapperView.frame) - 10 * 2, 29);
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.tintColor = HexRGB(colorI3);
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UIView *bottomBorder = [wrapperView createViewBackedBottomBorderWithHeight:MRC_1PX_WIDTH andColor:HexRGB(colorB2)];
    [wrapperView addSubview:bottomBorder];
    
    bottomBorder.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    MRCTrendingViewController *dailyViewController   = [[MRCTrendingViewController alloc] initWithViewModel:self.viewModel.dailyViewModel];
    MRCTrendingViewController *weeklyViewController  = [[MRCTrendingViewController alloc] initWithViewModel:self.viewModel.weeklyViewModel];
    MRCTrendingViewController *monthlyViewController = [[MRCTrendingViewController alloc] initWithViewModel:self.viewModel.monthlyViewModel];
    
    NSArray *viewControllers = @[ dailyViewController, weeklyViewController, monthlyViewController ];
    
    for (UIViewController *viewController in viewControllers) {
        [self addChildViewController:viewController];
    }
    
    dailyViewController.view.frame = self.contentView.bounds;
    [self.contentView addSubview:dailyViewController.view];
    
    self.currentViewController = dailyViewController;
    
    @weakify(self)
    [[self.segmentedControl
    	rac_newSelectedSegmentIndexChannelWithNilValue:@0]
    	subscribeNext:^(NSNumber *selectedSegmentIndex) {
            @strongify(self)
            
            UIViewController *toViewController = viewControllers[selectedSegmentIndex.unsignedIntegerValue];
            toViewController.view.frame = self.contentView.bounds;
            
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
