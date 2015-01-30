//
//  MRCGitTreeViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/29.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCGitTreeViewModel.h"

@interface MRCGitTreeViewModel ()

@property (strong, nonatomic) OCTRepository *repository;
@property (strong, nonatomic) NSString *reference;

@end

@implementation MRCGitTreeViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.title = params[@"title"];
        self.repository = params[@"repository"];
        self.reference  = params[@"reference"];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    @weakify(self)
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self)
        OCTTreeEntry *treeEntry = self.dataSource[indexPath.section][indexPath.row][@"treeEntry"];
        
        if (treeEntry.type == OCTTreeEntryTypeTree) {
            MRCGitTreeViewModel *gitTreeViewModel = [[MRCGitTreeViewModel alloc] initWithServices:self.services
                                                                                           params:@{@"title": treeEntry.path,
                                                                                                    @"repository": self.repository,
                                                                                                    @"reference": treeEntry.SHA}];
            [self.services pushViewModel:gitTreeViewModel animated:YES];
        }

        return [RACSignal empty];
    }];
}

- (RACSignal *)requestRemoteDataSignal {
    return [[self.services.client
		fetchTreeForReference:self.reference inRepository:self.repository recursive:NO]
     	doNext:^(OCTTree *tree) {
            NSArray *array = [tree.entries.rac_sequence filter:^BOOL(OCTTreeEntry *treeEntry) {
                return treeEntry.type != OCTTreeEntryTypeCommit;
            }].array;
            
            array = [array sortedArrayUsingComparator:^NSComparisonResult(OCTTreeEntry *treeEntry1, OCTTreeEntry *treeEntry2) {
                if (treeEntry1.type == treeEntry2.type) {
                    return [treeEntry1.path caseInsensitiveCompare:treeEntry2.path];
                } else {
                    return treeEntry1.type == OCTTreeEntryTypeTree ? NSOrderedAscending : NSOrderedDescending;
                }
            }];
            
            array = [array.rac_sequence map:^id(OCTTreeEntry *treeEntry) {
                NSMutableDictionary *dictionary = [NSMutableDictionary new];
                
                NSString *identifier = (treeEntry.type == OCTTreeEntryTypeTree ? @"FileDirectory" : @"FileText");
                
                [dictionary setValue:treeEntry forKey:@"treeEntry"];
                [dictionary setValue:identifier forKey:@"identifier"];
                
                if (treeEntry.type == OCTTreeEntryTypeBlob) {
                    OCTBlobTreeEntry *blobTreeEntry = (OCTBlobTreeEntry *)treeEntry;
                    
                    NSString *size = [NSString stringWithFormat:@"%luB", blobTreeEntry.size];
                    if (blobTreeEntry.size >= 1024 && blobTreeEntry.size < 1024 * 1024) {
                        size = [NSString stringWithFormat:@"%.2fKB", blobTreeEntry.size / 1024.0];
                    } else if (blobTreeEntry.size >= 1024 * 1024) {
                        size = [NSString stringWithFormat:@"%.2fM", blobTreeEntry.size / (1024 * 1024.0)];
                    }
					
                    [dictionary setValue:size forKey:@"size"];
                }
                
                return [dictionary copy];
            }].array;
            
         	self.dataSource = @[array];
     	}];
}

@end
