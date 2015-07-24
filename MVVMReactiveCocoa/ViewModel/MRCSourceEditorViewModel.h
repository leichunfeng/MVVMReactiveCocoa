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

@property (assign, nonatomic) MRCSourceEditorViewModelType type;

@property (strong, nonatomic, readonly) OCTRepository    *repository;
@property (strong, nonatomic, readonly) OCTBlobTreeEntry *blobTreeEntry;

@property (copy, nonatomic) NSString *rawContent;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *readmeHTML;

@property (nonatomic, getter=isLineWrapping) BOOL lineWrapping;
@property (nonatomic, getter=isEncoded)		 BOOL encoded;
@property (nonatomic, getter=isMarkdown)	 BOOL markdown;

@property (assign, nonatomic) BOOL showRawMarkdown;

@property (strong, nonatomic) RACCommand *requestBlobCommand;
@property (strong, nonatomic) RACCommand *requestReadmeHTMLCommand;
@property (strong, nonatomic) RACCommand *requestReadmeMarkdownCommand;

@property (copy, nonatomic) NSString *wrappingActionTitle;
@property (copy, nonatomic) NSString *markdownActionTitle;

@end
