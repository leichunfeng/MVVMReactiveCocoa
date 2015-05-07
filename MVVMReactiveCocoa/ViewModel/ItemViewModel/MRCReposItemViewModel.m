//
//  MRCReposItemViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCReposItemViewModel.h"

@interface MRCReposItemViewModel ()

@property (strong, nonatomic, readwrite) OCTRepository *repository;
@property (strong, nonatomic, readwrite) NSString *identifier;
@property (assign, nonatomic, readwrite) NSInteger hexRGB;
@property (strong, nonatomic, readwrite) NSAttributedString *name;
@property (strong, nonatomic, readwrite) NSString *language;

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
        
        self.language = repository.language ?: @" ";
        
        if (repository.isStarred) {
            NSString *uniqueName = [NSString stringWithFormat:@"%@/%@", repository.ownerLogin, repository.name];
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:uniqueName];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(colorI3) range:[uniqueName rangeOfString:uniqueName]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:UIColor.darkGrayColor range:[uniqueName rangeOfString:[repository.ownerLogin stringByAppendingString:@"/"]]];
            
            self.name = [attributedString copy];
        } else {
            self.name = [[NSAttributedString alloc] initWithString:repository.name];
        }
    }
    return self;
}

- (CGFloat)height {
    if (_height == 0) {
        CGFloat height = 0;
        if (self.repository.repoDescription.length > 0) {
            NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:15.0] };
            CGRect rect = [self.repository.repoDescription boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 61, 0)
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
