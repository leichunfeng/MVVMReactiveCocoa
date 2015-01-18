//
//  MRCStarredRepositoriesTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/17.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCStarredRepositoriesTableViewCell.h"
#import "MRCStarredRepositoriesItemViewModel.h"

@implementation MRCStarredRepositoriesTableViewCell

- (void)awakeFromNib {
    self.starIconImageView.image = [UIImage octicon_imageWithIdentifier:@"Star" size:CGSizeMake(12, 12)];
    self.forkIconImageView.image = [UIImage octicon_imageWithIdentifier:@"GitBranch" size:CGSizeMake(12, 12)];
}

- (void)bindViewModel:(MRCStarredRepositoriesItemViewModel *)viewModel {
    self.nameLabel.text        = viewModel.name;
    self.descriptionLabel.text = viewModel.repoDescription;
    self.languageLabel.text    = viewModel.language;
    self.starCountLabel.text   = [@(viewModel.stargazersCount) stringValue];
    self.forkCountLabel.text   = [@(viewModel.forksCount) stringValue];
}

@end
