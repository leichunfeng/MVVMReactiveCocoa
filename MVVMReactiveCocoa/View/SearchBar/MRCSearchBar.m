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

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
        self.searchBarStyle = UISearchBarStyleMinimal;
    }
    return self;
}

- (void)initialize {
    self.tintColor   = HexRGB(colorI5);
    self.placeholder = @"Search";
}

@end
