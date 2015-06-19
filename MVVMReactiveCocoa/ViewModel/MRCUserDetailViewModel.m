//
//  MRCUserDetailViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/16.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCUserDetailViewModel.h"
#import "MRCStarredReposViewModel.h"

@implementation MRCUserDetailViewModel

- (void)initialize {
    [super initialize];
    
    self.title = self.user.login;
    
    @weakify(self)
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self)
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                MRCStarredReposViewModel *viewModel = [[MRCStarredReposViewModel alloc] initWithServices:self.services
                                                                                                  params:@{ @"user": self.user }];
                [self.services pushViewModel:viewModel animated:YES];
            }
        }
        return [RACSignal empty];
    }];
}

@end
