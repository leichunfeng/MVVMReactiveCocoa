//
//  MRCOwnedReposViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCOwnedReposViewModel.h"
#import "MRCReposItemViewModel.h"
#import "MRCRepoDetailViewModel.h"

@implementation MRCOwnedReposViewModel

- (void)initialize {
    [super initialize];
    
    @weakify(self)
    [[OCTRepository
		fetchUserRepositories]
     	subscribeNext:^(NSArray *repositories) {
            @strongify(self)
            NSArray *firstLetters = [repositories.rac_sequence
            	map:^id(OCTRepository *repository) {
                    return [[repository.name substringToIndex:1] uppercaseString];
                }].array;
         
         self.sectionIndexTitles = [[NSSet setWithArray:firstLetters].rac_sequence.array sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
         
         NSMutableArray *outerRepositories = [NSMutableArray new];
         
         NSString *firstLetter = [[[repositories.firstObject name] substringToIndex:1] uppercaseString];
         NSMutableArray *innerRepositories = [NSMutableArray new];
         
         for (OCTRepository *repository in repositories) {
             if ([[[repository.name substringToIndex:1] uppercaseString] isEqualToString:firstLetter]) {
                 [innerRepositories addObject:[[MRCReposItemViewModel alloc] initWithRepository:repository]];
             } else {
                 [outerRepositories addObject:innerRepositories];
                 firstLetter = [[repository.name substringToIndex:1] uppercaseString];
                 innerRepositories = [NSMutableArray new];
                 [innerRepositories addObject:[[MRCReposItemViewModel alloc] initWithRepository:repository]];
             }
         }
         [outerRepositories addObject:innerRepositories];
         
         self.dataSource = [outerRepositories copy];
     }];

    [[self.services.client fetchUserRepositories] subscribeNext:^(OCTRepository *repository) {
        [repository save];
    } error:^(NSError *error) {
        
    } completed:^{
        
    }];
    
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self)
        NSDictionary *params = @{ @"repository": [self.dataSource[indexPath.section][indexPath.row] repository] };
        MRCRepoDetailViewModel *detailViewModel = [[MRCRepoDetailViewModel alloc] initWithServices:self.services params:params];
        [self.services pushViewModel:detailViewModel animated:YES];
        return [RACSignal empty];
    }];
}

@end
