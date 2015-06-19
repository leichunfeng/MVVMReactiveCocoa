//
//  MRCPublicReposViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/19.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCPublicReposViewModel.h"

@implementation MRCPublicReposViewModel

- (MRCReposViewModelType)type {
    return MRCReposViewModelTypePublic;
}

- (NSArray *)fetchLocalData {
    return [OCTRepository mrc_fetchUserPublicRepositoriesWithPage:0 perPage:0];
}

@end
