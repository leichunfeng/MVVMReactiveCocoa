//
//  MRCNewsTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/5.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCNewsTableViewCell.h"
#import "MRCNewsItemViewModel.h"

static NSDictionary *_imageDictionary   = nil;
static UIImage *_commentDiscussionImage = nil;
static UIImage *_gitBranchImage         = nil;
static UIImage *_issueOpenedImage       = nil;
static UIImage *_issueClosedImage       = nil;
static UIImage *_issueReopenedImage     = nil;
static UIImage *_gitPullRequestImage    = nil;
static UIImage *_gitCommitImage         = nil;
static UIImage *_repoImage              = nil;
static UIImage *_tagImage               = nil;
static UIImage *_starImage              = nil;

@interface MRCNewsTableViewCell () <DTAttributedTextContentViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *actionImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *detailView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailHeightLayoutConstraint;

@end

@implementation MRCNewsTableViewCell

- (void)awakeFromNib {
    self.avatarImageView.backgroundColor = HexRGB(colorI6);
    
    CGRect frame = self.detailView.frame;
    frame.size.width = SCREEN_WIDTH - 10 * 2 - 40 - 10;
    self.detailView.frame = frame;
    
    self.detailView.delegate = self;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _commentDiscussionImage = [UIImage octicon_imageWithIdentifier:@"CommentDiscussion" size:self.actionImageView.frame.size];
        _gitBranchImage         = [UIImage octicon_imageWithIdentifier:@"GitBranch" size:self.actionImageView.frame.size];
        _issueOpenedImage       = [UIImage octicon_imageWithIdentifier:@"IssueOpened" size:self.actionImageView.frame.size];
        _issueClosedImage       = [UIImage octicon_imageWithIdentifier:@"IssueClosed" size:self.actionImageView.frame.size];
        _issueReopenedImage     = [UIImage octicon_imageWithIdentifier:@"IssueReopened" size:self.actionImageView.frame.size];
        _gitPullRequestImage    = [UIImage octicon_imageWithIdentifier:@"GitPullRequest" size:self.actionImageView.frame.size];
        _gitCommitImage         = [UIImage octicon_imageWithIdentifier:@"GitCommit" size:self.actionImageView.frame.size];
        _repoImage              = [UIImage octicon_imageWithIdentifier:@"Repo" size:self.actionImageView.frame.size];
        _tagImage               = [UIImage octicon_imageWithIdentifier:@"Tag" size:self.actionImageView.frame.size];
        _starImage              = [UIImage octicon_imageWithIdentifier:@"Star" size:self.actionImageView.frame.size];
        
        _imageDictionary = @{ @"CommentDiscussion": _commentDiscussionImage,
                              @"GitBranch": _gitBranchImage,
                              @"IssueOpened": _issueOpenedImage,
                              @"IssueClosed": _issueClosedImage,
                              @"IssueReopened": _issueReopenedImage,
                              @"GitPullRequest": _gitPullRequestImage,
                              @"GitCommit": _gitCommitImage,
                              @"Repo": _repoImage,
                              @"Tag": _tagImage,
                              @"Star": _starImage };
    });
}

- (void)bindViewModel:(MRCNewsItemViewModel *)viewModel {
    [self.avatarImageView sd_setImageWithURL:viewModel.event.actorAvatarURL];
    
    self.detailView.layoutFrameHeightIsConstrainedByBounds = NO;
    self.detailView.attributedString = viewModel.contentAttributedString;
    
    self.actionImageView.image = _imageDictionary[viewModel.imageIdentifier];
    self.timeLabel.text = viewModel.occurTime;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.detailHeightLayoutConstraint.constant = ceilf([self.detailView suggestedFrameSizeToFitEntireStringConstraintedToWidth:SCREEN_WIDTH - 10 * 2 - 40 - 10].height);
}

- (CGFloat)height {
    CGFloat height = 10 + ceilf([self.detailView suggestedFrameSizeToFitEntireStringConstraintedToWidth:SCREEN_WIDTH - 10 * 2 - 40 - 10].height) + 2 + 15 + 10;
    return MAX(height, 10 + 40 + 10);
}

#pragma mark - DTAttributedTextContentViewDelegate

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttributedString:(NSAttributedString *)string frame:(CGRect)frame {
    NSDictionary *attributes = [string attributesAtIndex:0 effectiveRange:NULL];
    
    NSURL *URL = [attributes objectForKey:DTLinkAttribute];
    NSString *identifier = [attributes objectForKey:DTGUIDAttribute];
    
    DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:frame];
    button.URL = URL;
    button.minimumHitSize = CGSizeMake(25, 25); // adjusts it's bounds so that button is always large enough
    button.GUID = identifier;
    
    // get image with normal link text
    UIImage *normalImage = [attributedTextContentView contentImageWithBounds:frame options:DTCoreTextLayoutFrameDrawingDefault];
    [button setImage:normalImage forState:UIControlStateNormal];
    
    // get image for highlighted link text
    UIImage *highlightImage = [attributedTextContentView contentImageWithBounds:frame options:DTCoreTextLayoutFrameDrawingDrawLinksHighlighted];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    
    // use normal push action for opening URL
    [button addTarget:self action:@selector(linkPushed:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)linkPushed:(id)sender {
    NSLog(@"linkPushed...");
}

@end
