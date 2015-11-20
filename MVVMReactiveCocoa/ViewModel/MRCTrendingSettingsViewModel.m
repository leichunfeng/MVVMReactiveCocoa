//
//  MRCTrendingSettingsViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/10/21.
//  Copyright © 2015年 leichunfeng. All rights reserved.
//

#import "MRCTrendingSettingsViewModel.h"

@implementation MRCTrendingSettingsViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(NSDictionary *)params {
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
    self.shouldRequestRemoteDataOnViewDidLoad = NO;
    
    self.sectionIndexTitles = @[ @"Time span", @"Languages" ];
    self.dataSource = @[ MRCTrendingSinces() ?: @[], MRCTrendingLanguages() ?: @[] ];
}

NSArray *MRCTrendingSinces() {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Sinces" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error = nil;
    NSArray *sinces = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) MRCLogError(error);
    
    return sinces;
}

NSArray *MRCTrendingLanguages() {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Languages" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error = nil;
    NSArray *languages = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) MRCLogError(error);
    
    return languages;
}

@end
