//
//  MRCRepoSettingsViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/5/11.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoSettingsViewModel.h"
#import "MRCUserDetailViewModel.h"

@interface MRCRepoSettingsViewModel ()

@property (nonatomic, strong, readwrite) OCTRepository *repository;

@end

@implementation MRCRepoSettingsViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(NSDictionary *)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.repository = params[@"repository"];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.title = @"Settings";
    
    if (self.repository.starredStatus == OCTRepositoryStarredStatusUnknown) {
        BOOL hasStarred = [OCTRepository mrc_hasUserStarredRepository:self.repository];
        self.repository.starredStatus = hasStarred ? OCTRepositoryStarredStatusYES : OCTRepositoryStarredStatusNO;
    }
    
    @weakify(self)
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^(NSIndexPath *indexPath) {
        @strongify(self)
        if (indexPath.section == 0) {
            NSDictionary *dictionary = @{ @"login": self.repository.ownerLogin ?: @"",
                                          @"avatarURL": self.repository.ownerAvatarURL.absoluteString ?: @"" };
            
            MRCUserDetailViewModel *viewModel = [[MRCUserDetailViewModel alloc] initWithServices:self.services params:@{ @"user": dictionary }];
            [self.services pushViewModel:viewModel animated:YES];
        } else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                return [[self.services client] mrc_starRepository:self.repository];
            } else if (indexPath.row == 1) {
                return [[self.services client] mrc_unstarRepository:self.repository];
            }
        }
        return [RACSignal empty];
    }];
}

@end
