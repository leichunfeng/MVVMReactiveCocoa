//
//  MRCSourceEditorViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/2/3.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCViewModel.h"

typedef NS_ENUM(NSUInteger, MRCSourceEditorViewModelType) {
    MRCSourceEditorViewModelTypeBlob,
    MRCSourceEditorViewModelTypeReadme
};

@interface MRCSourceEditorViewModel : MRCViewModel

@property (nonatomic) MRCSourceEditorViewModelType type;

@property (strong, nonatomic, readonly) OCTRepository    *repository;
@property (strong, nonatomic, readonly) OCTBlobTreeEntry *blobTreeEntry;

@property (strong, nonatomic) NSString *rawContent;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *readmeHTMLString;

@property (nonatomic, getter=isLineWrapping) BOOL lineWrapping;
@property (nonatomic, getter=isEncoded)		 BOOL encoded;
@property (nonatomic, getter=isMarkdown)	 BOOL markdown;

@property (nonatomic) BOOL showRawMarkdown;

@property (strong, nonatomic) RACCommand *requestBlobCommand;
@property (strong, nonatomic) RACCommand *requestRenderedMarkdownCommand;
@property (strong, nonatomic) RACCommand *requestReadmeCommand;

@property (strong, nonatomic) NSString *wrappingActionTitle;
@property (strong, nonatomic) NSString *markdownActionTitle;

@end
