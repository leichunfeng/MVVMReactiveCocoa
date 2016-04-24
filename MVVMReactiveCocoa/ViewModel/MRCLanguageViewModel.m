//
//  MRCLanguageViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 16/4/24.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "MRCLanguageViewModel.h"

@implementation MRCLanguageViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(NSDictionary *)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.language = params[@"language"];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.title = @"Language";
    
    NSArray *firstLetters = [MRCTrendingLanguages().rac_sequence map:^(NSDictionary *language) {
        return [language[@"name"] firstLetter];
    }].array;
    
    self.sectionIndexTitles = [[NSSet setWithArray:firstLetters].rac_sequence.array sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    
    self.dataSource = [[[MRCTrendingLanguages().rac_sequence.signal
        groupBy:^(NSDictionary *language) {
            return [language[@"name"] firstLetter];
        }]
        map:^(RACSignal *signal) {
            return signal.sequence;
        }].sequence
        map:^(RACSequence *sequence) {
            return sequence.array;
        }].array;
}

static NSArray *MRCTrendingLanguages() {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Languages" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error = nil;
    NSArray *languages = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) MRCLogError(error);
    
    return languages;
}

@end
