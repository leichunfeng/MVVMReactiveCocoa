//
//  OCTEvent+MRCAttributedString.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/13.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <OctoKit/OctoKit.h>

typedef NS_OPTIONS(NSUInteger, OCTEventOptions) {
    OCTEventOptionsBoldTitle = 1 << 0
};

@interface OCTEvent (MRCAttributedString)

@property (assign, nonatomic, readonly) OCTEventOptions options;

- (NSAttributedString *)mrc_attributedString;

- (NSAttributedString *)mrc_commitCommentEventAttributedString;
- (NSAttributedString *)mrc_forkEventAttributedString;
- (NSAttributedString *)mrc_issueCommentEventAttributedString;
- (NSAttributedString *)mrc_issueEventAttributedString;
- (NSAttributedString *)mrc_memberEventAttributedString;
- (NSAttributedString *)mrc_publicEventAttributedString;
- (NSAttributedString *)mrc_pullRequestCommentEventAttributedString;
- (NSAttributedString *)mrc_pullRequestEventAttributedString;
- (NSAttributedString *)mrc_pushEventAttributedString;
- (NSAttributedString *)mrc_refEventAttributedString;
- (NSAttributedString *)mrc_watchEventAttributedString;

- (NSMutableAttributedString *)mrc_actorLoginAttributedString;
- (NSMutableAttributedString *)mrc_commentedCommitAttributedString;
- (NSMutableAttributedString *)mrc_forkedRepositoryNameAttributedString;
- (NSMutableAttributedString *)mrc_repositoryNameAttributedString;
- (NSMutableAttributedString *)mrc_issueAttributedString;
- (NSMutableAttributedString *)mrc_memberLoginAttributedString;
- (NSMutableAttributedString *)mrc_pullRequestAttributedString;
- (NSMutableAttributedString *)mrc_branchNameAttributedString;
- (NSMutableAttributedString *)mrc_pushedCommitAttributedStringWithSHA:(NSString *)SHA;
- (NSMutableAttributedString *)mrc_refNameAttributedString;
- (NSMutableAttributedString *)mrc_dateAttributedString;

@end
