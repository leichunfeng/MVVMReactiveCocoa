//
//  MRCRepoSettingsAvatarTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/15.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoSettingsAvatarTableViewCell.h"

@implementation MRCRepoSettingsAvatarTableViewCell

@dynamic imageView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.imageView.layer.cornerRadius  = 5;
        self.imageView.layer.masksToBounds = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:nil
                                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                                          multiplier:1
                                                                            constant:65];
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1
                                                                             constant:65];
        NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                             attribute:NSLayoutAttributeLeading
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.contentView
                                                                             attribute:NSLayoutAttributeLeading
                                                                            multiplier:1
                                                                              constant:20];
        NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                             attribute:NSLayoutAttributeCenterY
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.contentView
                                                                             attribute:NSLayoutAttributeCenterY
                                                                            multiplier:1
                                                                              constant:0];
        
        [self addConstraints:@[ widthConstraint, heightConstraint, leadingConstraint, centerYConstraint ]];
    }
    return self;
}

@end
