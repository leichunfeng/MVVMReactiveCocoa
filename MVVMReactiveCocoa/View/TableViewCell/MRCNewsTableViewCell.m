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
@property (nonatomic, weak) IBOutlet YYLabel *detailLabel;

@property (nonatomic, strong) MRCNewsItemViewModel *viewModel;

@end

@implementation MRCNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.detailLabel.numberOfLines = 0;
    
    [self.avatarButton rac_liftSelector:@selector(sd_setBackgroundImageWithURL:forState:)
                            withSignals:RACObserve(self, viewModel.event.actorAvatarURL), [RACSignal return:@(UIControlStateNormal)], nil];
    
    [self.avatarButton addTarget:self action:@selector(didClickAvatarButton:) forControlEvents:UIControlEventTouchUpInside];
    
    RAC(self.detailLabel, attributedText) = RACObserve(self, viewModel.attributedString);
    
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
}

- (void)didClickAvatarButton:(id)sender {
    [self.viewModel.didClickLinkCommand execute:[NSURL mrc_userLinkWithLogin:self.viewModel.event.actorLogin]];
}

@end
