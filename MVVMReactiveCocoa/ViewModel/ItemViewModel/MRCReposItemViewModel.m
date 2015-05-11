//
//  MRCReposItemViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCReposItemViewModel.h"
#import "TTTTimeIntervalFormatter.h"

@interface MRCReposItemViewModel ()

@property (strong, nonatomic, readwrite) OCTRepository *repository;
@property (copy, nonatomic, readwrite) NSString *identifier;
@property (assign, nonatomic, readwrite) NSInteger hexRGB;
@property (copy, nonatomic, readwrite) NSString *language;

@end

@implementation MRCReposItemViewModel

- (instancetype)initWithRepository:(OCTRepository *)repository {
    self = [super init];
    if (self) {
        self.repository = repository;
        
        if (repository.isPrivate) {
            self.identifier = @"Lock";
            self.hexRGB = colorI4;
        } else if (repository.isFork) {
            self.identifier = @"RepoForked";
        } else {
            self.identifier = @"Repo";
        }
        
        self.language = repository.language ?: @"";
        
        CGFloat height = 0;
        if (self.repository.repoDescription.length > 0) {
            NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:15.0] };
            CGRect rect = [self.repository.repoDescription boundingRectWithSize:CGSizeMake(self.repoDescriptionWidth, 0)
                                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                                     attributes:attributes
                                                                        context:nil];
            height = MIN(ceil(rect.size.height), 18 * 3);
        }
        self.height = 8 + 21 + 5 + height + 5 + 15 + 8 + 1;
    }
    return self;
}

- (CGFloat)repoDescriptionWidth {
    return SCREEN_WIDTH - 61;
}

- (NSAttributedString *)name {
    if (!_name) {
        if (self.repository.isStarred) {
            NSString *uniqueName = [NSString stringWithFormat:@"%@/%@", self.repository.ownerLogin, self.repository.name];
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:uniqueName];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(colorI3) range:[uniqueName rangeOfString:uniqueName]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:UIColor.darkGrayColor range:[uniqueName rangeOfString:[self.repository.ownerLogin stringByAppendingString:@"/"]]];
            
            _name = attributedString;
        } else {
            _name = [[NSAttributedString alloc] initWithString:self.repository.name];
        }
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
