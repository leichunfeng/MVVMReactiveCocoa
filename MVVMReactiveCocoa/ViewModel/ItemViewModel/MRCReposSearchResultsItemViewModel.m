//
//  MRCReposSearchResultsItemViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/11.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCReposSearchResultsItemViewModel.h"
#import "TTTTimeIntervalFormatter.h"

@implementation MRCReposSearchResultsItemViewModel

@synthesize name = _name;
@synthesize updateTime = _updateTime;

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

- (NSString *)updateTime {
    if (!_updateTime) {
        TTTTimeIntervalFormatter *timeIntervalFormatter = [TTTTimeIntervalFormatter new];
        timeIntervalFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        _updateTime = [timeIntervalFormatter stringForTimeIntervalFromDate:[NSDate date] toDate:self.repository.dateUpdated].copy;
    }
    return _updateTime;
}

@end
