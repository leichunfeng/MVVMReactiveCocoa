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
    [super awakeFromNib];
    
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
    
    RAC(self.starCountLabel, text) = [[RACObserve(self, viewModel.repository.stargazersCount)
        map:^(NSNumber *stargazersCount) {
            return stargazersCount.stringValue;
        }]
        deliverOnMainThread];
    
    RAC(self.starIconImageView, image) = [RACSignal
        combineLatest:@[
            RACObserve(self, viewModel.options),
            RACObserve(self, viewModel.repository.starredStatus).deliverOnMainThread,
        ]
        reduce:^(NSNumber *options, NSNumber *starredStatus) {
            if (options.unsignedIntegerValue & MRCReposViewModelOptionsMarkStarredStatus &&
                starredStatus.unsignedIntegerValue == OCTRepositoryStarredStatusYES) {
                return _tintedStarIcon;
            }
            return _starIcon;
        }];
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
    
    if (viewModel.repository.isPrivate) {
        self.iconImageView.image = _lockIcon;
    } else if (viewModel.repository.isFork) {
        self.iconImageView.image = _repoForkedIcon;
    } else {
        self.iconImageView.image = _repoIcon;
    }
    
    self.layoutConstraint.constant = viewModel.language.length == 0 ? 0 : 10;
}

@end
