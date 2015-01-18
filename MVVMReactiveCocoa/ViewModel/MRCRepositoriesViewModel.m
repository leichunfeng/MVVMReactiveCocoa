//
//  MRCRepositoriesViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepositoriesViewModel.h"
#import "MRCRepositoriesItemViewModel.h"
#import "MRCStarredRepositoriesItemViewModel.h"

@interface MRCRepositoriesViewModel ()

@property (strong, nonatomic) NSArray *repositories;
@property (strong, nonatomic) NSArray *starredRepositories;

@property (strong, nonatomic) NSArray *reposSectionIndexTitles;
@property (strong, nonatomic) NSArray *starredReposSectionIndexTitles;

@end

@implementation MRCRepositoriesViewModel

- (void)initialize {
    [super initialize];
    
    [RACObserve(self, selectedSegmentIndex) subscribeNext:^(NSNumber *selectedSegmentIndex) {
        self.sectionIndexTitles = [selectedSegmentIndex integerValue] == 0 ? self.reposSectionIndexTitles : self.starredReposSectionIndexTitles;
        self.dataSource = [selectedSegmentIndex integerValue] == 0 ? self.repositories : self.starredRepositories;
    }];
    
    @weakify(self)
    [[OCTRepository
        fetchUserRepositories]
        subscribeNext:^(NSArray *repositories) {
            @strongify(self)
            NSArray *firstLetters = [repositories.rac_sequence
            	map:^id(OCTRepository *repository) {
                    return [[repository.name substringToIndex:1] uppercaseString];
                }].array;
            
            self.reposSectionIndexTitles = [[NSSet setWithArray:firstLetters].rac_sequence.array sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
            
            NSMutableArray *outerRepositories = [NSMutableArray new];
            
            NSString *firstLetter = [[[repositories.firstObject name] substringToIndex:1] uppercaseString];
            NSMutableArray *innerRepositories = [NSMutableArray new];

            for (OCTRepository *repository in repositories) {
                if ([[[repository.name substringToIndex:1] uppercaseString] isEqualToString:firstLetter]) {
                    [innerRepositories addObject:[[MRCRepositoriesItemViewModel alloc] initWithRepository:repository]];
                } else {
                    [outerRepositories addObject:innerRepositories];
                    firstLetter = [[repository.name substringToIndex:1] uppercaseString];
                    innerRepositories = [NSMutableArray new];
                    [innerRepositories addObject:[[MRCRepositoriesItemViewModel alloc] initWithRepository:repository]];
                }
            }
            [outerRepositories addObject:innerRepositories];
            
            self.repositories = [outerRepositories copy];
        }];
    
    [[OCTRepository
        fetchUserStarredRepositories]
        subscribeNext:^(NSArray *repositories) {
            @strongify(self)
            NSArray *firstLetters = [repositories.rac_sequence
                map:^id(OCTRepository *repository) {
                	return [[repository.name substringToIndex:1] uppercaseString];
                }].array;
            
            self.starredReposSectionIndexTitles = [[NSSet setWithArray:firstLetters].rac_sequence.array sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
            
            NSMutableArray *outerRepositories = [NSMutableArray new];
            
            NSString *firstLetter = [[[repositories.firstObject name] substringToIndex:1] uppercaseString];
            NSMutableArray *innerRepositories = [NSMutableArray new];
            
            for (OCTRepository *repository in repositories) {
                if ([[[repository.name substringToIndex:1] uppercaseString] isEqualToString:firstLetter]) {
                    [innerRepositories addObject:[[MRCRepositoriesItemViewModel alloc] initWithRepository:repository]];
                } else {
                    [outerRepositories addObject:innerRepositories];
                    firstLetter = [[repository.name substringToIndex:1] uppercaseString];
                    innerRepositories = [NSMutableArray new];
                    [innerRepositories addObject:[[MRCRepositoriesItemViewModel alloc] initWithRepository:repository]];
                }
            }
            [outerRepositories addObject:innerRepositories];
            
            self.starredRepositories = [outerRepositories copy];
        }];
    
    [[self.services.client fetchUserRepositories] subscribeNext:^(OCTRepository *repository) {
        [repository save];
    } error:^(NSError *error) {
        
    } completed:^{
        
    }];
    
    [[self.services.client fetchUserStarredRepositories] subscribeNext:^(OCTRepository *repository) {
        [repository setStarred:YES];
        [repository save];
    } error:^(NSError *error) {
        
    } completed:^{
        
    }];
}

@end
