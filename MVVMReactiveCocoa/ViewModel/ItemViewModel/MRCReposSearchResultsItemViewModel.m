//
//  MRCReposSearchResultsItemViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/11.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCReposSearchResultsItemViewModel.h"

@implementation MRCReposSearchResultsItemViewModel

@synthesize name = _name;

- (CGFloat)repoDescriptionWidth {
    return [super repoDescriptionWidth] + 15;
}

- (NSAttributedString *)name {
    if (!_name) {
        NSString *uniqueName = [NSString stringWithFormat:@"%@/%@", self.repository.ownerLogin, self.repository.name];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:uniqueName];
        [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(colorI3) range:[uniqueName rangeOfString:uniqueName]];
        
        _name = attributedString;
    }
    return _name;
}

@end
