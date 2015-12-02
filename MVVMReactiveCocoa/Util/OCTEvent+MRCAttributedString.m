//
//  OCTEvent+MRCAttributedString.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/13.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "OCTEvent+MRCAttributedString.h"
#import "TTTTimeIntervalFormatter.h"

@implementation OCTEvent (MRCAttributedString)

- (MRCEventOptions)options {
    MRCEventOptions options = 0;
    
    if ([self isMemberOfClass:[OCTCommitCommentEvent class]] ||
        [self isMemberOfClass:[OCTIssueCommentEvent class]] ||
        [self isMemberOfClass:[OCTIssueEvent class]] ||
        [self isMemberOfClass:[OCTPullRequestCommentEvent class]] ||
        [self isMemberOfClass:[OCTPullRequestEvent class]] ||
        [self isMemberOfClass:[OCTPushEvent class]]) {
        options |= MRCEventOptionsBoldTitle;
    }
    
    return options;
}

- (NSMutableAttributedString *)mrc_attributedString {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [attributedString appendAttributedString:self.mrc_octiconAttributedString];
    [attributedString appendAttributedString:self.mrc_actorLoginAttributedString];
    
    if ([self isMemberOfClass:[OCTCommitCommentEvent class]] ||
        [self isMemberOfClass:[OCTIssueCommentEvent class]] ||
        [self isMemberOfClass:[OCTPullRequestCommentEvent class]]) {
        if ([self isMemberOfClass:[OCTCommitCommentEvent class]]) {
            [attributedString appendAttributedString:[self mrc_commitCommentEventAttributedString]];
        } else if ([self isMemberOfClass:[OCTIssueCommentEvent class]]) {
            [attributedString appendAttributedString:[self mrc_issueCommentEventAttributedString]];
        } else if ([self isMemberOfClass:[OCTPullRequestCommentEvent class]]) {
            [attributedString appendAttributedString:[self mrc_pullRequestCommentEventAttributedString]];
        }
        
        [attributedString appendAttributedString:[@"\n" stringByAppendingString:[self valueForKeyPath:@"comment.body"]].mrc_attributedString.mrc_addNormalTitleAttributes.mrc_addParagraphStyleAttribute];
    } else if ([self isMemberOfClass:[OCTForkEvent class]]) {
        [attributedString appendAttributedString:[self mrc_forkEventAttributedString]];
    } else if ([self isMemberOfClass:[OCTIssueEvent class]]) {
        [attributedString appendAttributedString:[self mrc_issueEventAttributedString]];
    } else if ([self isMemberOfClass:[OCTMemberEvent class]]) {
        [attributedString appendAttributedString:[self mrc_memberEventAttributedString]];
    } else if ([self isMemberOfClass:[OCTPublicEvent class]]) {
        [attributedString appendAttributedString:[self mrc_publicEventAttributedString]];
    } else if ([self isMemberOfClass:[OCTPullRequestEvent class]]) {
        [attributedString appendAttributedString:[self mrc_pullRequestEventAttributedString]];
    } else if ([self isMemberOfClass:[OCTPushEvent class]]) {
        [attributedString appendAttributedString:[self mrc_pushEventAttributedString]];
    } else if ([self isMemberOfClass:[OCTRefEvent class]]) {
        [attributedString appendAttributedString:[self mrc_refEventAttributedString]];
    } else if ([self isMemberOfClass:[OCTWatchEvent class]]) {
        [attributedString appendAttributedString:[self mrc_watchEventAttributedString]];
    }
    
    [attributedString appendAttributedString:self.mrc_dateAttributedString];
    
    return attributedString;
}

