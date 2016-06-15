//
//  MRCShowcaseHeaderView.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/4/24.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCShowcaseHeaderView.h"
#import "MRCShowcaseHeaderViewModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MRCShowcaseHeaderView ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *descLabel;

@property (nonatomic, strong) MRCShowcaseHeaderViewModel *viewModel;

@end

@implementation MRCShowcaseHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIView *borderView = [self createViewBackedBottomBorderWithHeight:MRC_1PX_WIDTH andColor:HexRGB(colorB2)];
    [self addSubview:borderView];
    
    borderView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[borderView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(borderView)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[borderView(height)]|"
                                                                 options:0
                                                                 metrics:@{ @"height": @(MRC_1PX_WIDTH) }
                                                                   views:NSDictionaryOfVariableBindings(borderView)]];
}

- (void)bindViewModel:(MRCShowcaseHeaderViewModel *)viewModel {
    self.viewModel = viewModel;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:viewModel.imageURL]
                      placeholderImage:nil];
   
    self.nameLabel.text = viewModel.name;
    self.descLabel.text = viewModel.desc.length > 0 ? viewModel.desc : @"No description";
}

@end
