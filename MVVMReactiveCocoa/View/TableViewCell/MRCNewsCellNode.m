//
//  MRCNewsCellNode.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/11/29.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import "MRCNewsCellNode.h"
#import "SDImageCache+ASImageCacheProtocol.h"
#import "SDWebImageDownloader+ASImageDownloaderProtocol.h"

#define MRCAvatarNodeSide 40

extern NSString * const MRCLinkAttributeName;

@interface MRCNewsCellNode () <ASTextNodeDelegate>

@property (nonatomic, strong) MRCNewsItemViewModel *viewModel;
@property (nonatomic, strong) ASNetworkImageNode *avatarNode;
@property (nonatomic, strong) ASTextNode *detailNode;

@end

@implementation MRCNewsCellNode

- (instancetype)initWithViewModel:(MRCNewsItemViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        
        self.avatarNode = ({
            ASNetworkImageNode *avatarNode = [[ASNetworkImageNode alloc] initWithCache:[SDImageCache sharedImageCache]
                                                                            downloader:[SDWebImageDownloader sharedDownloader]];

            avatarNode.backgroundColor = ASDisplayNodeDefaultPlaceholderColor();
            avatarNode.preferredFrameSize = CGSizeMake(MRCAvatarNodeSide, MRCAvatarNodeSide);
            avatarNode.URL = viewModel.event.actorAvatarURL;
            
            // configure the button
            avatarNode.userInteractionEnabled = YES; // opt into touch handling
            [avatarNode addTarget:self action:@selector(didClickAvatarNode:) forControlEvents:ASControlNodeEventTouchUpInside];

            avatarNode;
        });
        [self addSubnode:self.avatarNode];
        
        self.detailNode = ({
            ASTextNode *detailNode = [[ASTextNode alloc] init];
            
            // configure node to support tappable links
            detailNode.delegate = self;
            detailNode.userInteractionEnabled = YES;
            detailNode.passthroughNonlinkTouches = YES;
            detailNode.linkAttributeNames = @[ MRCLinkAttributeName ];
            detailNode.attributedString = viewModel.attributedString;
            
            detailNode;
        });
        [self addSubnode:self.detailNode];
    }
    return self;
}

- (void)didLoad {
    self.layer.as_allowsHighlightDrawing = YES;
    [super didLoad];
}

- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize {
    CGFloat width = MAX(constrainedSize.width - 10 - MRCAvatarNodeSide - 10 - 10, 0);
    CGSize detailSize = [self.detailNode measure:CGSizeMake(width, constrainedSize.height)];
    return CGSizeMake(constrainedSize.width, 10 + MAX(MRCAvatarNodeSide, detailSize.height) + 10);
}

- (void)layout {
    self.avatarNode.frame = CGRectMake(10, 10, MRCAvatarNodeSide, MRCAvatarNodeSide);
    self.detailNode.frame = CGRectMake(10 + MRCAvatarNodeSide + 10, 10, self.detailNode.calculatedSize.width, self.detailNode.calculatedSize.height);
}

- (void)didClickAvatarNode:(id)sender {
    [self.viewModel.didClickLinkCommand execute:[NSURL mrc_userLinkWithLogin:self.viewModel.event.actorLogin]];
}

#pragma mark - ASTextNodeDelegate

- (BOOL)textNode:(ASTextNode *)textNode shouldHighlightLinkAttribute:(NSString *)attribute value:(id)value atPoint:(CGPoint)point {
    return YES;
}

- (void)textNode:(ASTextNode *)textNode tappedLinkAttribute:(NSString *)attribute value:(NSURL *)URL atPoint:(CGPoint)point textRange:(NSRange)textRange {
    [self.viewModel.didClickLinkCommand execute:URL];
}

@end
