//
//  MRCRepositoriesItemViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepositoriesItemViewModel.h"

@interface MRCRepositoriesItemViewModel ()

@property (assign, nonatomic, readwrite) BOOL isFork;
@property (strong, nonatomic, readwrite) NSAttributedString *name;
@property (strong, nonatomic, readwrite) NSString *repoDescription;
@property (strong, nonatomic, readwrite) NSString *language;
@property (assign, nonatomic, readwrite) NSUInteger stargazersCount;
@property (assign, nonatomic, readwrite) NSUInteger forksCount;

@end

@implementation MRCRepositoriesItemViewModel

- (instancetype)initWithRepository:(OCTRepository *)repository {
    self = [super init];
    if (self) {
        if (repository.isStarred) {
            NSString *uniqueName = [NSString stringWithFormat:@"%@/%@", repository.ownerLogin, repository.name];
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:uniqueName];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4183C4) range:[uniqueName rangeOfString:uniqueName]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:UIColor.darkGrayColor range:[uniqueName rangeOfString:[repository.ownerLogin stringByAppendingString:@"/"]]];
            
            self.name = [attributedString copy];
        } else {
            self.name = [[NSAttributedString alloc] initWithString:repository.name];
        }
        
        self.isFork          = repository.fork;
        self.repoDescription = repository.repoDescription;
        self.language        = repository.language ?: @" ";
        self.stargazersCount = repository.stargazersCount;
        self.forksCount      = repository.forksCount;
    }
    return self;
}

@end
