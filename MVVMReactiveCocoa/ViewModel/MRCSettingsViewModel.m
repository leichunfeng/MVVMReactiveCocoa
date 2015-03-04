//
//  MRCSettingsViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/3/4.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCSettingsViewModel.h"
#import "MRCLoginViewModel.h"

@implementation MRCSettingsViewModel

- (void)initialize {
    [super initialize];
    
    self.title = @"Settings";
    
    @weakify(self)
    self.logoutCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        [SSKeychain deleteAccessToken];
        
        MRCLoginViewModel *loginViewModel = [[MRCLoginViewModel alloc] initWithServices:self.services params:nil];
        [self.services resetRootViewModel:loginViewModel];
        
        return RACSignal.empty;
    }];
}

@end
