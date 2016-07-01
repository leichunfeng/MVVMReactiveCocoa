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
@synthesize repoDescription = _repoDescription;
@synthesize updateTime = _updateTime;

- (NSAttributedString *)name {
    if (!_name) {
        NSString *uniqueName = [NSString stringWithFormat:@"%@/%@", self.repository.ownerLogin, self.repository.name];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:uniqueName];
        [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(colorI3) range:[uniqueName rangeOfString:uniqueName]];
        
        for (NSDictionary *textMatche in self.repository.textMatches) {
            if ([textMatche[@"property"] isEqualToString:@"name"]) {
                for (NSDictionary *matche in textMatche[@"matches"]) {
                    NSUInteger loc = [[matche[@"indices"] firstObject] unsignedIntegerValue];
                    NSUInteger len = [[matche[@"indices"] lastObject] unsignedIntegerValue] - loc ;
                    [attributedString addAttribute:NSBackgroundColorAttributeName value:RGBAlpha(255, 255, 140, 0.5) range:NSMakeRange(loc + self.repository.ownerLogin.length + 1, len)];
                }
            }
        }
        
        _name = attributedString;
    }
    return _name;
}

- (NSAttributedString *)repoDescription {
    if (!_repoDescription) {
        NSMutableAttributedString *attributedString = nil;
        
        if (self.repository.repoDescription) {
            attributedString = [[NSMutableAttributedString alloc] initWithString:self.repository.repoDescription];
            for (NSDictionary *textMatche in self.repository.textMatches) {
                if ([textMatche[@"property"] isEqualToString:@"description"]) {
                    for (NSDictionary *matche in textMatche[@"matches"]) {
                        NSUInteger loc = [[matche[@"indices"] firstObject] unsignedIntegerValue];
                        NSUInteger len = [[matche[@"indices"] lastObject] unsignedIntegerValue] - loc ;
                        [attributedString addAttribute:NSBackgroundColorAttributeName value:RGBAlpha(255, 255, 140, 0.5) range:NSMakeRange(loc, len)];
                    }
                }
            }
        }
        
        _repoDescription = attributedString.copy;
        _repoDescription = [_repoDescription attributedSubstringFromRange:NSMakeRange(0, MIN(150, _repoDescription.length))];
    }
    return _repoDescription;
}

- (NSString *)updateTime {
    if (!_updateTime) {
        TTTTimeIntervalFormatter *timeIntervalFormatter = [[TTTTimeIntervalFormatter alloc] init];
        timeIntervalFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        _updateTime = [timeIntervalFormatter stringForTimeIntervalFromDate:[NSDate date] toDate:self.repository.dateUpdated].copy;
    }
    return _updateTime;
}

@end
