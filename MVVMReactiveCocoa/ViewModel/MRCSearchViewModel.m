//
//  MRCSearchViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCSearchViewModel.h"

@interface MRCSearchViewModel ()

@property (strong, nonatomic, readwrite) MRCReposSearchResultsViewModel *searchResultsViewModel;

@end

@implementation MRCSearchViewModel

- (void)initialize {
    [super initialize];
    
    self.title = @"Search";
        
    self.searchResultsViewModel = [[MRCReposSearchResultsViewModel alloc] initWithServices:self.services params:nil];
    
    RAC(self, dataSource) = [[[[NSNotificationCenter defaultCenter]
        rac_addObserverForName:MRCRecentSearchesDidChangeNotification object:nil]
        startWith:nil]
        map:^(id value) {
            NSArray *recentSearches = [MRCSearch recentSearches];
            return recentSearches ? @[ recentSearches ] : nil;
        }];
}

@end
