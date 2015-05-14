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
                return [[self.services client] mrc_starRepository:self.repository];
            }
        } else if (indexPath.row == 1) {
            @onExit {
                self.isStarred = NO;
            };
            
            if (self.isStarred) {
                return [[self.services client] mrc_unstarRepository:self.repository];
            }
        }
        return [RACSignal empty];
    }];
}

@end
