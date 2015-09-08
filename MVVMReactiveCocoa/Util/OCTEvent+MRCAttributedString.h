//
//  OCTEvent+MRCAttributedString.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/13.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <OctoKit/OctoKit.h>

typedef NS_OPTIONS(NSUInteger, MRCEventOptions) {
    MRCEventOptionsBoldTitle = 1 << 0
};

@interface OCTEvent (MRCAttributedString)

@property (nonatomic, assign, readonly) MRCEventOptions options;

- (NSMutableAttributedString *)mrc_attributedString;

- (NSMutableAttributedString *)mrc_commitCommentEventAttributedString;
- (NSMutableAttributedString *)mrc_forkEventAttributedString;
- (NSMutableAttributedString *)mrc_issueCommentEventAttributedString;
- (NSMutableAttributedString *)mrc_issueEventAttributedString;
- (NSMutableAttributedString *)mrc_memberEventAttributedString;
- (NSMutableAttributedString *)mrc_publicEventAttributedString;
- (NSMutableAttributedString *)mrc_pullRequestCommentEventAttributedString;
- (NSMutableAttributedString *)mrc_pullRequestEventAttributedString;
- (NSMutableAttributedString *)mrc_pushEventAttributedString;
- (NSMutableAttributedString *)mrc_refEventAttributedString;
- (NSMutableAttributedString *)mrc_watchEventAttributedString;

- (NSMutableAttributedString *)mrc_octiconAttributedString;
- (NSMutableAttributedString *)mrc_actorLoginAttributedString;
- (NSMutableAttributedString *)mrc_commentedCommitAttributedString;
- (NSMutableAttributedString *)mrc_forkedRepositoryNameAttributedString;
- (NSMutableAttributedString *)mrc_repositoryNameAttributedString;
- (NSMutableAttributedString *)mrc_issueAttributedString;
- (NSMutableAttributedString *)mrc_memberLoginAttributedString;
- (NSMutableAttributedString *)mrc_pullRequestAttributedString;
- (NSMutableAttributedString *)mrc_branchNameAttributedString;
- (NSMutableAttributedString *)mrc_pushedCommitAttributedStringWithSHA:(NSString *)SHA;
- (NSMutableAttributedString *)mrc_pushedCommitsAttributedString;
- (NSMutableAttributedString *)mrc_refNameAttributedString;
- (NSMutableAttributedString *)mrc_dateAttributedString;
- (NSMutableAttributedString *)mrc_pullInfoAttributedString;

@end
