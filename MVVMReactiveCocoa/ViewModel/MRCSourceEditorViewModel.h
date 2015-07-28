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

@property (assign, nonatomic, readonly) MRCSourceEditorViewModelType type;

@property (strong, nonatomic, readonly) OCTRepository    *repository;
@property (strong, nonatomic, readonly) OCTBlobTreeEntry *blobTreeEntry;

@property (copy, nonatomic, readonly) NSString *rawContent;
@property (copy, nonatomic, readonly) NSString *content;
@property (copy, nonatomic, readonly) NSString *readmeHTML;

@property (assign, nonatomic, getter = isLineWrapping)       BOOL lineWrapping;
@property (assign, nonatomic, getter = isEncoded, readonly)	 BOOL encoded;
@property (assign, nonatomic, getter = isMarkdown, readonly) BOOL markdown;

@property (assign, nonatomic) BOOL showRawMarkdown;

@property (strong, nonatomic, readonly) RACCommand *requestBlobCommand;
@property (strong, nonatomic, readonly) RACCommand *requestReadmeHTMLCommand;
@property (strong, nonatomic, readonly) RACCommand *requestReadmeMarkdownCommand;

@property (copy, nonatomic, readonly) NSString *wrappingActionTitle;
@property (copy, nonatomic, readonly) NSString *markdownActionTitle;

@end
