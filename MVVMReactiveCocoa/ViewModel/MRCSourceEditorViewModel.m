//
//  MRCSourceEditorViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/2/3.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCSourceEditorViewModel.h"

@interface MRCSourceEditorViewModel ()

@property (strong, nonatomic, readwrite) OCTRepository *repository;
@property (strong, nonatomic, readwrite) OCTBlobTreeEntry *blobTreeEntry;
@property (strong, nonatomic) OCTRef *reference;

@end

@implementation MRCSourceEditorViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.type  = [params[@"type"] unsignedIntegerValue];
        self.repository = params[@"repository"];
        self.reference  = params[@"reference"];
        self.blobTreeEntry    = params[@"blobTreeEntry"];
        self.readmeHTMLString = params[@"readmeHTMLString"];
        self.encoded = YES;
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.titleViewType = MRCTitleViewTypeDoubleTitle;
    self.title = self.title ?: [self.blobTreeEntry.path componentsSeparatedByString:@"/"].lastObject;
    self.subtitle = [self.reference.name componentsSeparatedByString:@"/"].lastObject;
    
    self.markdown = self.title.isMarkdown;
    
    NSString *path = [NSBundle.mainBundle pathForResource:@"source-editor" ofType:@"html" inDirectory:@"assets.bundle"];
    self.request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    
    @weakify(self)
    self.requestBlobCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [[[self.services.client
        	fetchBlob:self.blobTreeEntry.SHA inRepository:self.repository]
        	doNext:^(NSData *data) {
            	@strongify(self)
            	self.rawContent = data.base64EncodedString;
            }]
        	takeUntil:self.willDisappearSignal];
    }];
    
    self.requestReadmeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [[[self.services.client
            fetchRepositoryReadme:self.repository reference:self.reference.name]
            doNext:^(OCTFileContent *fileContent) {
                @strongify(self)
                self.rawContent = fileContent.content;
            }]
            takeUntil:self.willDisappearSignal];
    }];
    
    self.requestRenderedMarkdownCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [[[self.services.repositoryService
        	requestRepositoryReadmeHTMLString:self.repository reference:self.reference.name]
            doNext:^(NSString *readmeHTMLString) {
                @strongify(self)
                self.readmeHTMLString = readmeHTMLString;
            }]
            takeUntil:self.willDisappearSignal];
    }];
    
    [[RACSignal
     	merge:@[ self.requestReadmeCommand.errors, self.requestBlobCommand.errors, self.requestRenderedMarkdownCommand.errors ]]
     	subscribe:self.errors];
}

- (NSString *)content {
    if (self.isMarkdown && !self.showRawMarkdown) {
        return self.readmeHTMLString;
    } else {
        return [[NSString alloc] initWithData:[NSData dataFromBase64String:self.rawContent] encoding:NSUTF8StringEncoding];
    }
}

- (NSString *)wrappingActionTitle {
    return self.isLineWrapping ? @"Disable wrapping": @"Enable wrapping";
}

- (NSString *)markdownActionTitle {
    return self.showRawMarkdown ? @"Render markdown": @"Show raw markdown";
}

@end
