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
@property (strong, nonatomic, readwrite) NSAttributedString *name;
@property (strong, nonatomic, readwrite) NSString *language;

@end

@implementation MRCReposItemViewModel

- (instancetype)initWithRepository:(OCTRepository *)repository {
    self = [super init];
    if (self) {
        self.repository = repository;
        self.identifier = repository.isFork ? @"RepoForked" : @"Repo";
        self.language   = repository.language ?: @" ";
        
        if (repository.isStarred) {
            NSString *uniqueName = [NSString stringWithFormat:@"%@/%@", repository.ownerLogin, repository.name];
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:uniqueName];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4183C4) range:[uniqueName rangeOfString:uniqueName]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:UIColor.darkGrayColor range:[uniqueName rangeOfString:[repository.ownerLogin stringByAppendingString:@"/"]]];
            
            self.name = [attributedString copy];
        } else {
            self.name = [[NSAttributedString alloc] initWithString:repository.name];
        }
    }
    return self;
}

@end
