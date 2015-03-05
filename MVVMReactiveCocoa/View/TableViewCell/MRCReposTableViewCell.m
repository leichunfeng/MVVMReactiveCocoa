//
//  MRCReposTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCReposTableViewCell.h"
#import "MRCReposItemViewModel.h"

@implementation MRCReposTableViewCell

- (void)awakeFromNib {
    self.starIconImageView.image = [UIImage octicon_imageWithIdentifier:@"Star" size:CGSizeMake(12, 12)];
    self.forkIconImageView.image = [UIImage octicon_imageWithIdentifier:@"GitBranch" size:CGSizeMake(12, 12)];
}

- (void)bindViewModel:(MRCReposItemViewModel *)viewModel {
    self.nameLabel.attributedText = viewModel.name;
    self.descriptionLabel.text    = viewModel.repository.repoDescription;
    self.languageLabel.text       = viewModel.language;
    self.starCountLabel.text      = @(viewModel.repository.stargazersCount).stringValue;
    self.forkCountLabel.text      = @(viewModel.repository.forksCount).stringValue;
    
    UIColor *iconColor = viewModel.hexRGB ? HexRGB(viewModel.hexRGB) : UIColor.darkGrayColor;
    self.iconImageView.image = [UIImage octicon_imageWithIcon:viewModel.identifier
                                              backgroundColor:UIColor.clearColor
                                                    iconColor:iconColor
                                                    iconScale:1
                                                      andSize:self.iconImageView.frame.size];
}

@end
