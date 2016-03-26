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

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(NSDictionary *)params {
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
    self.title         = self.repository.name;
    self.subtitle      = self.repository.ownerLogin;

    if (self.path.length == 0) {
        self.shouldPullToRefresh = YES;

        NSString *path = [NSString stringWithFormat:@"repos/%@/%@/git/trees/%@", self.repository.ownerLogin, self.repository.name, [self.reference.name componentsSeparatedByString:@"/"].lastObject];

        NSMutableURLRequest *request = [[self.services client] requestWithMethod:@"GET" path:path parameters:@{ @"recursive": @1 }];

        NSCachedURLResponse *URLResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
        if (URLResponse.data != nil) {
            self.tree = [MTLJSONAdapter modelOfClass:[OCTTree class]
                                  fromJSONDictionary:[NSJSONSerialization JSONObjectWithData:URLResponse.data options:0 error:nil]
                                               error:nil];
        }
    }
    
    RAC(self, tree) = self.requestRemoteDataCommand.executionSignals.switchToLatest;

    @weakify(self)
    RAC(self, dataSource) = [[RACObserve(self, tree)
        ignore:nil]
        map:^(OCTTree *tree) {
            NSArray *array = [[tree.entries.rac_sequence
                filter:^(OCTTreeEntry *treeEntry) {
                    return @(treeEntry.type != OCTTreeEntryTypeCommit).boolValue;
                }]
                filter:^(OCTTreeEntry *treeEntry) {
                    @strongify(self)

                    if (self.path.length == 0) {
                        return @([treeEntry.path componentsSeparatedByString:@"/"].count == 1).boolValue;
                    } else {
                        return @([treeEntry.path hasPrefix:[self.path stringByAppendingString:@"/"]] &&
                                 [treeEntry.path componentsSeparatedByString:@"/"].count == [self.path componentsSeparatedByString:@"/"].count + 1).boolValue;
                    }
                }].array;

            array = [array sortedArrayUsingComparator:^(OCTTreeEntry *treeEntry1, OCTTreeEntry *treeEntry2) {
                if (treeEntry1.type == treeEntry2.type) {
                    return [treeEntry1.path caseInsensitiveCompare:treeEntry2.path];
                } else {
                    return treeEntry1.type == OCTTreeEntryTypeTree ? NSOrderedAscending : NSOrderedDescending;
                }
            }];

            array = [array.rac_sequence map:^(OCTTreeEntry *treeEntry) {
                NSMutableDictionary *output = @{
                    @"treeEntry": treeEntry ?: [NSNull null],
                    @"identifier": treeEntry.type == OCTTreeEntryTypeTree ? @"FileDirectory" : @"FileText",
                    @"hexRGB": treeEntry.type == OCTTreeEntryTypeTree ? @(0x80a6cd) : @(0x777777),
                    @"text": [treeEntry.path componentsSeparatedByString:@"/"].lastObject ?: @"",
                }.mutableCopy;

                if (treeEntry.type == OCTTreeEntryTypeBlob) {
                    OCTBlobTreeEntry *blobEntry = (OCTBlobTreeEntry *)treeEntry;

                    NSString *size = nil;
                    if (blobEntry.size >= 1024 * 1024 * 1024) {
                        size = [NSString stringWithFormat:@"%.2f G", blobEntry.size / (1024.0 * 1024 * 1024)];
                    } else if (blobEntry.size >= 1024 * 1024) {
                        size = [NSString stringWithFormat:@"%.2f M", blobEntry.size / (1024.0 * 1024)];
                    } else if (blobEntry.size >= 1024) {
                        size = [NSString stringWithFormat:@"%.2f KB", blobEntry.size / 1024.0];
                    } else {
                        size = [NSString stringWithFormat:@"%@ B", @(blobEntry.size)];
                    }

                    [output setValue:size forKey:@"detailText"];
                } else {
                    NSArray *entries = [[tree.entries.rac_sequence
                        filter:^(OCTTreeEntry *treeEntry) {
                            return @(treeEntry.type != OCTTreeEntryTypeCommit).boolValue;
                        }]
                        filter:^(OCTTreeEntry *treeEntry2) {
                            return @([treeEntry2.path hasPrefix:[treeEntry.path stringByAppendingString:@"/"]] &&
                                     [treeEntry2.path componentsSeparatedByString:@"/"].count == [treeEntry.path componentsSeparatedByString:@"/"].count + 1).boolValue;
                        }].array;

                    [output setValue:@(entries.count).stringValue forKey:@"detailText"];
                }

                return output.copy;
            }].array;

            if (array.count == 0) return (NSArray *)nil;

            return @[ array ];
        }];

    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^(NSIndexPath *indexPath) {
        @strongify(self)
        OCTTreeEntry *treeEntry = self.dataSource[indexPath.section][indexPath.row][@"treeEntry"];

        if (treeEntry.type == OCTTreeEntryTypeTree) {
            MRCGitTreeViewModel *gitTreeViewModel = [[MRCGitTreeViewModel alloc] initWithServices:self.services
                                                                                           params:@{ @"path": treeEntry.path ?: @"",
                                                                                                     @"tree": self.tree ?: [NSNull null],
                                                                                                     @"repository": self.repository ?: [NSNull null],
                                                                                                     @"reference": self.reference ?: [NSNull null], }];
            [self.services pushViewModel:gitTreeViewModel animated:YES];
        } else if (treeEntry.type == OCTTreeEntryTypeBlob) {
            MRCSourceEditorViewModel *sourceEditorViewModel = [[MRCSourceEditorViewModel alloc] initWithServices:self.services
                                                                                                          params:@{ @"repository": self.repository ?: [NSNull null],
                                                                                                                    @"reference": self.reference ?: [NSNull null],
                                                                                                                    @"blobEntry": treeEntry ?: [NSNull null], }];
            [self.services pushViewModel:sourceEditorViewModel animated:YES];
        }

        return [RACSignal empty];
    }];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    if (self.path.length == 0) {
        return [[self.services client] fetchTreeForReference:[self.reference.name componentsSeparatedByString:@"/"].lastObject
                                                inRepository:self.repository
                                                   recursive:YES];
    }
    return [RACSignal empty];
}

@end
