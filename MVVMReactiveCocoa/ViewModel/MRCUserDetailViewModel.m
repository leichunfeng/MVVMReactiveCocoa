//
//  MRCUserDetailViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/16.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCUserDetailViewModel.h"
#import "MRCStarredReposViewModel.h"
#import "MRCNewsViewModel.h"

@implementation MRCUserDetailViewModel

- (void)initialize {
    [super initialize];
    
    self.title = self.user.login;
    
    @weakify(self)
    if (![self.user.objectID isEqualToString:[OCTUser mrc_currentUserId]]) { // Exclude myself
        self.avatarHeaderViewModel.operationCommand = [[RACCommand alloc] initWithSignalBlock:^(id _) {
            @strongify(self)
            if (self.user.followingStatus == OCTUserFollowingStatusYES) {
                return [[self.services client] mrc_unfollowUser:self.user];
            } else if (self.user.followingStatus == OCTUserFollowingStatusNO) {
                return [[self.services client] mrc_followUser:self.user];
            }
            return [RACSignal empty];
        }];
    }

    if (self.user.followingStatus == OCTUserFollowingStatusUnknown) {
        [[[self.services
        	client]
        	doesFollowUser:self.user]
        	subscribeNext:^(NSNumber *isFollowing) {
                @strongify(self)
             	if (isFollowing.boolValue) {
                 	self.user.followingStatus = OCTUserFollowingStatusYES;
             	} else {
                 	self.user.followingStatus = OCTUserFollowingStatusNO;
             	}
         	}];
    }
    
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^(NSIndexPath *indexPath) {
        @strongify(self)
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                NSDictionary *params = @{ @"entryPoint": @(MRCStarredReposViewModelEntryPointUserDetail), @"user": self.user };
                
                MRCStarredReposViewModel *viewModel = [[MRCStarredReposViewModel alloc] initWithServices:self.services params:params];
                
                [self.services pushViewModel:viewModel animated:YES];
            } else if (indexPath.row == 2) {
                MRCNewsViewModel *viewModel = [[MRCNewsViewModel alloc] initWithServices:self.services
                                                                                  params:@{ @"type": @(MRCNewsViewModelTypePublicActivity),
                                                                                            @"user": self.user }];
                [self.services pushViewModel:viewModel animated:YES];
            }
        }
        return [RACSignal empty];
    }];
}

@end