- (NSMutableAttributedString *)mrc_octiconAttributedString {
    OCTIcon icon = 0;
    if ([self isMemberOfClass:[OCTCommitCommentEvent class]] ||
        [self isMemberOfClass:[OCTIssueCommentEvent class]] ||
        [self isMemberOfClass:[OCTPullRequestCommentEvent class]]) {
        icon = OCTIconCommentDiscussion;
    } else if ([self isMemberOfClass:[OCTForkEvent class]]) {
        icon = OCTIconGitBranch;
    } else if ([self isMemberOfClass:[OCTIssueEvent class]]) {
        OCTIssueEvent *concreteEvent = (OCTIssueEvent *)self;
        
        if (concreteEvent.action == OCTIssueActionOpened) {
            icon = OCTIconIssueOpened;
        } else if (concreteEvent.action == OCTIssueActionClosed) {
            icon = OCTIconIssueClosed;
        } else if (concreteEvent.action == OCTIssueActionReopened) {
            icon = OCTIconIssueReopened;
        }
    } else if ([self isMemberOfClass:[OCTMemberEvent class]]) {
        icon = OCTIconOrganization;
    } else if ([self isMemberOfClass:[OCTPublicEvent class]]) {
        icon = OCTIconRepo;
    } else if ([self isMemberOfClass:[OCTPullRequestEvent class]]) {
        icon = OCTIconGitPullRequest;
    } else if ([self isMemberOfClass:[OCTPushEvent class]]) {
        icon = OCTIconGitCommit;
    } else if ([self isMemberOfClass:[OCTRefEvent class]]) {
        OCTRefEvent *concreteEvent = (OCTRefEvent *)self;
        
        if (concreteEvent.refType == OCTRefTypeBranch) {
            icon = OCTIconGitBranch;
        } else if (concreteEvent.refType == OCTRefTypeTag) {
            icon = OCTIconTag;
        } else if (concreteEvent.refType == OCTRefTypeRepository) {
            icon = OCTIconRepo;
        }
    } else if ([self isMemberOfClass:[OCTWatchEvent class]]) {
        icon = OCTIconStar;
    }
    
    return [[NSString octicon_iconStringForEnum:icon] stringByAppendingString:@"  "].mrc_attributedString.mrc_addOcticonAttributes;
}

- (NSMutableAttributedString *)mrc_actorLoginAttributedString {
    return [self mrc_loginAttributedStringWithString:self.actorLogin];
}

- (NSMutableAttributedString *)mrc_loginAttributedStringWithString:(NSString *)string {
    NSMutableAttributedString *attributedString = string.mrc_attributedString;
    
    if (self.options & MRCEventOptionsBoldTitle) {
        [attributedString mrc_addBoldTitleFontAttribute];
    } else {
        [attributedString mrc_addNormalTitleFontAttribute];
    }
    
    [attributedString mrc_addTintedForegroundColorAttribute];
    [attributedString mrc_addUserLinkAttribute];
    
    return attributedString;
}

- (NSMutableAttributedString *)mrc_commentedCommitAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTCommitCommentEvent class]]);
    
    OCTCommitCommentEvent *concreteEvent = (OCTCommitCommentEvent *)self;
    
    NSString *target = [NSString stringWithFormat:@"%@@%@", concreteEvent.repositoryName, MRCShortSHA(concreteEvent.comment.commitSHA)];
    NSMutableAttributedString *attributedString = target.mrc_attributedString;
    
    NSURL *HTMLURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?title=Commit", concreteEvent.comment.HTMLURL.absoluteString]];
    
    [attributedString mrc_addBoldTitleFontAttribute];
    [attributedString mrc_addTintedForegroundColorAttribute];
    [attributedString mrc_addHTMLURLAttribute:HTMLURL];
    
    return attributedString;
}

- (NSMutableAttributedString *)mrc_forkedRepositoryNameAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTForkEvent class]]);
    
    OCTForkEvent *concreteEvent = (OCTForkEvent *)self;
    
    return [self mrc_repositoryNameAttributedStringWithString:concreteEvent.forkedRepositoryName];
}

- (NSMutableAttributedString *)mrc_repositoryNameAttributedString {
    return [self mrc_repositoryNameAttributedStringWithString:self.repositoryName];
}

- (NSMutableAttributedString *)mrc_repositoryNameAttributedStringWithString:(NSString *)string {
    NSMutableAttributedString *attributedString = string.mrc_attributedString;
    
    if (self.options & MRCEventOptionsBoldTitle) {
        attributedString = attributedString.mrc_addBoldTitleFontAttribute;
    } else {
        attributedString = attributedString.mrc_addNormalTitleAttributes;
    }
    
    return [attributedString.mrc_addTintedForegroundColorAttribute mrc_addRepositoryLinkAttributeWithName:attributedString.string referenceName:nil];
}

