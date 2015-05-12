//
//  MRCRepoSettingsViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/11.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoSettingsViewModel.h"

@interface MRCRepoSettingsViewModel ()

@property (strong, nonatomic) OCTRepository *repository;

@end

@implementation MRCRepoSettingsViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.repository = params[@"repository"];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.title = @"Settings";
    
    self.repository.isStarred = [self.repository hasUserStarred];
    self.isStarred = self.repository.isStarred;
    
    @weakify(self)
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self)
        if (indexPath.row == 0) {
            @onExit {
                self.isStarred = YES;
            };
            
            if (!self.isStarred) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    self.repository.isStarred = YES;
                    if ([self.repository mrc_saveOrUpdate]) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:MRC_STARRED_REPOS_DID_CHANGE_NOTIFICATION object:self];
                    }
                });
                return [[self.services client] starRepository:self.repository];
            }
        } else if (indexPath.row == 1) {
            @onExit {
                self.isStarred = NO;
            };
            
            if (self.isStarred) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    if ([self.repository mrc_delete]) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:MRC_STARRED_REPOS_DID_CHANGE_NOTIFICATION object:self];
                    }
                });
                return [[self.services client] unstarRepository:self.repository];
            }
        }
        return [RACSignal empty];
    }];
}

@end
