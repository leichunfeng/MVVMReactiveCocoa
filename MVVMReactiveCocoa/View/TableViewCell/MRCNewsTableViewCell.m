//
//  MRCNewsTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/5/25.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCNewsTableViewCell.h"
#import "MRCNewsItemViewModel.h"

extern NSString * const MRCLinkAttributeName;

@interface MRCNewsTableViewCell ()

@property (nonatomic, weak) IBOutlet UIButton *avatarButton;

@property (nonatomic, strong) YYLabel *detailLabel;
@property (nonatomic, strong) MRCNewsItemViewModel *viewModel;

@end

@implementation MRCNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.detailLabel = [[YYLabel alloc] init];
    [self.contentView addSubview:self.detailLabel];
    
    self.detailLabel.top   = 10;
    self.detailLabel.left  = 60;
    self.detailLabel.width = SCREEN_WIDTH - 10 - 40 - 10 - 10;
    
    self.detailLabel.displaysAsynchronously = YES;
    self.detailLabel.ignoreCommonProperties = YES;
    
    [self.avatarButton addTarget:self action:@selector(didClickAvatarButton:) forControlEvents:UIControlEventTouchUpInside];
    
    @weakify(self)
    self.detailLabel.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        @strongify(self)

        text = [text attributedSubstringFromRange:range];
        
        NSDictionary *attributes = [text attributesAtIndex:0 effectiveRange:NULL];
        NSURL *URL = attributes[MRCLinkAttributeName];
        
        [self.viewModel.didClickLinkCommand execute:URL];
    };
}

- (void)bindViewModel:(MRCNewsItemViewModel *)viewModel {
    self.viewModel = viewModel;
    
    [self.avatarButton sd_setImageWithURL:viewModel.event.actorAvatarURL forState:UIControlStateNormal];

    self.detailLabel.height = viewModel.textLayout.textBoundingSize.height;
    self.detailLabel.textLayout = viewModel.textLayout;
}

- (void)didClickAvatarButton:(id)sender {
    [self.viewModel.didClickLinkCommand execute:[NSURL mrc_userLinkWithLogin:self.viewModel.event.actorLogin]];
}

@end
