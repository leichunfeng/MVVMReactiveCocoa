//
//  MRCSettingsViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/3/4.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCSettingsViewModel.h"
#import "MRCLoginViewModel.h"
#import "MRCAboutViewModel.h"

@interface MRCSettingsViewModel ()

@property (nonatomic, strong, readwrite) RACCommand *logoutCommand;

@end

@implementation MRCSettingsViewModel

- (void)initialize {
    [super initialize];
    
    self.title = @"Settings";
    
    @weakify(self)
    self.logoutCommand = [[RACCommand alloc] initWithSignalBlock:^(id input) {
        @strongify(self)
        [SSKeychain deleteAccessToken];
        
        [[MRCMemoryCache sharedInstance] removeObjectForKey:@"currentUser"];
        
        MRCLoginViewModel *loginViewModel = [[MRCLoginViewModel alloc] initWithServices:self.services params:nil];
        [self.services resetRootViewModel:loginViewModel];
        
        return [RACSignal empty];
    }];
    
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^(NSIndexPath *indexPath) {
        @strongify(self)
        if (indexPath.section == 1 && indexPath.row == 0) {
            MRCAboutViewModel *aboutViewModel = [[MRCAboutViewModel alloc] initWithServices:self.services params:nil];
            [self.services pushViewModel:aboutViewModel animated:YES];
        }
        return [RACSignal empty];
    }];
}

@end
