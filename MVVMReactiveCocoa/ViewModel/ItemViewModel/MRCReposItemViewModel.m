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
@property (copy, nonatomic, readwrite) NSString *identifier;
@property (assign, nonatomic, readwrite) NSInteger hexRGB;
@property (copy, nonatomic, readwrite) NSString *language;
@property (assign, nonatomic) MRCReposItemViewModelOptions options;

@end

@implementation MRCReposItemViewModel

- (instancetype)initWithRepository:(OCTRepository *)repository {
    return [self initWithRepository:repository options:0];
}

- (instancetype)initWithRepository:(OCTRepository *)repository options:(MRCReposItemViewModelOptions)options {
    self = [super init];
    if (self) {
        self.repository = repository;
        self.options = options;
        
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
            CGRect rect = [self.repository.repoDescription boundingRectWithSize:CGSizeMake(self.repoDesWidth, 0)
                                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                                     attributes:attributes
                                                                        context:nil];
            height = MIN(ceil(rect.size.height), 18 * 3);
        }
        self.height = 8 + 21 + 5 + height + 5 + 15 + 8 + 1;
    }
    return self;
}

- (CGFloat)repoDesWidth {
    return SCREEN_WIDTH - 61;
}

- (NSAttributedString *)name {
    if (!_name) {
        if (self.options & MRCReposItemViewModelOptionsShowOwnerLogin) {
            NSString *uniqueName = [NSString stringWithFormat:@"%@/%@", self.repository.ownerLogin, self.repository.name];
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:uniqueName];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(colorI3) range:[uniqueName rangeOfString:uniqueName]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:UIColor.darkGrayColor range:[uniqueName rangeOfString:[self.repository.ownerLogin stringByAppendingString:@"/"]]];
            
            _name = attributedString.copy;
        } else {
            _name = [[NSAttributedString alloc] initWithString:self.repository.name].copy;
        }
    }
    return _name;
}

@end
