//
//  MRCSourceEditorViewModel.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/2/3.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCViewModel.h"

@interface MRCSourceEditorViewModel : MRCViewModel

@property (strong, nonatomic, readonly) OCTRepository    *repository;
@property (strong, nonatomic, readonly) OCTBlobTreeEntry *blobTreeEntry;

@property (strong, nonatomic) NSString *rawContent;
@property (strong, nonatomic) NSString *content;

@property (nonatomic, getter=isLineWrapping) BOOL lineWrapping;
@property (nonatomic, getter=isEncoded) 	 BOOL encoded;
@property (nonatomic, getter=isMarkdown) 	 BOOL markdown;

@property (strong, nonatomic) RACCommand *fetchBlobCommand;

@end
