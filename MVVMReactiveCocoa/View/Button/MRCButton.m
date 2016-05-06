//
//  MRCButton.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/6.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCButton.h"

@implementation MRCButton

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

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (UIColor *)titleColorForState:(UIControlState)state {
    switch (state) {
        case UIControlStateNormal:
        case UIControlStateHighlighted:
        case UIControlStateSelected:
        case UIControlStateApplication:
        case UIControlStateReserved:
            return HexRGB(0xffffff);
        case UIControlStateDisabled:
            return HexRGB(0xCFCFCF);
        default:
            break;
    }
    return nil;
}

- (UIImage *)backgroundImageForState:(UIControlState)state {
    switch (state) {
        case UIControlStateNormal:
            return HexRGB(0x576871).color2Image;
        case UIControlStateHighlighted:
        case UIControlStateSelected:
        case UIControlStateApplication:
        case UIControlStateReserved:
            return HexRGB(0x41525B).color2Image;
        case UIControlStateDisabled:
            return HexRGB(0x6D7E87).color2Image;
        default:
            break;
    }
    return nil;
}

- (void)initialize {
    self.layer.cornerRadius  = 3;
    self.layer.masksToBounds = YES;
    
    [self setBackgroundImage:[self backgroundImageForState:UIControlStateNormal] forState:UIControlStateNormal];
    [self setBackgroundImage:[self backgroundImageForState:UIControlStateDisabled] forState:UIControlStateDisabled];
    [self setBackgroundImage:[self backgroundImageForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
   
    [self setTitleColor:[self titleColorForState:UIControlStateNormal] forState:UIControlStateNormal];
    [self setTitleColor:[self titleColorForState:UIControlStateDisabled] forState:UIControlStateDisabled];
    [self setTitleColor:[self titleColorForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
}

@end