- (NSMutableAttributedString *)mrc_issueAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTIssueCommentEvent class]] || [self isMemberOfClass:[OCTIssueEvent class]]);
    
    OCTIssue *issue = [self valueForKey:@"issue"];
    
    NSString *issueID = [issue.URL.absoluteString componentsSeparatedByString:@"/"].lastObject;
    NSURL *HTMLURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?title=Issue-@%@", issue.HTMLURL.absoluteString, issueID]];
    
    NSMutableAttributedString *attributedString = [NSString stringWithFormat:@"%@#%@", self.repositoryName, issueID].mrc_attributedString;
    
    [attributedString mrc_addBoldTitleFontAttribute];
    [attributedString mrc_addTintedForegroundColorAttribute];
    [attributedString mrc_addHTMLURLAttribute:HTMLURL];
    
    return attributedString;
}

- (NSMutableAttributedString *)mrc_memberLoginAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTMemberEvent class]]);

    return [self mrc_loginAttributedStringWithString:[self valueForKey:@"memberLogin"]];
}

- (NSMutableAttributedString *)mrc_pullRequestAttributedString {
    NSParameterAssert([self isKindOfClass:[OCTPullRequestCommentEvent class]] || [self isMemberOfClass:[OCTPullRequestEvent class]]);
    
    NSString *pullRequestID = nil;
    NSURL *HTMLURL = nil;
    if ([self isKindOfClass:[OCTPullRequestCommentEvent class]]) {
        OCTPullRequestCommentEvent *concreteEvent = (OCTPullRequestCommentEvent *)self;
        
        pullRequestID = [concreteEvent.comment.pullRequestAPIURL.absoluteString componentsSeparatedByString:@"/"].lastObject;
      
        HTMLURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?title=Pull-Request-@%@", concreteEvent.comment.HTMLURL.absoluteString, pullRequestID]];
    } else if ([self isMemberOfClass:[OCTPullRequestEvent class]]) {
        OCTPullRequestEvent *concreteEvent = (OCTPullRequestEvent *)self;
        
        pullRequestID = [concreteEvent.pullRequest.URL.absoluteString componentsSeparatedByString:@"/"].lastObject;
        
        HTMLURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?title=Pull-Request-@%@", concreteEvent.pullRequest.HTMLURL.absoluteString, pullRequestID]];
    }
    
    NSParameterAssert(pullRequestID.length > 0);
    NSParameterAssert(HTMLURL);
    
    NSMutableAttributedString *attributedString = [NSString stringWithFormat:@"%@#%@", self.repositoryName, pullRequestID].mrc_attributedString;
    
    [attributedString mrc_addBoldTitleFontAttribute];
    [attributedString mrc_addTintedForegroundColorAttribute];
    [attributedString mrc_addHTMLURLAttribute:HTMLURL];
    
    return attributedString;
}

- (NSMutableAttributedString *)mrc_branchNameAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTPushEvent class]]);
    
    NSString *branchName = [self valueForKey:@"branchName"];
    
    NSMutableAttributedString *attributedString = branchName.mrc_attributedString;
    
    [attributedString mrc_addBoldTitleFontAttribute];
    [attributedString mrc_addTintedForegroundColorAttribute];
    [attributedString mrc_addRepositoryLinkAttributeWithName:self.repositoryName referenceName:MRCReferenceNameWithBranchName(branchName)];
    
    return attributedString;
}

- (NSMutableAttributedString *)mrc_pushedCommitAttributedStringWithSHA:(NSString *)SHA {
    NSParameterAssert([self isMemberOfClass:[OCTPushEvent class]]);
    
    NSMutableAttributedString *attributedString = MRCShortSHA(SHA).mrc_attributedString;
    
    NSURL *HTMLURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://github.com/%@/commit/%@?title=Commit", self.repositoryName, SHA]];
    
    [attributedString mrc_addNormalTitleFontAttribute];
    [attributedString mrc_addTintedForegroundColorAttribute];
    [attributedString mrc_addHTMLURLAttribute:HTMLURL];
    
    return attributedString;
}

