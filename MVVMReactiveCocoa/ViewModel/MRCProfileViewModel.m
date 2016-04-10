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
#import "MRCPublicReposViewModel.h"

@interface MRCProfileViewModel ()

@property (nonatomic, strong, readwrite) OCTUser *user;

@property (nonatomic, copy, readwrite) NSString *company;
@property (nonatomic, copy, readwrite) NSString *location;
@property (nonatomic, copy, readwrite) NSString *email;
@property (nonatomic, copy, readwrite) NSString *blog;

@property (nonatomic, strong, readwrite) MRCAvatarHeaderViewModel *avatarHeaderViewModel;

@end

@implementation MRCProfileViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(NSDictionary *)params {
    self = [super initWithServices:services params:params];
    if (self) {
        id user = params[@"user"];

        if ([user isKindOfClass:[OCTUser class]]) {
            self.user = params[@"user"];
        } else if ([user isKindOfClass:[NSDictionary class]]) {
            self.user = [OCTUser modelWithDictionary:user error:nil];
        } else {
            self.user = [OCTUser mrc_currentUser];
        }
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.title = @"Profile";
    
    self.avatarHeaderViewModel = [[MRCAvatarHeaderViewModel alloc] initWithUser:self.user];
    
    @weakify(self)
    self.avatarHeaderViewModel.followersCommand = [[RACCommand alloc] initWithSignalBlock:^(id input) {
        @strongify(self)
        MRCUserListViewModel *viewModel = [[MRCUserListViewModel alloc] initWithServices:self.services
                                                                                  params:@{ @"type": @0, @"user": self.user }];
        [self.services pushViewModel:viewModel animated:YES];
        return [RACSignal empty];
    }];
    
    self.avatarHeaderViewModel.repositoriesCommand = [[RACCommand alloc] initWithSignalBlock:^(id input) {
        @strongify(self)
        MRCPublicReposViewModel *viewModel = [[MRCPublicReposViewModel alloc] initWithServices:self.services
                                                                                        params:@{ @"user": self.user }];
        [self.services pushViewModel:viewModel animated:YES];
        return [RACSignal empty];
    }];

    self.avatarHeaderViewModel.followingCommand = [[RACCommand alloc] initWithSignalBlock:^(id input) {
        @strongify(self)
        MRCUserListViewModel *viewModel = [[MRCUserListViewModel alloc] initWithServices:self.services
                                                                                  params:@{ @"type": @1, @"user": self.user }];
        [self.services pushViewModel:viewModel animated:YES];
        return [RACSignal empty];
    }];
    
    id (^map)(NSString *) = ^(NSString *value) {
        return (value.length > 0 && ![value isEqualToString:@"(null)"]) ? value : MRC_EMPTY_PLACEHOLDER;
    };
    
    RAC(self, company)  = [RACObserve(self.user, company) map:map];
    RAC(self, location) = [RACObserve(self.user, location) map:map];
    RAC(self, email)    = [RACObserve(self.user, email) map:map];
    RAC(self, blog)     = [RACObserve(self.user, blog) map:map];
    
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^(NSIndexPath *indexPath) {
        @strongify(self)
        if (indexPath.section == 1 && indexPath.row == 0) {
            MRCSettingsViewModel *settingsViewModel = [[MRCSettingsViewModel alloc] initWithServices:self.services params:nil];
            [self.services pushViewModel:settingsViewModel animated:YES];
        }
        return [RACSignal empty];
    }];
    
    RACSignal *fetchLocalDataSignal = [RACSignal return:[self fetchLocalData]];
    RACSignal *requestRemoteDataSignal = self.requestRemoteDataCommand.executionSignals.switchToLatest;
    
    [[[fetchLocalDataSignal
    	merge:requestRemoteDataSignal]
     	deliverOnMainThread]
    	subscribeNext:^(OCTUser *user) {
            @strongify(self)
            [self willChangeValueForKey:@"user"];
            user.followingStatus = self.user.followingStatus;
            [self.user mergeValuesForKeysFromModel:user];
            [self didChangeValueForKey:@"user"];
        }];
}

- (OCTUser *)fetchLocalData {
    return [OCTUser mrc_fetchUser:self.user];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    return [[[self.services.client
        fetchUserInfoForUser:self.user]
        retry:3]
        doNext:^(OCTUser *user) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [user mrc_saveOrUpdate];
            });
        }];
}

@end
