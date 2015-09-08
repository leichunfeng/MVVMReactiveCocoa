//
//  MRCReposItemViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCReposItemViewModel.h"

@interface MRCReposItemViewModel ()

@property (nonatomic, strong, readwrite) OCTRepository *repository;

@property (nonatomic, copy, readwrite) NSAttributedString *name;
@property (nonatomic, copy, readwrite) NSAttributedString *repoDescription;
@property (nonatomic, copy, readwrite) NSString *updateTime;
@property (nonatomic, copy, readwrite) NSString *language;

@property (nonatomic, assign, readwrite) CGFloat height;
@property (nonatomic, assign, readwrite) MRCReposViewModelOptions options;

@end

@implementation MRCReposItemViewModel

- (instancetype)initWithRepository:(OCTRepository *)repository options:(MRCReposViewModelOptions)options {
    self = [super init];
    if (self) {
        self.repository = repository;
     
        self.options = options;
       
        self.language = repository.language ?: @"";
        
        CGFloat height = 0;
        if (self.repository.repoDescription.length > 0) {
            NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:15.0] };
            
            CGFloat width = SCREEN_WIDTH - 38 - 8;
            if (self.options & MRCReposViewModelOptionsSectionIndex) {
                width -= 15;
            }
            
            CGRect rect = [self.repository.repoDescription boundingRectWithSize:CGSizeMake(width, 0)
                                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                                     attributes:attributes
                                                                        context:nil];
            height = MIN(ceil(rect.size.height), 18 * 3);
        }
        self.height = 8 + 21 + 5 + height + 5 + 15 + 8 + 1;
    }
    return self;
}

- (NSAttributedString *)name {
    if (!_name) {
        if (self.options & MRCReposViewModelOptionsShowOwnerLogin) {
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
