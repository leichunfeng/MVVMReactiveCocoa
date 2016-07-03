//
//  LCFCollectionViewCell.m
//  LCFInfiniteScrollView
//
//  Created by leichunfeng on 16/4/16.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "LCFCollectionViewCell.h"

@interface LCFCollectionViewCell ()

@property (nonatomic, strong, readwrite) UIImageView *imageView;
@property (nonatomic, strong, readwrite) UILabel *label;

@end

@implementation LCFCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageView];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:@{ @"imageView": self.imageView }]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:@{ @"imageView": self.imageView }]];
    
    self.label = [[UILabel alloc] init];
    [self.contentView addSubview:self.label];
    
    self.label.font = [UIFont systemFontOfSize:17];
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines = 0;
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:@{ @"label": self.label }]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.label
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1
                                                                  constant:0]];
}

@end
