//
//  MRCGitTreeViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/29.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCGitTreeViewModel.h"
#import "MRCSourceEditorViewModel.h"

@interface MRCGitTreeViewModel ()

@property (nonatomic, strong) OCTRepository *repository;
@property (nonatomic, strong) OCTRef *reference;

@property (nonatomic, strong, readwrite) OCTTree *tree;
@property (nonatomic, copy, readwrite) NSString *path;

@end

@implementation MRCGitTreeViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.path = params[@"path"];
        self.tree = params[@"tree"];
        self.repository = params[@"repository"];
        self.reference  = params[@"reference"];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.titleViewType = MRCTitleViewTypeDoubleTitle;
    self.title = self.repository.name;
    self.subtitle = self.repository.ownerLogin;
    
    if (!self.path) self.shouldPullToRefresh = YES;
    
    @weakify(self)
    [RACObserve(self, tree) subscribeNext:^(OCTTree *tree) {
        @strongify(self)
        if (!tree) return;
        
        self.dataSource = @[[[[[self.tree.entries.rac_sequence
            filter:^BOOL(OCTTreeEntry *treeEntry) {
                return treeEntry.type != OCTTreeEntryTypeCommit;
            }]
            filter:^BOOL(OCTTreeEntry *treeEntry) {
                @strongify(self)
                if (self.path) {
                    BOOL hasPrefix = [treeEntry.path hasPrefix:[self.path stringByAppendingString:@"/"]];
                    BOOL isSubPath = ([treeEntry.path componentsSeparatedByString:@"/"].count == [self.path componentsSeparatedByString:@"/"].count + 1);
                    return hasPrefix && isSubPath;
                } else {
                    return [treeEntry.path componentsSeparatedByString:@"/"].count == 1;
                }
            }].array sortedArrayUsingComparator:^NSComparisonResult(OCTTreeEntry *treeEntry1, OCTTreeEntry *treeEntry2) {
                if (treeEntry1.type == treeEntry2.type) {
                    return [treeEntry1.path caseInsensitiveCompare:treeEntry2.path];
                } else {
                    return treeEntry1.type == OCTTreeEntryTypeTree ? NSOrderedAscending : NSOrderedDescending;
                }
            }].rac_sequence
        	map:^(OCTTreeEntry *treeEntry) {
                @strongify(self)
                OCTTreeEntry *tempTreeEntry = treeEntry;
                
                NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
                
                NSString *identifier = (treeEntry.type == OCTTreeEntryTypeTree ? @"FileDirectory" : @"FileText");
                NSNumber *hexRGB = (treeEntry.type == OCTTreeEntryTypeTree ? @(0x80a6cd) : @(0x777777));
                
                [dictionary setValue:treeEntry forKey:@"treeEntry"];
                [dictionary setValue:[treeEntry.path componentsSeparatedByString:@"/"].lastObject forKey:@"text"];
                [dictionary setValue:identifier forKey:@"identifier"];
                [dictionary setValue:hexRGB forKey:@"hexRGB"];
                
                if (treeEntry.type == OCTTreeEntryTypeBlob) {
                    OCTBlobTreeEntry *blobTreeEntry = (OCTBlobTreeEntry *)treeEntry;
                    
                    NSString *size = [NSString stringWithFormat:@"%lu B", (unsigned long)blobTreeEntry.size];
                    if (blobTreeEntry.size >= 1024 * 1024 * 1024) {
                        size = [NSString stringWithFormat:@"%.2f G", blobTreeEntry.size / (1024 * 1024 * 1024.0)];
                    } else if (blobTreeEntry.size >= 1024 * 1024) {
                        size = [NSString stringWithFormat:@"%.2f M", blobTreeEntry.size / (1024 * 1024.0)];
                    } else if (blobTreeEntry.size >= 1024) {
                        size = [NSString stringWithFormat:@"%.2f KB", blobTreeEntry.size / 1024.0];
                    }
                    
                    [dictionary setValue:size forKey:@"detailText"];
                } else {
                    NSUInteger subPaths = [[self.tree.entries.rac_sequence
                        filter:^BOOL(OCTTreeEntry *treeEntry) {
                            return treeEntry.type != OCTTreeEntryTypeCommit;
                        }]
                    	filter:^BOOL(OCTTreeEntry *treeEntry) {
                            BOOL hasPrefix = [treeEntry.path hasPrefix:[tempTreeEntry.path stringByAppendingString:@"/"]];
                            BOOL isSubPath = ([treeEntry.path componentsSeparatedByString:@"/"].count == [tempTreeEntry.path componentsSeparatedByString:@"/"].count + 1);
                            return hasPrefix && isSubPath;
                        }].array.count;
                    
                    [dictionary setValue:@(subPaths).stringValue forKey:@"detailText"];
                }
                
                return dictionary.copy;
            }].array];
    }];
    
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self)
        OCTTreeEntry *treeEntry = self.dataSource[indexPath.section][indexPath.row][@"treeEntry"];
        
        if (treeEntry.type == OCTTreeEntryTypeTree) {
            MRCGitTreeViewModel *gitTreeViewModel = [[MRCGitTreeViewModel alloc] initWithServices:self.services
                                                                                           params:@{@"path": treeEntry.path,
                                                                                                    @"tree": self.tree,
                                                                                                    @"repository": self.repository,
                                                                                                    @"reference": self.reference}];
            [self.services pushViewModel:gitTreeViewModel animated:YES];
        } else if (treeEntry.type == OCTTreeEntryTypeBlob) {
            MRCSourceEditorViewModel *sourceEditorViewModel = [[MRCSourceEditorViewModel alloc] initWithServices:self.services
                                                                                                          params:@{@"repository": self.repository,
                                                                                                                   @"reference": self.reference,
                                                                                                                   @"blobTreeEntry": treeEntry}];
            [self.services pushViewModel:sourceEditorViewModel animated:YES];
        }

        return [RACSignal empty];
    }];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    if (self.path) return [RACSignal empty];
    
    NSString *reference = [self.reference.name componentsSeparatedByString:@"/"].lastObject;
    
    @weakify(self)
    return [[self.services.client
    	fetchTreeForReference:reference inRepository:self.repository recursive:YES]
        doNext:^(OCTTree *tree) {
            @strongify(self)
            self.tree = tree;
        }];
}

@end
