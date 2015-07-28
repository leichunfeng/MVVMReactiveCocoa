//
//  MRCRepoDetailViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCTableViewModel.h"

@interface MRCRepoDetailViewModel : MRCTableViewModel

@property (strong, nonatomic, readonly) OCTRepository *repository;

@property (copy, nonatomic, readonly) NSArray *references;
@property (strong, nonatomic, readonly) OCTRef *reference;

@property (copy, nonatomic, readonly) NSString *dateUpdated;
@property (copy, nonatomic, readonly) NSString *readmeHTML;
@property (copy, nonatomic, readonly) NSString *summaryReadmeHTML;

@property (strong, nonatomic, readonly) RACCommand *viewCodeCommand;
@property (strong, nonatomic, readonly) RACCommand *readmeCommand;
@property (strong, nonatomic, readonly) RACCommand *selectBranchOrTagCommand;
@property (strong, nonatomic, readonly) RACCommand *rightBarButtonItemCommand;

@end
