//
//  MRCProfileViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/7.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCProfileViewModel.h"
#import "MRCSettingsViewModel.h"
#import "MRCUserListViewModel.h"

@interface MRCProfileViewModel ()

@property (strong, nonatomic, readwrite) OCTUser *user;
@property (strong, nonatomic, readwrite) NSString *company;
@property (strong, nonatomic, readwrite) NSString *location;
@property (strong, nonatomic, readwrite) NSString *email;
@property (strong, nonatomic, readwrite) NSString *blog;

@end

@implementation MRCProfileViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.user = params[@"user"] ?: [OCTUser mrc_currentUser];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.title = @"Profile";
    
    self.avatarHeaderViewModel = [[MRCAvatarHeaderViewModel alloc] initWithUser:self.user];
    
    self.avatarHeaderViewModel.followersCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        MRCUserListViewModel *viewModel = [[MRCUserListViewModel alloc] initWithServices:self.services
                                                                                  params:@{ @"type": @0, @"user": self.user }];
        [self.services pushViewModel:viewModel animated:YES];
        return [RACSignal empty];
    }];

    self.avatarHeaderViewModel.followingCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        MRCUserListViewModel *viewModel = [[MRCUserListViewModel alloc] initWithServices:self.services
                                                                                  params:@{ @"type": @1, @"user": self.user }];
        [self.services pushViewModel:viewModel animated:YES];
        return [RACSignal empty];
    }];
    
    id (^map)(NSString *) = ^(NSString *value) {
        return value.length > 0 ? value : @"Not Set";
    };
    
    RAC(self, company) = [RACObserve(self.user, company) map:map];
    RAC(self, location) = [RACObserve(self.user, location) map:map];
    RAC(self, email) = [RACObserve(self.user, email) map:map];
    RAC(self, blog) = [RACObserve(self.user, blog) map:map];
    
    @weakify(self)
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self)
        if (indexPath.section == 1 && indexPath.row == 0) {
            MRCSettingsViewModel *settingsViewModel = [[MRCSettingsViewModel alloc] initWithServices:self.services params:nil];
            [self.services pushViewModel:settingsViewModel animated:YES];
        }
        return [RACSignal empty];
    }];
    
    [self.requestRemoteDataCommand.errors subscribe:self.errors];
}

- (RACSignal *)requestRemoteDataSignal {
    return [[self.services.client
        fetchUserInfoWithUser:self.user]
        doNext:^(OCTUser *user) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.user mergeValuesForKeysFromModel:user];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self.user mrc_saveOrUpdate];
                });
            });
        }];
}

@end
