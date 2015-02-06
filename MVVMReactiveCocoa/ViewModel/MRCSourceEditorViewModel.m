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
@property (strong, nonatomic) OCTRef *reference;

@end

@implementation MRCSourceEditorViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.repository    = params[@"repository"];
        self.reference     = params[@"reference"];
        self.blobTreeEntry = params[@"blobTreeEntry"];
        self.encoded = YES;
        self.lineWrapping = YES;
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.title = [self.blobTreeEntry.path componentsSeparatedByString:@"/"].lastObject;
    self.markdown = self.title.isMarkdown;
    
    @weakify(self)
    self.fetchBlobCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        if (self.isMarkdown) {
            return [[self.services.repositoryService
                requestRepositoryReadmeRenderedHTML:self.repository reference:self.reference.name]
            	doNext:^(NSString *renderedHTML) {
                    @strongify(self)
                    self.content = renderedHTML;
                }];
        } else {
            return [[self.services.client
                fetchBlob:self.blobTreeEntry.SHA inRepository:self.repository]
                doNext:^(NSData *data) {
                    @strongify(self)
                    self.rawContent = [data base64EncodedString];
                    self.content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                }];
        }
    }];
}

@end
