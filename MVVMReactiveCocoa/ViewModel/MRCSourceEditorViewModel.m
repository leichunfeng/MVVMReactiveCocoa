//
//  MRCSourceEditorViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/2/3.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCSourceEditorViewModel.h"

@interface MRCSourceEditorViewModel ()

@property (assign, nonatomic, readwrite) MRCSourceEditorViewModelType type;

@property (strong, nonatomic, readwrite) OCTRepository    *repository;
@property (strong, nonatomic, readwrite) OCTBlobTreeEntry *blobTreeEntry;

@property (copy, nonatomic, readwrite) NSString *rawContent;
@property (copy, nonatomic, readwrite) NSString *content;
@property (copy, nonatomic, readwrite) NSString *readmeHTML;

@property (assign, nonatomic, getter = isEncoded, readwrite)  BOOL encoded;
@property (assign, nonatomic, getter = isMarkdown, readwrite) BOOL markdown;

@property (strong, nonatomic, readwrite) RACCommand *requestBlobCommand;
@property (strong, nonatomic, readwrite) RACCommand *requestReadmeHTMLCommand;
@property (strong, nonatomic, readwrite) RACCommand *requestReadmeMarkdownCommand;

@property (copy, nonatomic, readwrite) NSString *wrappingActionTitle;
@property (copy, nonatomic, readwrite) NSString *markdownActionTitle;

@property (strong, nonatomic) OCTRef *reference;

@end

@implementation MRCSourceEditorViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(id)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.type = [params[@"type"] unsignedIntegerValue];
        self.repository = params[@"repository"];
        self.reference  = params[@"reference"];
        self.blobTreeEntry = params[@"blobTreeEntry"];
        self.readmeHTML = params[@"readmeHTML"];
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
        	takeUntil:self.rac_willDeallocSignal];
    }];
    
    self.requestReadmeMarkdownCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [[[self.services.client
            fetchRepositoryReadme:self.repository reference:self.reference.name]
            doNext:^(OCTFileContent *fileContent) {
                @strongify(self)
                self.rawContent = fileContent.content;
            }]
            takeUntil:self.rac_willDeallocSignal];
    }];
    
    self.requestReadmeHTMLCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [[[self.services.repositoryService
        	requestRepositoryReadmeHTML:self.repository reference:self.reference.name]
            doNext:^(NSString *readmeHTML) {
                @strongify(self)
                self.readmeHTML = readmeHTML;
            }]
            takeUntil:self.rac_willDeallocSignal];
    }];
    
    [[RACSignal
     	merge:@[ self.requestReadmeMarkdownCommand.errors, self.requestBlobCommand.errors, self.requestReadmeHTMLCommand.errors ]]
     	subscribe:self.errors];
}

- (NSString *)content {
    if (self.isMarkdown && !self.showRawMarkdown) {
        return self.readmeHTML;
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
