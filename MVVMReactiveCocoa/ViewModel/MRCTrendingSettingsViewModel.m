//
//  MRCTrendingSettingsViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/10/21.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import "MRCTrendingSettingsViewModel.h"

@implementation MRCTrendingSettingsViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.since    = params[@"since"];
        self.language = params[@"language"];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.title = @"Options";
    
    NSArray *sinces = @[
		@"Today",
        @"This week",
        @"This month",
    ];
    
    NSArray *languages = @[
        @"All languages",
        @"ActionScript",
        @"C",
        @"C#",
        @"C++",
        @"Clojure",
        @"CoffeeScript",
        @"CSS",
        @"Go",
        @"Haskell",
        @"HTML",
        @"Java",
        @"JavaScript",
        @"Lua",
        @"Matlab",
        @"Objective-C",
        @"Perl",
        @"PHP",
        @"Python",
        @"R",
        @"Ruby",
        @"Scala",
        @"Shell",
        @"Swift",
        @"TeX",
        @"VimL",
    ];
    
    self.sectionIndexTitles = @[ @"Time span", @"Languages", ];
    self.dataSource = @[ sinces, languages, ];
}

@end
