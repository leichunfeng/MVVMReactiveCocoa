//
//  WXTabBarController.m
//  WXTabBarController
//
//  Created by leichunfeng on 15/11/20.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import "WXTabBarController.h"

@interface WXTabBarController () <UIScrollViewDelegate>

@property (nonatomic, copy) NSArray<__kindof UIViewController *> *backingViewControllers;
@property (nonatomic, assign) NSUInteger backingSelectedIndex;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, copy) NSArray *tabBarButtons;
@property (nonatomic, assign) BOOL initialized;

@end

@implementation WXTabBarController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces  = NO;
    self.scrollView.delegate = self;
    
    [self.view insertSubview:self.scrollView belowSubview:self.tabBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!self.initialized) {
        [self.tabBarButtons enumerateObjectsUsingBlock:^(UIView *tabBarButton, NSUInteger idx, BOOL *stop) {
            UIImageView *tabBarImageView = tabBarButton.subviews[0];
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = self.backingViewControllers[idx].tabBarItem.selectedImage;
            [tabBarButton insertSubview:imageView atIndex:0];
            
            imageView.translatesAutoresizingMaskIntoConstraints = NO;
            
            [tabBarButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[tabBarImageView]-width-[imageView(==tabBarImageView)]"
                                                                                 options:0
                                                                                 metrics:@{ @"width": @(-CGRectGetWidth(tabBarImageView.frame)) }
                                                                                   views:NSDictionaryOfVariableBindings(tabBarImageView, imageView)]];
            [tabBarButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[tabBarImageView]-height-[imageView(==tabBarImageView)]"
                                                                                 options:0
                                                                                 metrics:@{ @"height": @(-CGRectGetHeight(tabBarImageView.frame)) }
                                                                                   views:NSDictionaryOfVariableBindings(tabBarImageView, imageView)]];
            
            UILabel *tabBarLabel = tabBarButton.subviews.lastObject;
            
            UILabel *label = [[UILabel alloc] init];
            label.textColor = self.tabBar.tintColor;
            label.font = tabBarLabel.font;
            label.text = self.backingViewControllers[idx].tabBarItem.title;
            [tabBarButton insertSubview:label atIndex:1];
            
            label.translatesAutoresizingMaskIntoConstraints = NO;
            
            [tabBarButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[tabBarLabel]-width-[label(==tabBarLabel)]"
                                                                                 options:0
                                                                                 metrics:@{ @"width": @(-CGRectGetWidth(tabBarLabel.frame)) }
                                                                                   views:NSDictionaryOfVariableBindings(tabBarLabel, label)]];
            [tabBarButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[tabBarLabel]-height-[label(==tabBarLabel)]"
                                                                                 options:0
                                                                                 metrics:@{ @"height": @(-CGRectGetHeight(tabBarLabel.frame)) }
                                                                                   views:NSDictionaryOfVariableBindings(tabBarLabel, label)]];
        }];
        
        self.selectedIndex = 0;
        self.initialized = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    self.scrollView.delegate = nil;
    self.scrollView.frame = CGRectMake(0, 0, size.width, size.height);
    self.scrollView.contentOffset = CGPointMake(size.width * self.backingSelectedIndex, 0);
    self.scrollView.contentSize = CGSizeMake(size.width * self.backingViewControllers.count, size.height);
    self.scrollView.delegate = self;
    
    [self.backingViewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
        viewController.view.frame = CGRectMake(size.width * idx, 0, size.width, size.height);
    }];
}

#pragma mark - Getters and Setters

- (NSArray *)viewControllers {
    return nil;
}

- (void)setViewControllers:(NSArray *)viewControllers {
    [self setViewControllers:viewControllers animated:NO];
}

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated {
    self.backingViewControllers = viewControllers;
}

- (UIViewController *)selectedViewController {
    return self.backingViewControllers[self.backingSelectedIndex];
}

- (void)setSelectedViewController:(UIViewController *)selectedViewController {
    self.selectedIndex = [self.backingViewControllers indexOfObject:selectedViewController];
}

- (NSUInteger)selectedIndex {
    return self.backingSelectedIndex;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    _backingSelectedIndex = selectedIndex;
    
    CGRect rectToVisible = CGRectMake(CGRectGetWidth(self.view.frame) * selectedIndex, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
   
    self.scrollView.delegate = nil;
    [self.scrollView scrollRectToVisible:rectToVisible animated:NO];
    self.scrollView.delegate = self;
    
    [self.tabBarButtons enumerateObjectsUsingBlock:^(UIView *tabBarButton, NSUInteger idx, BOOL *stop) {
        [self tabBarButton:tabBarButton highlighted:(idx == selectedIndex) deltaAlpha:0];
    }];
}

- (void)setBackingViewControllers:(NSArray *)backingViewControllers {
    _backingViewControllers = backingViewControllers;
   
    [backingViewControllers enumerateObjectsUsingBlock:^(UINavigationController *viewController, NSUInteger idx, BOOL *stop) {
        [self addChildViewController:viewController];
        viewController.view.frame = CGRectMake(CGRectGetWidth(self.view.frame) * idx, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        [self.scrollView addSubview:viewController.view];
    }];
   
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * backingViewControllers.count, CGRectGetHeight(self.view.frame));
}

- (NSArray *)tabBarButtons {
    if (_tabBarButtons == nil) {
        NSMutableArray *tabBarButtons = [[NSMutableArray alloc] init];
        for (UIView *subview in self.tabBar.subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                [tabBarButtons addObject:subview];
            }
        };
        _tabBarButtons = tabBarButtons.copy;
    }
    return _tabBarButtons;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / CGRectGetWidth(self.view.frame);
    CGFloat mod = fmod(scrollView.contentOffset.x, CGRectGetWidth(self.view.frame));
    CGFloat deltaAlpha = mod * (1.0 / CGRectGetWidth(self.view.frame));

    [self.tabBarButtons enumerateObjectsUsingBlock:^(UIView *tabBarButton, NSUInteger idx, BOOL *stop) {
        if (idx == index) {
            [self tabBarButton:tabBarButton highlighted:YES deltaAlpha:deltaAlpha];
        } else if (idx == index + 1) {
            [self tabBarButton:tabBarButton highlighted:NO deltaAlpha:deltaAlpha];
        }
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _backingSelectedIndex = scrollView.contentOffset.x / CGRectGetWidth(self.view.frame);
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    self.selectedViewController = viewController;
    return NO;
}

- (UIInterfaceOrientationMask)tabBarControllerSupportedInterfaceOrientations:(UITabBarController *)tabBarController {
    return tabBarController.selectedViewController.supportedInterfaceOrientations;
}

#pragma mark - Private methods

- (void)tabBarButton:(UIView *)tabBarButton highlighted:(BOOL)highlighted deltaAlpha:(CGFloat)deltaAlpha {
    if (highlighted) {
        tabBarButton.subviews[0].alpha = 1 - deltaAlpha;
        tabBarButton.subviews[1].alpha = 1 - deltaAlpha;
        tabBarButton.subviews[2].alpha = 0 + deltaAlpha;
        tabBarButton.subviews[3].alpha = 0 + deltaAlpha;
    } else {
        tabBarButton.subviews[0].alpha = 0 + deltaAlpha;
        tabBarButton.subviews[1].alpha = 0 + deltaAlpha;
        tabBarButton.subviews[2].alpha = 1 - deltaAlpha;
        tabBarButton.subviews[3].alpha = 1 - deltaAlpha;
    }
}

@end
