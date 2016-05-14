//
//  MRCRepoDetailViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCTableViewModel.h"

@interface MRCRepoDetailViewModel : MRCTableViewModel

@property (nonatomic, strong, readonly) OCTRepository *repository;

@property (nonatomic, copy, readonly) NSArray *references;
@property (nonatomic, strong, readonly) OCTRef *reference;

@property (nonatomic, copy, readonly) NSString *dateUpdated;
@property (nonatomic, copy, readonly) NSString *summaryReadmeHTML;

@property (nonatomic, strong, readonly) RACCommand *viewCodeCommand;
@property (nonatomic, strong, readonly) RACCommand *readmeCommand;
@property (nonatomic, strong, readonly) RACCommand *selectBranchOrTagCommand;
@property (nonatomic, strong, readonly) RACCommand *rightBarButtonItemCommand;

@end
