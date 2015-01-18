//
//  MRCRepositoriesTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepositoriesTableViewCell.h"
#import "MRCRepositoriesItemViewModel.h"

@implementation MRCRepositoriesTableViewCell

- (void)awakeFromNib {
    self.starIconImageView.image = [UIImage octicon_imageWithIdentifier:@"Star" size:CGSizeMake(12, 12)];
    self.forkIconImageView.image = [UIImage octicon_imageWithIdentifier:@"GitBranch" size:CGSizeMake(12, 12)];
}

- (void)bindViewModel:(MRCRepositoriesItemViewModel *)viewModel {
    NSString *identifier          = viewModel.isFork ? @"RepoForked" : @"Repo";
    self.nameLabel.attributedText = viewModel.name;
    self.descriptionLabel.text    = viewModel.repoDescription;
    self.languageLabel.text       = viewModel.language;
    self.starCountLabel.text      = [@(viewModel.stargazersCount) stringValue];
    self.forkCountLabel.text      = [@(viewModel.forksCount) stringValue];
    self.iconImageView.image      = [UIImage octicon_imageWithIdentifier:identifier size:CGSizeMake(20, 20)];
}

@end
