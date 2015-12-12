//
//  MRCSearchViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCSearchViewModel.h"

@interface MRCSearchViewModel ()

@property (nonatomic, strong, readwrite) MRCReposSearchResultsViewModel *searchResultsViewModel;

@end

@implementation MRCSearchViewModel

- (void)initialize {
    [super initialize];
    
    self.searchResultsViewModel = [[MRCReposSearchResultsViewModel alloc] initWithServices:self.services params:nil];
    
    RAC(self, dataSource) = [[[[NSNotificationCenter defaultCenter]
        rac_addObserverForName:MRCRecentSearchesDidChangeNotification object:nil]
        startWith:nil]
        map:^(id value) {
            MRCSearch *trendingSearch = [[MRCSearch alloc] init];
           
            NSArray *trendingSearchs = @[ trendingSearch ];
            NSArray *recentSearches  = [[MRCSearch recentSearches].rac_sequence take:30].array ?: @[];
            
            return @[ trendingSearchs, recentSearches ];
        }];
}

@end
