//
//  MRCSourceEditorViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/2/3.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCSourceEditorViewModel.h"

@interface MRCSourceEditorViewModel ()

@property (nonatomic, assign, readwrite) MRCSourceEditorViewModelEntry entry;
@property (nonatomic, assign, readwrite) MRCSourceEditorViewModelContentType contentType;

@property (nonatomic, strong, readwrite) OCTRepository    *repository;
@property (nonatomic, strong, readwrite) OCTBlobTreeEntry *blobTreeEntry;

@property (nonatomic, copy, readwrite) NSString *Base64String;
@property (nonatomic, copy, readwrite) NSString *UTF8String;
@property (nonatomic, copy, readwrite) NSString *HTMLString;

@property (nonatomic, strong, readwrite) RACCommand *requestContentsCommand;
@property (nonatomic, strong, readwrite) RACCommand *requestReadmeCommand;

@property (nonatomic, strong, readwrite) OCTRef *reference;

@end

@implementation MRCSourceEditorViewModel

- (instancetype)initWithServices:(id<MRCViewModelServices>)services params:(NSDictionary *)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.entry         = [params[@"entry"] unsignedIntegerValue];
        self.repository    = params[@"repository"];
        self.reference     = params[@"reference"];
        self.blobTreeEntry = params[@"blobTreeEntry"];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.titleViewType = MRCTitleViewTypeDoubleTitle;
    self.title = self.title ?: [self.blobTreeEntry.path componentsSeparatedByString:@"/"].lastObject;
    self.subtitle = [self.reference.name componentsSeparatedByString:@"/"].lastObject;
    
    if (self.title.isImage) {
        self.contentType = MRCSourceEditorViewModelContentTypeImage;
    } else if (self.title.isMarkdown) {
        self.contentType = MRCSourceEditorViewModelContentTypeMarkdown;
    } else {
        self.contentType = MRCSourceEditorViewModelContentTypeSourceCode;
    }
    
    NSString *URLString = [NSBundle.mainBundle pathForResource:@"source-editor" ofType:@"html" inDirectory:@"assets.bundle"];
    self.request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    @weakify(self)
    self.requestContentsCommand = [[RACCommand alloc] initWithSignalBlock:^(NSNumber *input) {
        @strongify(self)
        
        OCTClientMediaType mediaType = input.unsignedIntegerValue;
        
        return [[[[[self.services client]
            fetchRelativePath:self.blobTreeEntry.path inRepository:self.repository reference:self.reference.name mediaType:mediaType]
            deliverOnMainThread]
            takeUntil:self.rac_willDeallocSignal]
            doNext:^(id x) {
                @strongify(self)
                
                if (mediaType == OCTClientMediaTypeJSON) {
                    self.Base64String = [(OCTFileContent *)x content];
                } else if (mediaType == OCTClientMediaTypeRaw) {
                    self.UTF8String = x;
                } else if (mediaType == OCTClientMediaTypeHTML) {
                    self.HTMLString = x;
                }
            }];
    }];
    
    self.requestReadmeCommand = [[RACCommand alloc] initWithSignalBlock:^(NSNumber *input) {
        @strongify(self)
        
        OCTClientMediaType mediaType = input.unsignedIntegerValue;
        
        return [[[[[self.services client]
            fetchRepositoryReadme:self.repository reference:self.reference.name mediaType:mediaType]
            deliverOnMainThread]
            takeUntil:self.rac_willDeallocSignal]
            doNext:^(id x) {
                @strongify(self)
                
                if (mediaType == OCTClientMediaTypeRaw) {
                    self.UTF8String = x;
                } else if (mediaType == OCTClientMediaTypeHTML) {
                    self.HTMLString = x;
                }
            }];
    }];

    // KVO
    [RACObserve(self, showRawMarkdown) subscribeNext:^(id x) {
        @strongify(self)
        [self willChangeValueForKey:@"options"];
        [self didChangeValueForKey:@"options"];
    }];

    [RACObserve(self, UTF8String) subscribeNext:^(id x) {
        @strongify(self)
        [self willChangeValueForKey:@"options"];
        [self didChangeValueForKey:@"options"];
    }];
    
    [RACObserve(self, HTMLString) subscribeNext:^(id x) {
        @strongify(self)
        [self willChangeValueForKey:@"options"];
        [self didChangeValueForKey:@"options"];
    }];
    
    [[RACSignal
     	merge:@[ self.requestContentsCommand.errors, self.requestReadmeCommand.errors ]]
     	subscribe:self.errors];
    
    // Initial request
    if (self.entry == MRCSourceEditorViewModelEntryGitTree) {
        if (self.contentType == MRCSourceEditorViewModelContentTypeImage) {
            [self.requestContentsCommand execute:@(OCTClientMediaTypeJSON)];
        } else if (self.contentType == MRCSourceEditorViewModelContentTypeSourceCode) {
            [self.requestContentsCommand execute:@(OCTClientMediaTypeRaw)];
        } else if (self.contentType == MRCSourceEditorViewModelContentTypeMarkdown) {
            [self.requestContentsCommand execute:@(OCTClientMediaTypeHTML)];
        }
    } else if (self.entry == MRCSourceEditorViewModelEntryRepoDetail) {
        [self.requestReadmeCommand execute:@(OCTClientMediaTypeHTML)];
    }
}

- (MRCSourceEditorViewModelOptions)options {
    MRCSourceEditorViewModelOptions options = 0;
    
    if (self.contentType == MRCSourceEditorViewModelContentTypeImage) {
        options |= MRCSourceEditorViewModelOptionsScalesPageToFit;
    }
    
    if ((self.contentType == MRCSourceEditorViewModelContentTypeSourceCode ||
        (self.contentType == MRCSourceEditorViewModelContentTypeMarkdown && self.showRawMarkdown)) &&
        self.UTF8String.length > 0 ) {
        options |= MRCSourceEditorViewModelOptionsEnableWrapping;
    }
    
    if (self.contentType == MRCSourceEditorViewModelContentTypeMarkdown &&
        ((self.showRawMarkdown && self.UTF8String.length > 0) ||
        (!self.showRawMarkdown && self.HTMLString.length > 0))) {
        options |= MRCSourceEditorViewModelOptionsShowRawMarkdown;
    }
    
    return options;
}

@end
