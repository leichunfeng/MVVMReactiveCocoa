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

@property (strong, nonatomic) NSArray *references;
@property (strong, nonatomic) OCTRef *reference;

@property (strong, nonatomic) NSAttributedString *readmeAttributedString;

@property (strong, nonatomic) RACCommand *viewCodeCommand;
@property (strong, nonatomic) RACCommand *readmeCommand;
@property (strong, nonatomic) RACCommand *selectBranchOrTagCommand;

@end
