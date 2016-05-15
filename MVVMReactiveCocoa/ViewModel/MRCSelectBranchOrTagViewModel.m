//
//  MRCSelectBranchOrTagViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/29.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCSelectBranchOrTagViewModel.h"

@interface MRCSelectBranchOrTagViewModel ()

@property (nonatomic, copy) NSArray *references;
@property (nonatomic, strong, readwrite) OCTRef *selectedReference;

@end

@implementation MRCSelectBranchOrTagViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(NSDictionary *)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.references = params[@"references"];
        self.selectedReference = params[@"selectedReference"];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.title = @"Select Branch or Tag";
    
    NSArray *array = [[self.references.rac_sequence
        filter:^BOOL(OCTRef *reference) {
            return [reference.name componentsSeparatedByString:@"/"].count == 3;
        }]
        map:^id(OCTRef *reference) {
            NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
            [dictionary setValue:reference forKey:@"reference"];
            
            [dictionary setValue:[reference.name componentsSeparatedByString:@"/"].lastObject forKey:@"name"];
            [dictionary setValue:reference.octiconIdentifier forKey:@"identifier"];
            
            return dictionary.copy;
        }].array;
    
    self.dataSource = @[ array ];
    
    @weakify(self)
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^(NSIndexPath *indexPath) {
        @strongify(self)
        if (self.callback) {
            self.callback(self.dataSource[indexPath.section][indexPath.row][@"reference"]);
        }
        [self.services dismissViewModelAnimated:YES completion:NULL];
        return [RACSignal empty];
    }];
}

@end
