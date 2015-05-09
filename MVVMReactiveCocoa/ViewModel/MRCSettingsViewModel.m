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

@implementation MRCSettingsViewModel

- (void)initialize {
    [super initialize];
    
    self.title = @"Settings";
    
    @weakify(self)
    self.logoutCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        [SSKeychain deleteAccessToken];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        MRCLoginViewModel *loginViewModel = [[MRCLoginViewModel alloc] initWithServices:self.services params:nil];
        [self.services resetRootViewModel:loginViewModel];
        
        return [RACSignal empty];
    }];
    
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self)
        if (indexPath.section == 1 && indexPath.row == 0) {
            MRCAboutViewModel *aboutViewModel = [[MRCAboutViewModel alloc] initWithServices:self.services params:nil];
            [self.services pushViewModel:aboutViewModel animated:YES];
        }
        return [RACSignal empty];
    }];
}

@end
