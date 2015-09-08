//
//  MRCSourceEditorViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/2/3.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCViewModel.h"
#import "MRCWebViewModel.h"

typedef NS_ENUM(NSUInteger, MRCSourceEditorViewModelType) {
    MRCSourceEditorViewModelTypeBlob,
    MRCSourceEditorViewModelTypeReadme
};

@interface MRCSourceEditorViewModel : MRCWebViewModel

@property (nonatomic, assign, readonly) MRCSourceEditorViewModelType type;

@property (nonatomic, strong, readonly) OCTRepository    *repository;
@property (nonatomic, strong, readonly) OCTBlobTreeEntry *blobTreeEntry;

@property (nonatomic, copy, readonly) NSString *rawContent;
@property (nonatomic, copy, readonly) NSString *content;
@property (nonatomic, copy, readonly) NSString *readmeHTML;

@property (nonatomic, assign, getter = isLineWrapping)       BOOL lineWrapping;
@property (nonatomic, assign, getter = isEncoded, readonly)	 BOOL encoded;
@property (nonatomic, assign, getter = isMarkdown, readonly) BOOL markdown;

@property (nonatomic, assign) BOOL showRawMarkdown;

@property (nonatomic, strong, readonly) RACCommand *requestBlobCommand;
@property (nonatomic, strong, readonly) RACCommand *requestReadmeHTMLCommand;
@property (nonatomic, strong, readonly) RACCommand *requestReadmeMarkdownCommand;

@property (nonatomic, copy, readonly) NSString *wrappingActionTitle;
@property (nonatomic, copy, readonly) NSString *markdownActionTitle;

@end