- (NSMutableAttributedString *)mrc_pushedCommitsAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTPushEvent class]]);
    
    OCTPushEvent *concreteEvent = (OCTPushEvent *)self;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    for (NSDictionary *dictionary in concreteEvent.commits) {
        /* {
            "sha": "6e4dc62cffe9f2d1b1484819936ee264dde36592",
            "author": {
                "email": "coderyi@foxmail.com",
                "name": "coderyi"
            },
            "message": "增加iOS开发者coderyi的博客\n\n增加iOS开发者coderyi的博客",
            "distinct": true,
            "url": "https://api.github.com/repos/tangqiaoboy/iOSBlogCN/commits/6e4dc62cffe9f2d1b1484819936ee264dde36592"
        } */
        NSMutableAttributedString *commit = [[NSMutableAttributedString alloc] init];
        
        [commit appendAttributedString:@"\n".mrc_attributedString];
        [commit appendAttributedString:[self mrc_pushedCommitAttributedStringWithSHA:dictionary[@"sha"]]];
        [commit appendAttributedString:[@" - " stringByAppendingString:dictionary[@"message"]].mrc_attributedString.mrc_addNormalTitleAttributes];

        [attributedString appendAttributedString:commit];
    }
    
    return attributedString.mrc_addParagraphStyleAttribute;
}

- (NSMutableAttributedString *)mrc_refNameAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTRefEvent class]]);
    
    OCTRefEvent *concreteEvent = (OCTRefEvent *)self;

    if (!concreteEvent.refName) return @" ".mrc_attributedString;
    
    NSMutableAttributedString *attributedString = concreteEvent.refName.mrc_attributedString;
    
    [attributedString mrc_addNormalTitleFontAttribute];

    if (concreteEvent.eventType == OCTRefEventCreated) {
        [attributedString mrc_addTintedForegroundColorAttribute];
        
        if (concreteEvent.refType == OCTRefTypeBranch) {
            [attributedString mrc_addRepositoryLinkAttributeWithName:self.repositoryName referenceName:MRCReferenceNameWithBranchName(concreteEvent.refName)];
        } else if (concreteEvent.refType == OCTRefTypeTag) {
            [attributedString mrc_addRepositoryLinkAttributeWithName:self.repositoryName referenceName:MRCReferenceNameWithTagName(concreteEvent.refName)];
        }
    } else if (concreteEvent.eventType == OCTRefEventDeleted) {
        [attributedString insertAttributedString:@" ".mrc_attributedString atIndex:0];
        [attributedString appendAttributedString:@"\n".mrc_attributedString];
        [attributedString mrc_addNormalTitleForegroundColorAttribute];
        [attributedString mrc_addBackgroundColorAttribute];
    }

    return attributedString;
}

- (NSMutableAttributedString *)mrc_dateAttributedString {
    TTTTimeIntervalFormatter *timeIntervalFormatter = [[TTTTimeIntervalFormatter alloc] init];
    
    timeIntervalFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSString *date = [@"\n" stringByAppendingString:[timeIntervalFormatter stringForTimeIntervalFromDate:[NSDate date] toDate:self.date]];
    
    NSMutableAttributedString *attributedString = date.mrc_attributedString;
    
    [attributedString mrc_addTimeFontAttribute];
    [attributedString mrc_addTimeForegroundColorAttribute];
    [attributedString mrc_addParagraphStyleAttribute];
    
    return attributedString;
}

