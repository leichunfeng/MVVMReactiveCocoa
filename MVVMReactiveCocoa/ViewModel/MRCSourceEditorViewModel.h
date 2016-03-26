//
//  MRCSourceEditorViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/2/3.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCViewModel.h"
#import "MRCWebViewModel.h"

typedef NS_ENUM(NSUInteger, MRCSourceEditorViewModelEntry) {
    MRCSourceEditorViewModelEntryGitTree,
    MRCSourceEditorViewModelEntryRepoDetail,
};

typedef NS_ENUM(NSUInteger, MRCSourceEditorViewModelContentType) {
    MRCSourceEditorViewModelContentTypeImage,
    MRCSourceEditorViewModelContentTypeSourceCode,
    MRCSourceEditorViewModelContentTypeMarkdown,
};

typedef NS_OPTIONS(NSUInteger, MRCSourceEditorViewModelOptions) {
    MRCSourceEditorViewModelOptionsScalesPageToFit = 1 << 0,
    MRCSourceEditorViewModelOptionsEnableWrapping  = 1 << 1,
    MRCSourceEditorViewModelOptionsShowRawMarkdown = 1 << 2,
};

@interface MRCSourceEditorViewModel : MRCWebViewModel

@property (nonatomic, assign, readonly) MRCSourceEditorViewModelEntry entry;
@property (nonatomic, assign, readonly) MRCSourceEditorViewModelContentType contentType;
@property (nonatomic, assign, readonly) MRCSourceEditorViewModelOptions options;

@property (nonatomic, strong, readonly) OCTRepository    *repository;
@property (nonatomic, strong, readonly) OCTBlobTreeEntry *blobEntry;

@property (nonatomic, copy, readonly) NSString *Base64String;
@property (nonatomic, copy, readonly) NSString *UTF8String;
@property (nonatomic, copy, readonly) NSString *HTMLString;

@property (nonatomic, assign) BOOL lineWrapping;
@property (nonatomic, assign) BOOL showRawMarkdown;

@property (nonatomic, strong, readonly) RACCommand *requestContentsCommand;
@property (nonatomic, strong, readonly) RACCommand *requestReadmeCommand;

@property (nonatomic, strong, readonly) OCTRef *reference;

@end
