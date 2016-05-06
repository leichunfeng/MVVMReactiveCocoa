//
//  MRCFollowButton.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/17.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCFollowButton.h"

#define MRC_FOLLOW_BUTTON_IMAGE_SIZE CGSizeMake(16, 16)

static UIImage *_image = nil;
static UIImage *_selectedImage = nil;

@implementation MRCFollowButton

- (id)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _image = [UIImage octicon_imageWithIcon:@"Person"
                                backgroundColor:[UIColor clearColor]
                                      iconColor:HexRGB(0xffffff)
                                      iconScale:1
                                        andSize:MRC_FOLLOW_BUTTON_IMAGE_SIZE];
        _selectedImage = [UIImage octicon_imageWithIcon:@"Person"
                                        backgroundColor:[UIColor clearColor]
                                              iconColor:HexRGB(0x333333)
                                              iconScale:1
                                                andSize:MRC_FOLLOW_BUTTON_IMAGE_SIZE];
    });
    
    self.layer.borderColor = HexRGB(0xd5d5d5).CGColor;
    self.layer.cornerRadius  = 5;
    self.layer.masksToBounds = YES;
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    self.contentEdgeInsets = UIEdgeInsetsMake(7, 1, 7, 3);
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];

    if (!selected) {
        [self setImage:_image forState:UIControlStateNormal];
        [self setTitle:@"Follow" forState:UIControlStateNormal];
        [self setTitleColor:HexRGB(0xffffff) forState:UIControlStateNormal];
        
        self.backgroundColor = HexRGB(0x569e3d);
        self.layer.borderWidth = 0;
    } else {
        [self setImage:_selectedImage forState:UIControlStateNormal];
        [self setTitle:@"Unfollow" forState:UIControlStateNormal];
        [self setTitleColor:HexRGB(0x333333) forState:UIControlStateNormal];
        
        self.backgroundColor = HexRGB(0xeeeeee);
        self.layer.borderWidth = 1;
    }
}

@end
