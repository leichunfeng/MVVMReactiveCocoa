//
//  MRCStarredReposViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/18.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCOwnedReposViewModel.h"

typedef NS_ENUM(NSUInteger, MRCStarredReposViewModelEntryPoint) {
    MRCStarredReposViewModelEntryPointHomepage,
    MRCStarredReposViewModelEntryPointUserDetail
};

@interface MRCStarredReposViewModel : MRCOwnedReposViewModel

@property (nonatomic, assign, readonly) MRCStarredReposViewModelEntryPoint entryPoint;

@end
