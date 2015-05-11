//
//  MRCReposTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCReposTableViewCell.h"
#import "MRCReposItemViewModel.h"

static NSMutableArray *_iconImages;

@interface MRCReposTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;
@property (weak, nonatomic) IBOutlet UILabel *starCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *forkCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *starIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *forkIconImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutConstraint;

@end

@implementation MRCReposTableViewCell

- (void)awakeFromNib {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _iconImages = [NSMutableArray new];
    });
    
    self.descriptionLabel.numberOfLines = 3;
    self.starIconImageView.image = [UIImage octicon_imageWithIdentifier:@"Star" size:CGSizeMake(12, 12)];
    self.forkIconImageView.image = [UIImage octicon_imageWithIdentifier:@"GitBranch" size:CGSizeMake(12, 12)];
}

- (void)bindViewModel:(MRCReposItemViewModel *)viewModel {
    self.nameLabel.attributedText = viewModel.name;
    self.updateTimeLabel.text     = viewModel.updateTime;
    self.descriptionLabel.text    = viewModel.repository.repoDescription;
    self.languageLabel.text       = viewModel.language;
    self.starCountLabel.text      = @(viewModel.repository.stargazersCount).stringValue;
    self.forkCountLabel.text      = @(viewModel.repository.forksCount).stringValue;
    
    UIColor *iconColor = viewModel.hexRGB ? HexRGB(viewModel.hexRGB) : [UIColor darkGrayColor];
    
    BOOL exists = NO;
    for (NSDictionary *dic in _iconImages) {
        if ([viewModel.identifier isEqualToString:dic[@"identifier"]] && [iconColor isEqual:dic[@"iconColor"]]) {
            exists = YES;
            self.iconImageView.image = dic[@"iconImage"];
        }
    }
    if (!exists) {
        UIImage *iconImage = [UIImage octicon_imageWithIcon:viewModel.identifier
                                            backgroundColor:[UIColor clearColor]
                                                  iconColor:iconColor
                                                  iconScale:1
                                                    andSize:self.iconImageView.frame.size];
        self.iconImageView.image = iconImage;
        
        NSDictionary *dic = @{ @"identifier": viewModel.identifier, @"iconColor": iconColor, @"iconImage": iconImage };
        [_iconImages addObject:dic];
    }
    
    if (viewModel.language.length == 0) {
        self.layoutConstraint.constant = 0;
    } else {
        self.layoutConstraint.constant = 10;
    }
}

@end
