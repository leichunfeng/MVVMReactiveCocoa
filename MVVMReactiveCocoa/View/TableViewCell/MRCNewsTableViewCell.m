//
//  MRCNewsTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/5.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCNewsTableViewCell.h"

@interface MRCNewsTableViewCell () <DTAttributedTextContentViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *detailView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailHeightLayoutConstraint;

@end

@implementation MRCNewsTableViewCell

+ (instancetype)sharedInstance {
    static MRCNewsTableViewCell *_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[UINib nibWithNibName:@"MRCNewsTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil].firstObject;
    });
    return _sharedInstance;
}

+ (DTAttributedLabel *)sharedAttributedLabel {
    static DTAttributedLabel *_sharedAttributedLabel;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedAttributedLabel = [[DTAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 10 - 40 - 10 - 10, 15)];
        _sharedAttributedLabel.layoutFrameHeightIsConstrainedByBounds = NO;
    });
    return _sharedAttributedLabel;
}

- (void)awakeFromNib {
    CGRect frame = self.detailView.frame;
    frame.size.width = SCREEN_WIDTH - 10 * 2 - 40 - 10;
    self.detailView.frame = frame;
    
    self.detailView.delegate = self;
}

- (void)bindViewModel:(MRCNewsItemViewModel *)viewModel {
    [self.avatarImageView sd_setImageWithURL:viewModel.event.actorAvatarURL placeholderImage:[HexRGB(colorI6) color2Image]];
    
    self.detailView.layoutFrameHeightIsConstrainedByBounds = NO;
    self.detailView.attributedString = viewModel.attributedString;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.detailHeightLayoutConstraint.constant = ceilf([self.detailView suggestedFrameSizeToFitEntireStringConstraintedToWidth:SCREEN_WIDTH - 10 * 2 - 40 - 10].height);
}

- (CGFloat)height {
    CGFloat height = 10 + ceilf([self.detailView suggestedFrameSizeToFitEntireStringConstraintedToWidth:SCREEN_WIDTH - 10 * 2 - 40 - 10].height) + 10;
    return MAX(height, 10 + 40 + 10 + 1);
}

+ (CGFloat)heightWithViewModel:(MRCNewsItemViewModel *)viewModel {
    DTAttributedLabel *attributedLabel = [self sharedAttributedLabel];
    attributedLabel.attributedString = viewModel.attributedString;
    CGFloat height = 10 + ceilf([attributedLabel suggestedFrameSizeToFitEntireStringConstraintedToWidth:SCREEN_WIDTH - 10 * 2 - 40 - 10].height) + 10;
    return MAX(height, 10 + 40 + 10 + 1);
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
