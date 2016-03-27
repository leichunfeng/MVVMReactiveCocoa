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

@interface MRCExploreCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UIButton *avatarButton;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@property (nonatomic, strong) MRCExploreCollectionViewCellViewModel *viewModel;

@end

@implementation MRCExploreCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.avatarButton.layer.cornerRadius = 15;
    self.avatarButton.clipsToBounds = YES;
    self.avatarButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)bindViewModel:(MRCExploreCollectionViewCellViewModel *)viewModel {
    self.viewModel = viewModel;
    
    [self.avatarButton sd_setImageWithURL:viewModel.avatarURL
                                 forState:UIControlStateNormal
                         placeholderImage:[HexRGB(colorI6) color2ImageSized:CGSizeMake(70, 70)]];
    
    self.nameLabel.text = viewModel.name;
}

@end