- (NSMutableAttributedString *)mrc_pullInfoAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTPullRequestEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    OCTPullRequestEvent *concreteEvent = (OCTPullRequestEvent *)self;
    
    NSString *octicon = [NSString stringWithFormat:@" %@ ", [NSString octicon_iconStringForEnum:OCTIconGitCommit]];
    
    NSString *commits   = concreteEvent.pullRequest.commits > 1 ? @" commits with " : @" commit with ";
    NSString *additions = concreteEvent.pullRequest.additions > 1 ? @" additions and " : @" addition and ";
    NSString *deletions = concreteEvent.pullRequest.deletions > 1 ? @" deletions " : @" deletion ";
    
    [attributedString appendAttributedString:octicon.mrc_attributedString.mrc_addOcticonAttributes.mrc_addParagraphStyleAttribute];
    [attributedString appendAttributedString:@(concreteEvent.pullRequest.commits).stringValue.mrc_attributedString.mrc_addBoldPullInfoFontAttribute.mrc_addPullInfoForegroundColorAttribute];
    [attributedString appendAttributedString:commits.mrc_attributedString.mrc_addNormalPullInfoFontAttribute.mrc_addPullInfoForegroundColorAttribute];
    [attributedString appendAttributedString:@(concreteEvent.pullRequest.additions).stringValue.mrc_attributedString.mrc_addBoldPullInfoFontAttribute.mrc_addPullInfoForegroundColorAttribute];
    [attributedString appendAttributedString:additions.mrc_attributedString.mrc_addNormalPullInfoFontAttribute.mrc_addPullInfoForegroundColorAttribute];
    [attributedString appendAttributedString:@(concreteEvent.pullRequest.deletions).stringValue.mrc_attributedString.mrc_addBoldPullInfoFontAttribute.mrc_addPullInfoForegroundColorAttribute];
    [attributedString appendAttributedString:deletions.mrc_attributedString.mrc_addNormalPullInfoFontAttribute.mrc_addPullInfoForegroundColorAttribute];
    [attributedString mrc_addBackgroundColorAttribute];
    
    return attributedString;
}

- (NSMutableAttributedString *)mrc_commitCommentEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTCommitCommentEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [attributedString appendAttributedString:@" commented on commit ".mrc_attributedString.mrc_addBoldTitleAttributes];
    [attributedString appendAttributedString:self.mrc_commentedCommitAttributedString];

    return attributedString;
}

- (NSMutableAttributedString *)mrc_forkEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTForkEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [attributedString appendAttributedString:@" forked ".mrc_attributedString.mrc_addNormalTitleAttributes];
    [attributedString appendAttributedString:self.mrc_repositoryNameAttributedString];
    [attributedString appendAttributedString:@" to ".mrc_attributedString.mrc_addNormalTitleAttributes];
    [attributedString appendAttributedString:self.mrc_forkedRepositoryNameAttributedString];
    
    return attributedString;
}

- (NSMutableAttributedString *)mrc_issueCommentEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTIssueCommentEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [attributedString appendAttributedString:@" commented on issue ".mrc_attributedString.mrc_addBoldTitleAttributes];
    [attributedString appendAttributedString:self.mrc_issueAttributedString];
    
    return attributedString;
}

- (NSMutableAttributedString *)mrc_issueEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTIssueEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    OCTIssueEvent *concreteEvent = (OCTIssueEvent *)self;
    
    NSString *action = nil;
    if (concreteEvent.action == OCTIssueActionOpened) {
        action = @"opened";
    } else if (concreteEvent.action == OCTIssueActionClosed) {
        action = @"closed";
    } else if (concreteEvent.action == OCTIssueActionReopened) {
        action = @"reopened";
    }
    
    [attributedString appendAttributedString:[NSString stringWithFormat:@" %@ issue ", action].mrc_attributedString.mrc_addBoldTitleAttributes];
    [attributedString appendAttributedString:self.mrc_issueAttributedString];
    [attributedString appendAttributedString:[@"\n" stringByAppendingString:concreteEvent.issue.title].mrc_attributedString.mrc_addNormalTitleAttributes.mrc_addParagraphStyleAttribute];
    
    return attributedString;
}

- (NSMutableAttributedString *)mrc_memberEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTMemberEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [attributedString appendAttributedString:@" added ".mrc_attributedString.mrc_addNormalTitleAttributes];
    [attributedString appendAttributedString:self.mrc_memberLoginAttributedString];
    [attributedString appendAttributedString:@" to ".mrc_attributedString.mrc_addNormalTitleAttributes];
    [attributedString appendAttributedString:self.mrc_repositoryNameAttributedString];
    
    return attributedString;
}

