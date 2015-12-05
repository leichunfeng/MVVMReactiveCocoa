//
//  MRCSearchBar.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/11/15.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import "MRCSearchBar.h"

@implementation MRCSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib {
    self.layer.borderColor = HexRGB(colorB2).CGColor;
    self.layer.borderWidth = 0.5;
    self.barTintColor = HexRGB(0xF0EFF5);
    [self initialize];
}

- (void)initialize {
    self.tintColor   = HexRGB(colorI5);
    self.placeholder = @"Search";
}

@end
