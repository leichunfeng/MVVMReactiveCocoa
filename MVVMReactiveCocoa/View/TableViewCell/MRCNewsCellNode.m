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

@interface MRCNewsCellNode ()

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
            avatarNode.preferredFrameSize = CGSizeMake(40, 40);
            avatarNode.URL = viewModel.event.actorAvatarURL;

            avatarNode;
        });
        [self addSubnode:self.avatarNode];
        
        self.detailNode = ({
            ASTextNode *detailNode = [[ASTextNode alloc] init];
            detailNode.attributedString = viewModel.attributedString;
            detailNode;
        });
        [self addSubnode:self.detailNode];
    }
    return self;
}

- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize {
    CGSize detailSize = [self.detailNode measure:CGSizeMake(constrainedSize.width - 10 - 40 - 10 - 10, constrainedSize.height)];
    return CGSizeMake(constrainedSize.width, 10 + MAX(40, detailSize.height) + 10);
}

- (void)layout {
    self.avatarNode.frame = CGRectMake(10, 10, 40, 40);
    self.detailNode.frame = CGRectMake(10 + 40 + 10, 10, self.detailNode.calculatedSize.width, self.detailNode.calculatedSize.height);
}

@end
