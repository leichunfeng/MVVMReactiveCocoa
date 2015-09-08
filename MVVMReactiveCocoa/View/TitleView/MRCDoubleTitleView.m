//
//  MRCDoubleTitleView.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/2/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCDoubleTitleView.h"

@interface MRCDoubleTitleView ()

@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UILabel *subtitleLabel;

@end

@implementation MRCDoubleTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];
    
    @weakify(self)
    RACSignal *titleLabelSignal = [RACObserve(self.titleLabel, text) doNext:^(id x) {
        @strongify(self)
        [self.titleLabel sizeToFit];
    }];
    
    RACSignal *subtitleLabelSignal = [RACObserve(self.subtitleLabel, text) doNext:^(id x) {
        @strongify(self)
        [self.subtitleLabel sizeToFit];
    }];
    
    [[RACSignal combineLatest:@[ titleLabelSignal, subtitleLabelSignal ]] subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
        self.frame = CGRectMake(0, 0, MAX(CGRectGetWidth(self.titleLabel.frame), CGRectGetWidth(self.subtitleLabel.frame)), 44);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect titleLabelFrame = self.titleLabel.frame;
    titleLabelFrame.size.width = MIN(CGRectGetWidth(self.titleLabel.frame), CGRectGetWidth(self.frame));
    titleLabelFrame.origin.x = CGRectGetWidth(self.frame) / 2 - CGRectGetWidth(titleLabelFrame) / 2;
    titleLabelFrame.origin.y = 4;
    self.titleLabel.frame = titleLabelFrame;
    
    CGRect subtitleLabelFrame = self.subtitleLabel.frame;
    subtitleLabelFrame.size.width = MIN(CGRectGetWidth(self.subtitleLabel.frame), CGRectGetWidth(self.frame));
    subtitleLabelFrame.origin.x = CGRectGetWidth(self.frame) / 2 - CGRectGetWidth(subtitleLabelFrame) / 2;
    subtitleLabelFrame.origin.y = CGRectGetHeight(self.frame) - 4 - CGRectGetHeight(self.subtitleLabel.frame);
    self.subtitleLabel.frame = subtitleLabelFrame;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = UIColor.whiteColor;
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.font = [UIFont systemFontOfSize:15];
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
        _subtitleLabel.textColor = UIColor.whiteColor;
    }
    return _subtitleLabel;
}

@end
