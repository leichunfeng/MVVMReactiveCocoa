//
//  MRCCountryAndLanguageViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/5/7.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCCountryAndLanguageViewModel.h"
#import "MRCCountryViewModel.h"
#import "MRCLanguageViewModel.h"

@implementation MRCCountryAndLanguageViewModel

- (void)initialize {
    [super initialize];
    
    MRCCountryViewModel *countryViewModel = [[MRCCountryViewModel alloc] initWithServices:self.services
                                                                                   params:@{ @"country": self.params[@"country"] ?: @{} }];
    
    MRCLanguageViewModel *languageViewModel = [[MRCLanguageViewModel alloc] initWithServices:self.services
                                                                                      params:@{ @"language": self.params[@"language"] ?: @{} }];
    
    self.viewModels = @[ countryViewModel, languageViewModel ];
}

@end
