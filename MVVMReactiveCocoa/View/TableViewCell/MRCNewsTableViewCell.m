//
//  MRCNewsTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/5/25.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCNewsTableViewCell.h"
#import "MRCNewsItemViewModel.h"

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
    
    RAC(self.detailLabel, attributedText) = RACObserve(self, viewModel.attributedString);
}

- (void)bindViewModel:(MRCNewsItemViewModel *)viewModel {
    self.viewModel = viewModel;
}

@end
