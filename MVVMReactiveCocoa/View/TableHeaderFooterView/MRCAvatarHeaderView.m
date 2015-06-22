//
//  MRCAvatarHeaderView.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCAvatarHeaderView.h"
#import "MRCAvatarHeaderViewModel.h"
#import "UIImage+ImageEffects.h"
#import "TGRImageZoomAnimationController.h"
#import "TGRImageViewController.h"
#import "MRCFollowButton.h"
#import "MRCAvatarHeaderViewModel.h"

#define MRCAvatarHeaderViewContentOffsetRadix 40.0f
#define MRCAvatarHeaderViewBlurEffectRadix    2.0f

@interface MRCAvatarHeaderView () <UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UIView *overView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIButton *avatarButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *repositoriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UIButton *followersButton;
@property (weak, nonatomic) IBOutlet UIButton *repositoriesButton;
@property (weak, nonatomic) IBOutlet UIButton *followingButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet MRCFollowButton *operationButton;

@property (strong, nonatomic) UIImage *avatarImage;
@property (assign, nonatomic) CGPoint lastContentOffsetBlurEffect;

@property (strong, nonatomic) MRCAvatarHeaderViewModel *viewModel;

@end

@implementation MRCAvatarHeaderView

- (void)awakeFromNib {
    self.avatarButton.imageView.layer.borderColor  = [UIColor whiteColor].CGColor;
    self.avatarButton.imageView.layer.borderWidth  = 2;
    self.avatarButton.imageView.layer.cornerRadius = CGRectGetWidth(self.avatarButton.frame) / 2;
    self.avatarButton.imageView.backgroundColor = HexRGB(0xEBE9E5);
    self.avatarButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.coverImageView.backgroundColor = HexRGB(0xEBE9E5);
    self.avatarImage = [UIImage imageNamed:@"default-avatar"];
}

- (void)bindViewModel:(MRCAvatarHeaderViewModel *)viewModel {
    self.viewModel = viewModel;
    
    [self.activityIndicatorView startAnimating];

    @weakify(self)
    if (viewModel.operationCommand == nil) {
        self.activityIndicatorView.hidden = YES;
        self.operationButton.hidden = YES;
    } else {
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
                                                          options:0
                                                         progress:NULL
                                                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                            @strongify(self)
                                                            if (image && finished) self.avatarImage = image;
                                                        }];
        }];
    
    [[self.avatarButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *avatarButton) {
        @strongify(self)
        MRCSharedAppDelegate.window.backgroundColor = [UIColor blackColor];
        
        TGRImageViewController *viewController = [[TGRImageViewController alloc] initWithImage:[avatarButton imageForState:UIControlStateNormal]];
        
        viewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        viewController.transitioningDelegate = self;
        
        [MRCSharedAppDelegate.window.rootViewController presentViewController:viewController animated:YES completion:NULL];
    }];
    
    RAC(self.nameLabel, text) = RACObserve(viewModel.user, login);
    
    NSString * (^mapNumberToString)(NSNumber *) = ^(NSNumber *value) {
        return value.stringValue;
    };
    
    RAC(self.repositoriesLabel, text) = [RACObserve(viewModel.user, publicRepoCount) map:mapNumberToString];
    RAC(self.followersLabel, text) = [[RACObserve(viewModel.user, followers) map:mapNumberToString] deliverOnMainThread];
    RAC(self.followingLabel, text) = [[RACObserve(viewModel.user, following) map:mapNumberToString] deliverOnMainThread];

    self.followersButton.rac_command = viewModel.followersCommand;
    self.repositoriesButton.rac_command = viewModel.repositoriesCommand;
    self.followingButton.rac_command = viewModel.followingCommand;
    
    [[RACObserve(viewModel, contentOffset) filter:^BOOL(id value) {
        return [value CGPointValue].y < 0;
    }] subscribeNext:^(id x) {
    	@strongify(self)
        
        CGPoint contentOffset = [x CGPointValue];
        self.coverImageView.frame = CGRectMake(0 + contentOffset.y/2, 0 + contentOffset.y, CGRectGetWidth(self.frame) + ABS(contentOffset.y), CGRectGetHeight(self.frame) + ABS(contentOffset.y) - 58);
        
        CGFloat diff  = MIN(ABS(contentOffset.y), MRCAvatarHeaderViewContentOffsetRadix);
        CGFloat scale = diff / MRCAvatarHeaderViewContentOffsetRadix;
        
        if (ABS(contentOffset.y - self.lastContentOffsetBlurEffect.y) >= MRCAvatarHeaderViewBlurEffectRadix) {
            self.lastContentOffsetBlurEffect = contentOffset;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.coverImageView.image = [self.avatarImage applyBlurWithRadius:20 * (1 - scale) tintColor:nil saturationDeltaFactor:1 maskImage:nil];
            });
        }
        
        CGFloat alpha = 1 * (1 - scale);
        
        self.avatarButton.imageView.alpha = alpha;
        self.nameLabel.alpha = alpha;
        self.operationButton.alpha = alpha;
    }];
}

- (void)setAvatarImage:(UIImage *)avatarImage {
    _avatarImage = avatarImage;
    self.coverImageView.image = [avatarImage applyBlurWithRadius:20 tintColor:nil saturationDeltaFactor:1 maskImage:nil];
    [self.avatarButton setImage:avatarImage forState:UIControlStateNormal];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.overView addBottomBorderWithHeight:MRC_1PX_WIDTH andColor:HexRGB(colorB2)];
}

- (IBAction)didClickOperationButton:(id)sender {
    [self.viewModel.operationCommand execute:nil];
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
