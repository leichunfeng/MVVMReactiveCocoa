//
//  MRCReposItemViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCReposItemViewModel.h"

@interface MRCReposItemViewModel ()

@property (strong, nonatomic, readwrite) NSDictionary *repoDictionary;
@property (strong, nonatomic, readwrite) NSString *identifier;
@property (assign, nonatomic, readwrite) NSInteger hexRGB;
@property (strong, nonatomic, readwrite) NSAttributedString *name;
@property (strong, nonatomic, readwrite) NSString *language;

@end

@implementation MRCReposItemViewModel

- (instancetype)initWithRepoDictionary:(NSDictionary *)repoDictionary {
    self = [super init];
    if (self) {
        self.repoDictionary = repoDictionary;
    }
    return self;
}

- (void)setRepository:(OCTRepository *)repository {
    _repository = repository;
    
    if (_repository.isPrivate) {
        self.identifier = @"Lock";
        self.hexRGB = colorI4;
    } else if (_repository.isFork) {
        self.identifier = @"RepoForked";
    } else {
        self.identifier = @"Repo";
    }
    
    self.language = _repository.language ?: @" ";
    
    if (_repository.isStarred) {
        NSString *uniqueName = [NSString stringWithFormat:@"%@/%@", _repository.ownerLogin, _repository.name];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:uniqueName];
        [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(colorI3) range:[uniqueName rangeOfString:uniqueName]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:UIColor.darkGrayColor range:[uniqueName rangeOfString:[_repository.ownerLogin stringByAppendingString:@"/"]]];
        
        self.name = [attributedString copy];
    } else {
        self.name = [[NSAttributedString alloc] initWithString:_repository.name];
    }
}

- (CGFloat)height {
    if (_height == 0) {
        CGFloat height = 0;
        if ([self.repoDictionary[@"description"] length] > 0) {
            NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:15.0] };
            CGRect rect = [self.repoDictionary[@"description"] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 61, 0)
                                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                                         attributes:attributes
                                                                            context:nil];
            height = MIN(ceil(rect.size.height), 54);
        }
        _height = 8 + 21 + 3 + height + 5 + 14 + 7;
    }
    return _height;
}

@end
