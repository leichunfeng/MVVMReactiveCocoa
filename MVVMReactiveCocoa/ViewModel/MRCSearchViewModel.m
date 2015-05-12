//
//  MRCSearchViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/10.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCSearchViewModel.h"

@implementation MRCSearchViewModel

- (void)initialize {
    [super initialize];
    
    self.title = @"Search";
    
    self.searchResultsViewModel = [[MRCReposSearchResultsViewModel alloc] initWithServices:self.services params:nil];
    
    @weakify(self)
    [[[[NSNotificationCenter defaultCenter]
        rac_addObserverForName:MRC_RECENT_SEARCHES_DID_CHANGE_NOTIFICATION object:nil]
        startWith:[NSNotification notificationWithName:MRC_RECENT_SEARCHES_DID_CHANGE_NOTIFICATION object:nil]]
        subscribeNext:^(id x) {
            @strongify(self)
            NSArray *recentSearches = [MRCSearch mrc_recentSearches];
            if (recentSearches) {
                self.dataSource = @[ recentSearches ];
            } else {
                self.dataSource = nil;
            }
        }];
}

@end