- (NSMutableAttributedString *)mrc_publicEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTPublicEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [attributedString appendAttributedString:@" open sourced ".mrc_attributedString.mrc_addNormalTitleAttributes];
    [attributedString appendAttributedString:self.mrc_repositoryNameAttributedString];
    
    return attributedString;
}

- (NSMutableAttributedString *)mrc_pullRequestCommentEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTPullRequestCommentEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [attributedString appendAttributedString:@" commented on pull request ".mrc_attributedString.mrc_addBoldTitleAttributes];
    [attributedString appendAttributedString:self.mrc_pullRequestAttributedString];
    
    return attributedString;
}

- (NSMutableAttributedString *)mrc_pullRequestEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTPullRequestEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    OCTPullRequestEvent *concreteEvent = (OCTPullRequestEvent *)self;
    
    NSString *action = nil;
    if (concreteEvent.action == OCTIssueActionOpened) {
        action = @"opened";
    } else if (concreteEvent.action == OCTIssueActionClosed) {
        action = @"closed";
    } else if (concreteEvent.action == OCTIssueActionReopened) {
        action = @"reopened";
    } else if (concreteEvent.action == OCTIssueActionSynchronized) {
        action = @"synchronized";
    }
    
    [attributedString appendAttributedString:[NSString stringWithFormat:@" %@ pull request ", action].mrc_attributedString.mrc_addBoldTitleAttributes];
    [attributedString appendAttributedString:self.mrc_pullRequestAttributedString];
    [attributedString appendAttributedString:[@"\n" stringByAppendingString:concreteEvent.pullRequest.title].mrc_attributedString.mrc_addNormalTitleAttributes.mrc_addParagraphStyleAttribute];
    [attributedString appendAttributedString:@"\n".mrc_attributedString];
    [attributedString appendAttributedString:self.mrc_pullInfoAttributedString];
    
    return attributedString;
}

- (NSMutableAttributedString *)mrc_pushEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTPushEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [attributedString appendAttributedString:@" pushed to ".mrc_attributedString.mrc_addBoldTitleAttributes];
    [attributedString appendAttributedString:self.mrc_branchNameAttributedString];
    [attributedString appendAttributedString:@" at ".mrc_attributedString.mrc_addBoldTitleAttributes];
    [attributedString appendAttributedString:self.mrc_repositoryNameAttributedString];
    [attributedString appendAttributedString:self.mrc_pushedCommitsAttributedString];
    
    return attributedString;
}

- (NSMutableAttributedString *)mrc_refEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTRefEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    OCTRefEvent *concreteEvent = (OCTRefEvent *)self;
    
    NSString *action = nil;
    if (concreteEvent.eventType == OCTRefEventCreated) {
        action = @"created";
    } else if (concreteEvent.eventType == OCTRefEventDeleted) {
        action = @"deleted";
    }
    
    NSString *type = nil;
    if (concreteEvent.refType == OCTRefTypeBranch) {
        type = @"branch";
    } else if (concreteEvent.refType == OCTRefTypeTag) {
        type = @"tag";
    } else if (concreteEvent.refType == OCTRefTypeRepository) {
        type = @"repository";
    }
    
    NSString *at = (concreteEvent.refType == OCTRefTypeBranch || concreteEvent.refType == OCTRefTypeTag ? @" at " : @"");
    
    [attributedString appendAttributedString:[NSString stringWithFormat:@" %@ %@ ", action, type].mrc_attributedString.mrc_addNormalTitleAttributes];
    [attributedString appendAttributedString:self.mrc_refNameAttributedString];
    [attributedString appendAttributedString:at.mrc_attributedString.mrc_addNormalTitleAttributes];
    [attributedString appendAttributedString:self.mrc_repositoryNameAttributedString];
    
    return attributedString;
}

- (NSMutableAttributedString *)mrc_watchEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTWatchEvent class]]);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    
    [attributedString appendAttributedString:@" starred ".mrc_attributedString.mrc_addNormalTitleAttributes];
    [attributedString appendAttributedString:self.mrc_repositoryNameAttributedString];
    
    return attributedString;
}

#pragma mark - Private

static NSString *MRCShortSHA(NSString *SHA) {
    NSCParameterAssert(SHA.length > 0);
    return [SHA substringToIndex:7];
}

@end
