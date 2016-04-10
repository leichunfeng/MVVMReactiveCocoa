//
//  MRCExploreViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/3/26.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCTableViewModel.h"
#import "MRCExploreItemViewModel.h"
#import "MRCReposSearchResultsViewModel.h"

@interface MRCExploreViewModel : MRCTableViewModel

@property (nonatomic, copy, readonly) NSArray<NSDictionary *> *showcases;

@property (nonatomic, strong, readonly) RACCommand *requestShowcasesCommand;
@property (nonatomic, strong, readonly) RACCommand *requestTrendingReposCommand;
@property (nonatomic, strong, readonly) RACCommand *requestPopularReposCommand;
@property (nonatomic, strong, readonly) RACCommand *requestPopularUsersCommand;

@property (nonatomic, strong, readonly) MRCReposSearchResultsViewModel *searchResultsViewModel;

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat itemSpacing;

@end
