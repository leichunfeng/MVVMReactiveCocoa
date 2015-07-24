//
//  MRCLoadingTitleView.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/24.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCLoadingTitleView.h"

@interface MRCLoadingTitleView ()

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) UILabel *loadingLabel;

@end

@implementation MRCLoadingTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(-54, 6.5, 23, 23)];
        [self.activityIndicatorView startAnimating];
        
        [self addSubview:self.activityIndicatorView];
        
        self.loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(-27, 6.667, 85, 23)];
        self.loadingLabel.text = MBPROGRESSHUD_LABEL_TEXT;
        self.loadingLabel.textColor = [UIColor whiteColor];
        self.loadingLabel.font = [UIFont systemFontOfSize:18.5];
        
        [self addSubview:self.loadingLabel];
    }
    return self;
}

@end
