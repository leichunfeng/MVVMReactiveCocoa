//
//  MRCAvatarHeaderView.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCAvatarHeaderView.h"
#import "MRCAvatarHeaderViewModel.h"
#import "TGRImageZoomAnimationController.h"
#import "TGRImageViewController.h"
#import "MRCFollowButton.h"

#define MRCAvatarHeaderViewContentOffsetRadix 40.0f

@interface MRCAvatarHeaderView () <UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) IBOutlet UIView *overView;

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *followersLabel;
@property (nonatomic, weak) IBOutlet UILabel *repositoriesLabel;
@property (nonatomic, weak) IBOutlet UILabel *followingLabel;

@property (nonatomic, weak) IBOutlet UIButton *avatarButton;
@property (nonatomic, weak) IBOutlet UIButton *followersButton;
@property (nonatomic, weak) IBOutlet UIButton *repositoriesButton;
@property (nonatomic, weak) IBOutlet UIButton *followingButton;

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, weak) IBOutlet MRCFollowButton *operationButton;

@property (nonatomic, strong) GPUImageGaussianBlurFilter *gaussianBlurFilter;

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIImageView *bluredCoverImageView;

@property (nonatomic, strong) UIImage *avatarImage;

@property (nonatomic, strong) MRCAvatarHeaderViewModel *viewModel;

@end

@implementation MRCAvatarHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.avatarButton.imageView.layer.borderColor  = [UIColor whiteColor].CGColor;
    self.avatarButton.imageView.layer.borderWidth  = 2;
    self.avatarButton.imageView.layer.cornerRadius = CGRectGetWidth(self.avatarButton.frame) / 2;
    self.avatarButton.imageView.backgroundColor = HexRGB(0xEBE9E5);
    self.avatarButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImage = [UIImage imageNamed:@"default-avatar"];
}

- (void)bindViewModel:(MRCAvatarHeaderViewModel *)viewModel {
    self.viewModel = viewModel;

    @weakify(self)
    [RACObserve(self, avatarImage) subscribeNext:^(UIImage *avatarImage) {
        @strongify(self)
        [self.avatarButton setImage:avatarImage forState:UIControlStateNormal];
    }];

    // configure coverImageView
    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 323)];
    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.coverImageView.clipsToBounds = YES;

    // configure bluredCoverImageView
    self.bluredCoverImageView = [[UIImageView alloc] initWithFrame:self.coverImageView.bounds];
    self.bluredCoverImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.bluredCoverImageView.clipsToBounds = YES;

    [self.coverImageView addSubview:self.bluredCoverImageView];
    [self insertSubview:self.coverImageView atIndex:0];

    self.gaussianBlurFilter = [[GPUImageGaussianBlurFilter alloc] init];
    self.gaussianBlurFilter.blurRadiusInPixels = 20;

    RAC(self.coverImageView, image) = RACObserve(self, avatarImage);

    RAC(self.bluredCoverImageView, image) = [RACObserve(self, avatarImage) map:^(UIImage *avatarImage) {
        @strongify(self)
        return [self.gaussianBlurFilter imageByFilteringImage:avatarImage];
    }];

    // operation button
    [self.activityIndicatorView startAnimating];

    if (viewModel.operationCommand == nil) {
        self.activityIndicatorView.hidden = YES;
        self.operationButton.hidden = YES;
    } else {
        self.operationButton.rac_command = viewModel.operationCommand;

        [[RACObserve(viewModel.user, followingStatus)
           	deliverOnMainThread]
         	subscribeNext:^(NSNumber *followingStatus) {
             	@strongify(self)
                self.operationButton.selected = (followingStatus.unsignedIntegerValue == OCTUserFollowingStatusYES);
                self.activityIndicatorView.hidden = (followingStatus.unsignedIntegerValue != OCTUserFollowingStatusUnknown);
                self.operationButton.hidden = (followingStatus.unsignedIntegerValue == OCTUserFollowingStatusUnknown);
         	}];
    }

    [[[RACObserve(viewModel.user, avatarURL)
        ignore:nil]
        distinctUntilChanged]
        subscribeNext:^(NSURL *avatarURL) {
            [SDWebImageManager.sharedManager downloadImageWithURL:avatarURL
                                                          options:SDWebImageRefreshCached
                                                         progress:NULL
                                                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                            @strongify(self)
                                                            if (image && finished) self.avatarImage = image;
                                                        }];
        }];

    [[self.avatarButton
        rac_signalForControlEvents:UIControlEventTouchUpInside]
        subscribeNext:^(UIButton *avatarButton) {
            @strongify(self)
            MRCSharedAppDelegate.window.backgroundColor = [UIColor blackColor];

            TGRImageViewController *viewController = [[TGRImageViewController alloc] initWithImage:[avatarButton imageForState:UIControlStateNormal]];

            viewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            viewController.transitioningDelegate = self;

            [MRCSharedAppDelegate.window.rootViewController presentViewController:viewController animated:YES completion:NULL];
        }];

    RAC(self.nameLabel, text) = RACObserve(viewModel.user, login);

    NSString *(^toString)(NSNumber *) = ^(NSNumber *value) {
        NSString *text = value.stringValue;
        
        if (value.unsignedIntegerValue >= 1000) {
            text = [NSString stringWithFormat:@"%.1fk", value.unsignedIntegerValue / 1000.0];
        }
        
        return text;
    };

    RAC(self.repositoriesLabel, text) = [RACObserve(viewModel.user, publicRepoCount) map:toString];
    RAC(self.followersLabel, text)    = [[RACObserve(viewModel.user, followers) map:toString] deliverOnMainThread];
    RAC(self.followingLabel, text)    = [[RACObserve(viewModel.user, following) map:toString] deliverOnMainThread];

    self.followersButton.rac_command    = viewModel.followersCommand;
    self.repositoriesButton.rac_command = viewModel.repositoriesCommand;
    self.followingButton.rac_command    = viewModel.followingCommand;

    [[RACObserve(viewModel, contentOffset) filter:^BOOL(id value) {
        return [value CGPointValue].y <= 0;
    }] subscribeNext:^(id x) {
    	@strongify(self)

        CGPoint contentOffset = [x CGPointValue];

        self.coverImageView.frame = CGRectMake(0, 0 + contentOffset.y, SCREEN_WIDTH, CGRectGetHeight(self.frame) + ABS(contentOffset.y) - 58);
        self.bluredCoverImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.coverImageView.frame), CGRectGetHeight(self.coverImageView.frame));

        CGFloat diff  = MIN(ABS(contentOffset.y), MRCAvatarHeaderViewContentOffsetRadix);
        CGFloat scale = diff / MRCAvatarHeaderViewContentOffsetRadix;

        CGFloat alpha = 1 * (1 - scale);

        self.avatarButton.imageView.alpha = alpha;
        self.nameLabel.alpha = alpha;
        self.operationButton.alpha = alpha;
        self.bluredCoverImageView.alpha = alpha;
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.overView addBottomBorderWithHeight:MRC_1PX_WIDTH andColor:HexRGB(colorB2)];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if ([presented isKindOfClass:TGRImageViewController.class]) {
        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:self.avatarButton.imageView];
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if ([dismissed isKindOfClass:TGRImageViewController.class]) {
        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:self.avatarButton.imageView];
    }
    return nil;
}

@end
