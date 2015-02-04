//
//  MRCSourceEditorViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/2/3.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCSourceEditorViewModel.h"

@interface MRCSourceEditorViewModel ()

@property (strong, nonatomic, readwrite) OCTRepository    *repository;
@property (strong, nonatomic, readwrite) OCTBlobTreeEntry *blobTreeEntry;

@end

@implementation MRCSourceEditorViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.repository    = params[@"repository"];
        self.blobTreeEntry = params[@"blobTreeEntry"];
        self.encoded = YES;
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.title = [self.blobTreeEntry.path componentsSeparatedByString:@"/"].lastObject;
    self.markdown = [self.title isMarkdown];
    
    self.fetchBlobCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @weakify(self)
        return [[self.services.client
        	fetchBlob:self.blobTreeEntry.SHA inRepository:self.repository]
            doNext:^(NSData *data) {
                @strongify(self)
                self.rawContent = [data base64EncodedString] ?: @"";
                self.content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ?: @"";
            }];
    }];
}

@end
