//
//  MRCReposTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCReposTableViewCell.h"
#import "MRCReposItemViewModel.h"
#import "UIImage+RTTint.h"

static UIImage *_repoIcon = nil;
static UIImage *_repoForkedIcon = nil;
static UIImage *_lockIcon = nil;

static UIImage *_starIcon = nil;
static UIImage *_gitBranchIcon = nil;
static UIImage *_tintedStarIcon = nil;

@interface MRCReposTableViewCell ()

@property (nonatomic, strong) MRCReposItemViewModel *viewModel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *updateTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel *desLabel;
@property (nonatomic, weak) IBOutlet UILabel *languageLabel;
@property (nonatomic, weak) IBOutlet UILabel *starCountLabel;
@property (nonatomic, weak) IBOutlet UILabel *forkCountLabel;
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, weak) IBOutlet UIImageView *starIconImageView;
@property (nonatomic, weak) IBOutlet UIImageView *forkIconImageView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *layoutConstraint;

@end

@implementation MRCReposTableViewCell

- (void)awakeFromNib {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _repoIcon = [UIImage octicon_imageWithIdentifier:@"Repo" size:self.iconImageView.frame.size];
        _repoForkedIcon = [UIImage octicon_imageWithIdentifier:@"RepoForked" size:self.iconImageView.frame.size];
        _lockIcon = [UIImage octicon_imageWithIcon:@"Lock"
                                   backgroundColor:[UIColor clearColor]
                                         iconColor:HexRGB(colorI4)
                                         iconScale:1
                                           andSize:self.iconImageView.frame.size];
        
        _starIcon = [UIImage octicon_imageWithIdentifier:@"Star" size:self.starIconImageView.frame.size];
        _gitBranchIcon = [UIImage octicon_imageWithIdentifier:@"GitBranch" size:self.forkIconImageView.frame.size];
        _tintedStarIcon = [_starIcon rt_tintedImageWithColor:HexRGB(colorI5)];
    });
    
    self.desLabel.numberOfLines = 3;
    self.forkIconImageView.image = _gitBranchIcon;
}

- (void)bindViewModel:(MRCReposItemViewModel *)viewModel {
    self.viewModel = viewModel;
    
    self.nameLabel.attributedText = viewModel.name;
    self.updateTimeLabel.text = viewModel.updateTime;
    
    if (viewModel.repoDescription) {
        self.desLabel.attributedText = viewModel.repoDescription;
    } else {
        self.desLabel.text = viewModel.repository.repoDescription;
    }
    
    self.languageLabel.text  = viewModel.language;
    self.forkCountLabel.text = @(viewModel.repository.forksCount).stringValue;
    
    @weakify(self)
	[[[RACObserve(viewModel.repository, stargazersCount)
		deliverOnMainThread]
        takeUntil:self.rac_prepareForReuseSignal]
    	subscribeNext:^(NSNumber *stargazersCount) {
        	@strongify(self)
            self.starCountLabel.text = stargazersCount.stringValue;
        }];
    
    if (viewModel.repository.isPrivate) {
        self.iconImageView.image = _lockIcon;
    } else if (viewModel.repository.isFork) {
        self.iconImageView.image = _repoForkedIcon;
    } else {
        self.iconImageView.image = _repoIcon;
    }
    
    if (viewModel.language.length == 0) {
        self.layoutConstraint.constant = 0;
    } else {
        self.layoutConstraint.constant = 10;
    }
    
    if (viewModel.options & MRCReposViewModelOptionsMarkStarredStatus) {
        [[[RACObserve(viewModel.repository, starredStatus)
        	deliverOnMainThread]
            takeUntil:self.rac_prepareForReuseSignal]
        	subscribeNext:^(NSNumber *starredStatus) {
                @strongify(self)
                if (starredStatus.unsignedIntegerValue == OCTRepositoryStarredStatusYES) {
                    self.starIconImageView.image = _tintedStarIcon;
                } else {
                    self.starIconImageView.image = _starIcon;
                }
            }];
    } else {
        self.starIconImageView.image = _starIcon;
    }
}

@end
