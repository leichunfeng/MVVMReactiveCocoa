//
//  MRCSelectBranchViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/29.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCSelectBranchViewModel.h"

@interface MRCSelectBranchViewModel ()

@property (strong, nonatomic) OCTRepository *repository;

@end

@implementation MRCSelectBranchViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.repository = params[@"repository"];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.title = @"Select the branch or tag";
    
    @weakify(self)
    [[[self.services.client
    	fetchAllReferencesInRepository:self.repository]
    	collect]
    	subscribeNext:^(NSArray *references) {
            @strongify(self)
            NSArray *array = [references.rac_sequence map:^id(OCTRef *reference) {
                NSMutableDictionary *dictionary = [NSMutableDictionary new];
                [dictionary setValue:reference forKey:@"reference"];
                
                NSArray *components = [reference.name componentsSeparatedByString:@"/"];
                if (components.count == 3) {
                    [dictionary setValue:components.lastObject forKey:@"name"];
                    if ([components[1] isEqualToString:@"heads"]) { // refs/heads/master
                        [dictionary setValue:@"GitBranch" forKey:@"identifier"];
                    } else if ([components[1] isEqualToString:@"tags"]) { // refs/tags/v0.0.1
                        [dictionary setValue:@"Tag" forKey:@"identifier"];
                    }
                }
                
                return [dictionary copy];
            }].array;
            
            self.dataSource = @[array];
        }];
    
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self)
        if (self.callback) {
            self.callback(self.dataSource[indexPath.section][indexPath.row][@"reference"]);
        }
        [self.services dismissViewModelAnimated:YES completion:NULL];
        return [RACSignal empty];
    }];
}

@end
