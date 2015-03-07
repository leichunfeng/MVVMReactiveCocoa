//
//  MRCTableViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 14/12/27.
//  Copyright (c) 2014年 leichunfeng. All rights reserved.
//

#import "MRCViewModel.h"

@interface MRCTableViewModel : MRCViewModel

// The data source of table view.
@property (strong, nonatomic) NSArray *dataSource;

// The list of section titles to display in section index view.
@property (strong, nonatomic) NSArray *sectionIndexTitles;

@property (nonatomic) BOOL shouldPullToRefresh;
@property (nonatomic) BOOL shouldDisplayEmptyDataSet;

@property (strong, nonatomic) RACCommand *didSelectCommand;

@property (strong, nonatomic, readonly) RACCommand *requestRemoteDataCommand;

- (RACSignal *)fetchLocalDataSignal;

- (RACSignal *)requestRemoteDataSignal;

@end
