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
        self.item = params[@"language"];
    }
    return self;
}

- (void)initialize {
    [super initialize];

    NSString *filePath = [[NSBundle mainBundle] pathForResource:[self resourceName] ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error = nil;
    NSArray *items = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error) MRCLogError(error);

    @weakify(self)
    RAC(self, dataSource) = [[[RACObserve(self, keyword)
        map:^(NSString *keyword) {
            if (keyword.length == 0) return items;
            
            return [items.rac_sequence filter:^(NSDictionary *item) {
                NSString *name = item[@"name"];
                return [name localizedCaseInsensitiveContainsString:keyword];
            }].array;
        }]
        doNext:^(NSArray *items) {
            @strongify(self)

            NSArray *firstLetters = [items.rac_sequence map:^(NSDictionary *item) {
                return [item[@"name"] firstLetter];
            }].array;

            firstLetters = [NSSet setWithArray:firstLetters].allObjects;

            self.sectionIndexTitles = [firstLetters sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
        }]
        map:^(NSArray *items) {
            return [[[items.rac_sequence.signal
                groupBy:^(NSDictionary *item) {
                    return [item[@"name"] firstLetter];
                }]
                map:^(RACSignal *signal) {
                    return signal.sequence;
                }].sequence
                map:^(RACSequence *sequence) {
                    return sequence.array;
                }].array;
        }];
}

- (NSString *)title {
    return @"Language";
}

- (NSString *)resourceName {
    return @"Languages";
}

@end
