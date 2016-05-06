//
//  MRCExploreCollectionViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/3/27.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCExploreCollectionViewCell.h"
#import "MRCExploreCollectionViewCellViewModel.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "UIImage+RTTint.h"

@interface MRCExploreCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@property (nonatomic, strong) MRCExploreCollectionViewCellViewModel *viewModel;

@end

@implementation MRCExploreCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.avatarImageView.layer.cornerRadius  = 15;
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)bindViewModel:(MRCExploreCollectionViewCellViewModel *)viewModel {
    self.viewModel = viewModel;
    
    [self.avatarImageView sd_setImageWithURL:viewModel.avatarURL
                            placeholderImage:[HexRGB(colorI6) color2ImageSized:self.avatarImageView.frame.size]];
    
    self.nameLabel.text = viewModel.name;
}

@end
