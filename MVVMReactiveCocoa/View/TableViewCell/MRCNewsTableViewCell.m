//
//  MRCNewsTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/5.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCNewsTableViewCell.h"

#define detailViewWidth (SCREEN_WIDTH - 10 * 2 - 40 - 10)

@interface MRCNewsTableViewCell () <DTAttributedTextContentViewDelegate>

@property (nonatomic, strong) MRCNewsItemViewModel *viewModel;
@property (nonatomic, weak) IBOutlet UIButton *avatarButton;
@property (nonatomic, weak) IBOutlet DTAttributedLabel *detailView;

@end

@implementation MRCNewsTableViewCell

+ (DTAttributedLabel *)sharedAttributedLabel {
    static DTAttributedLabel *_sharedAttributedLabel;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedAttributedLabel = [[DTAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, detailViewWidth, 15)];
        _sharedAttributedLabel.layoutFrameHeightIsConstrainedByBounds = NO;
    });
    return _sharedAttributedLabel;
}

- (void)awakeFromNib {
    CGRect frame = self.detailView.frame;
    frame.size.width = detailViewWidth;
    self.detailView.frame = frame;
    
    self.detailView.delegate = self;
}

- (void)bindViewModel:(MRCNewsItemViewModel *)viewModel {
    self.viewModel = viewModel;
    
    [self.avatarButton sd_setImageWithURL:viewModel.event.actorAvatarURL
                                 forState:UIControlStateNormal
                         placeholderImage:[MRCNewsTableViewCell placeholderImage]];
    
    self.detailView.layoutFrameHeightIsConstrainedByBounds = NO;
    self.detailView.attributedString = viewModel.attributedString;
}

+ (CGFloat)heightWithViewModel:(MRCNewsItemViewModel *)viewModel {
    DTAttributedLabel *attributedLabel = [self sharedAttributedLabel];
    attributedLabel.attributedString = viewModel.attributedString;
    CGFloat height = 10 + ceilf([attributedLabel suggestedFrameSizeToFitEntireStringConstraintedToWidth:detailViewWidth].height) + 10;
    return MAX(height, 10 + 40 + 10);
}

- (IBAction)didClickAvatarButton:(id)sender {
    [self.viewModel.didClickLinkCommand execute:[NSURL mrc_userLinkWithLogin:self.viewModel.event.actorLogin]];
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

- (BOOL)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView shouldDrawBackgroundForTextBlock:(DTTextBlock *)textBlock frame:(CGRect)frame context:(CGContextRef)context forLayoutFrame:(DTCoreTextLayoutFrame *)layoutFrame {
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:3];
    
    CGColorRef color = [textBlock.backgroundColor CGColor];
    if (color) {
        CGContextSetFillColorWithColor(context, color);
        CGContextAddPath(context, [roundedRect CGPath]);
        CGContextFillPath(context);

        return NO;
    }
    
    return YES; // draw standard background
}

- (void)linkPushed:(DTLinkButton *)button {
    [self.viewModel.didClickLinkCommand execute:button.URL];
}

#pragma mark - Private Method

+ (UIImage *)placeholderImage {
    static UIImage *placeholderImage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        placeholderImage = [HexRGB(colorI6) color2ImageSized:CGSizeMake(40, 40)];
    });
    return placeholderImage;
}

@end
