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
@property (nonatomic, strong, readwrite) OCTBlobTreeEntry *blobEntry;

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
        self.entry      = [params[@"entry"] unsignedIntegerValue];
        self.repository = params[@"repository"];
        self.reference  = params[@"reference"];
        self.blobEntry  = params[@"blobEntry"];
    }
    return self;
}

- (void)initialize {
    [super initialize];
    
    self.titleViewType = MRCTitleViewTypeDoubleTitle;
    self.title = self.title ?: [self.blobEntry.path componentsSeparatedByString:@"/"].lastObject;
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
            fetchRelativePath:self.blobEntry.path inRepository:self.repository reference:self.reference.name mediaType:mediaType]
            deliverOnMainThread]
            takeUntil:self.rac_willDeallocSignal]
            doNext:^(id x) {
                @strongify(self)
                
                if (mediaType == OCTClientMediaTypeJSON) {
                    self.Base64String = [(OCTFileContent *)x content];
                    
                    [[YYCache sharedCache] setObject:[(OCTFileContent *)x content]
                                              forKey:[self cacheKeyForContentsOfMediaType:mediaType]
                                           withBlock:NULL];
                } else if (mediaType == OCTClientMediaTypeRaw) {
                    self.UTF8String = x;
                    
                    [[YYCache sharedCache] setObject:x
                                              forKey:[self cacheKeyForContentsOfMediaType:mediaType]
                                           withBlock:NULL];
                } else if (mediaType == OCTClientMediaTypeHTML) {
                    self.HTMLString = x;
                    
                    [[YYCache sharedCache] setObject:x
                                              forKey:[self cacheKeyForContentsOfMediaType:mediaType]
                                           withBlock:NULL];
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
                    
                    [[YYCache sharedCache] setObject:x
                                              forKey:[self cacheKeyForReadmeOfMediaType:mediaType]
                                           withBlock:NULL];
                } else if (mediaType == OCTClientMediaTypeHTML) {
                    self.HTMLString = x;
                    
                    [[YYCache sharedCache] setObject:x
                                              forKey:[self cacheKeyForReadmeOfMediaType:mediaType]
                                           withBlock:NULL];
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
            self.Base64String = (NSString *)[[YYCache sharedCache] objectForKey:[self cacheKeyForContentsOfMediaType:OCTClientMediaTypeJSON]];

            [self.requestContentsCommand execute:@(OCTClientMediaTypeJSON)];
        } else if (self.contentType == MRCSourceEditorViewModelContentTypeSourceCode) {
            self.UTF8String = (NSString *)[[YYCache sharedCache] objectForKey:[self cacheKeyForContentsOfMediaType:OCTClientMediaTypeRaw]];
            
            [self.requestContentsCommand execute:@(OCTClientMediaTypeRaw)];
        } else if (self.contentType == MRCSourceEditorViewModelContentTypeMarkdown) {
            self.HTMLString = (NSString *)[[YYCache sharedCache] objectForKey:[self cacheKeyForContentsOfMediaType:OCTClientMediaTypeHTML]];
            self.UTF8String = (NSString *)[[YYCache sharedCache] objectForKey:[self cacheKeyForContentsOfMediaType:OCTClientMediaTypeRaw]];
            
            [self.requestContentsCommand execute:@(OCTClientMediaTypeHTML)];
        }
    } else if (self.entry == MRCSourceEditorViewModelEntryRepoDetail) {
        self.HTMLString = (NSString *)[[YYCache sharedCache] objectForKey:[self cacheKeyForReadmeOfMediaType:OCTClientMediaTypeHTML]];
        self.UTF8String = (NSString *)[[YYCache sharedCache] objectForKey:[self cacheKeyForReadmeOfMediaType:OCTClientMediaTypeRaw]];
        
        [self.requestReadmeCommand execute:@(OCTClientMediaTypeHTML)];
    }
}

- (NSString *)cacheKeyForContentsOfMediaType:(OCTClientMediaType)mediaType {
    return [NSString stringWithFormat:@"repos/%@/%@/contents/%@?ref=%@&accept=%@", self.repository.ownerLogin, self.repository.name, self.blobEntry.path, self.reference.name, @(mediaType)];
}

- (NSString *)cacheKeyForReadmeOfMediaType:(OCTClientMediaType)mediaType {
    return [NSString stringWithFormat:@"repos/%@/%@/readme?ref=%@&accept=%@", self.repository.ownerLogin, self.repository.name, self.reference.name, @(mediaType)];
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
