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

- (OCTEventOptions)options {
    OCTEventOptions options = 0;
    
    if ([self isMemberOfClass:[OCTCommitCommentEvent class]] ||
        [self isMemberOfClass:[OCTIssueCommentEvent class]] ||
        [self isMemberOfClass:[OCTIssueEvent class]] ||
        [self isMemberOfClass:[OCTPullRequestCommentEvent class]] ||
        [self isMemberOfClass:[OCTPullRequestEvent class]] ||
        [self isMemberOfClass:[OCTPushEvent class]]) {
        options |= OCTEventOptionsBoldTitle;
    }
    
    return options;
}

- (NSAttributedString *)mrc_attributedString {
    if ([self isMemberOfClass:[OCTCommitCommentEvent class]]) {
        return [self mrc_commitCommentEventAttributedString];
    } else if ([self isMemberOfClass:[OCTForkEvent class]]) {
        return [self mrc_forkEventAttributedString];
    } else if ([self isMemberOfClass:[OCTIssueCommentEvent class]]) {
        return [self mrc_issueCommentEventAttributedString];
    } else if ([self isMemberOfClass:[OCTIssueEvent class]]) {
        return [self mrc_issueEventAttributedString];
    } else if ([self isMemberOfClass:[OCTMemberEvent class]]) {
        return [self mrc_memberEventAttributedString];
    } else if ([self isMemberOfClass:[OCTPublicEvent class]]) {
        return [self mrc_publicEventAttributedString];
    } else if ([self isMemberOfClass:[OCTPullRequestCommentEvent class]]) {
        return [self mrc_pullRequestCommentEventAttributedString];
    } else if ([self isMemberOfClass:[OCTPullRequestEvent class]]) {
        return [self mrc_pullRequestEventAttributedString];
    } else if ([self isMemberOfClass:[OCTPushEvent class]]) {
        return [self mrc_pushEventAttributedString];
    } else if ([self isMemberOfClass:[OCTRefEvent class]]) {
        return [self mrc_refEventAttributedString];
    } else if ([self isMemberOfClass:[OCTWatchEvent class]]) {
        return [self mrc_watchEventAttributedString];
    }
    
    return nil;
}

- (NSMutableAttributedString *)mrc_actorLoginAttributedString {
    return [self mrc_loginAttributedStringWithString:self.actorLogin];
}

- (NSMutableAttributedString *)mrc_loginAttributedStringWithString:(NSString *)string {
    NSMutableAttributedString *attributedString = string.mrc_attributedString;
    
    if (self.options & OCTEventOptionsBoldTitle) {
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
    
    NSString *target = [NSString stringWithFormat:@"%@@%@", concreteEvent.repositoryName, [concreteEvent.comment.commitSHA substringToIndex:7]];
    NSMutableAttributedString *attributedString = target.mrc_attributedString;
    
    [attributedString mrc_addBoldTitleFontAttribute];
    [attributedString mrc_addTintedForegroundColorAttribute];
    [attributedString mrc_addHTMLURLAttribute:concreteEvent.comment.HTMLURL];
    
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
    
    if (self.options & OCTEventOptionsBoldTitle) {
        [attributedString mrc_addBoldTitleFontAttribute];
    } else {
        [attributedString mrc_addNormalTitleFontAttribute];
    }
    
    [attributedString mrc_addRepositoryLinkAttributeWithReferenceName:nil];
    
    return attributedString;
}

- (NSMutableAttributedString *)mrc_issueAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTIssueCommentEvent class]] || [self isMemberOfClass:[OCTIssueEvent class]]);
    
    OCTIssue *issue = [self valueForKey:@"issue"];
    
    NSMutableAttributedString *attributedString = [NSString stringWithFormat:@"%@#%@", self.repositoryName, [issue.URL.absoluteString componentsSeparatedByString:@"/"].lastObject].mrc_attributedString;
    
    [attributedString mrc_addBoldTitleFontAttribute];
    [attributedString mrc_addTintedForegroundColorAttribute];
    [attributedString mrc_addHTMLURLAttribute:issue.HTMLURL];
    
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
        HTMLURL = concreteEvent.comment.HTMLURL;
    } else if ([self isMemberOfClass:[OCTPullRequestEvent class]]) {
        OCTPullRequestEvent *concreteEvent = (OCTPullRequestEvent *)self;
        
        pullRequestID = [concreteEvent.pullRequest.URL.absoluteString componentsSeparatedByString:@"/"].lastObject;
        HTMLURL = concreteEvent.pullRequest.HTMLURL;
    }
    
    NSParameterAssert(pullRequestID.length > 0);
    NSParameterAssert(HTMLURL);
    
    NSMutableAttributedString *attributedString = [NSString stringWithFormat:@"%@#%@", self.repositoryName, pullRequestID].mrc_attributedString;
    
    [attributedString mrc_addBoldTitleFontAttribute];
    [attributedString mrc_addTintedForegroundColorAttribute];
    [attributedString mrc_addHTMLURLAttribute:HTMLURL];
    
    return nil;
}

- (NSMutableAttributedString *)mrc_branchNameAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTPushEvent class]]);
    
    NSString *branchName = [self valueForKey:@"branchName"];
    
    NSMutableAttributedString *attributedString = branchName.mrc_attributedString;
    
    [attributedString mrc_addBoldTitleFontAttribute];
    [attributedString mrc_addTintedForegroundColorAttribute];
    [attributedString mrc_addRepositoryLinkAttributeWithReferenceName:mrc_referenceNameWithBranchName(branchName)];
    
    return attributedString;
}

- (NSMutableAttributedString *)mrc_pushedCommitAttributedStringWithSHA:(NSString *)SHA {
    NSParameterAssert([self isMemberOfClass:[OCTPushEvent class]]);
    
    NSMutableAttributedString *attributedString = SHA.mrc_attributedString;
    
    [attributedString mrc_addNormalTitleFontAttribute];
    [attributedString mrc_addTintedForegroundColorAttribute];
    
    return nil;
}

- (NSMutableAttributedString *)mrc_refNameAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTRefEvent class]]);
    
    OCTRefEvent *concreteEvent = (OCTRefEvent *)self;

    if (!concreteEvent.refName) return nil;
    
    NSMutableAttributedString *attributedString = concreteEvent.refName.mrc_attributedString;
    
    [attributedString mrc_addNormalTitleFontAttribute];

    if (concreteEvent.eventType == OCTRefEventCreated) {
        [attributedString mrc_addTintedForegroundColorAttribute];
        
        if (concreteEvent.refType == OCTRefTypeBranch) {
            [attributedString mrc_addRepositoryLinkAttributeWithReferenceName:mrc_referenceNameWithBranchName(concreteEvent.refName)];
        } else if (concreteEvent.refType == OCTRefTypeTag) {
            [attributedString mrc_addRepositoryLinkAttributeWithReferenceName:mrc_referenceNameWithTagName(concreteEvent.refName)];
        }
    } else if (concreteEvent.eventType == OCTRefEventDeleted) {
        [attributedString mrc_addBackgroundColorAttribute];
    }

    return attributedString;
}

- (NSMutableAttributedString *)mrc_dateAttributedString {
    TTTTimeIntervalFormatter *timeIntervalFormatter = [TTTTimeIntervalFormatter new];
    
    timeIntervalFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSString *date = [@"\n" stringByAppendingString:[timeIntervalFormatter stringForTimeIntervalFromDate:[NSDate date] toDate:self.date]];
    
    NSMutableAttributedString *attributedString = date.mrc_attributedString;
    
    [attributedString mrc_addTimeFontAttribute];
    [attributedString mrc_addTimeForegroundColorAttribute];
    [attributedString mrc_addParagraphStyleAttribute];
    
    return attributedString;
}

- (NSAttributedString *)mrc_commitCommentEventAttributedString {
    NSParameterAssert([self isMemberOfClass:[OCTCommitCommentEvent class]]);
    
    NSMutableAttributedString *attributedString = [NSMutableAttributedString new];
    
    OCTCommitCommentEvent *concreteEvent = (OCTCommitCommentEvent *)self;
    
    NSString *octicon = [NSString octicon_iconStringForEnum:OCTIconCommentDiscussion];
    
    [attributedString appendAttributedString:octicon.mrc_attributedString.mrc_addOcticonAttributes];
    [attributedString appendAttributedString:self.mrc_actorLoginAttributedString];
    [attributedString appendAttributedString:[@" commented on commit ".mrc_attributedString mrc_addBoldTitleAttributes]];
    [attributedString appendAttributedString:self.mrc_commentedCommitAttributedString];
    [attributedString appendAttributedString:[[[@"\n" stringByAppendingString:concreteEvent.comment.body].mrc_attributedString mrc_addNormalTitleAttributes] mrc_addParagraphStyleAttribute]];
    [attributedString appendAttributedString:self.mrc_dateAttributedString];

    return attributedString;
}

- (NSAttributedString *)mrc_forkEventAttributedString {
    return nil;
}

- (NSAttributedString *)mrc_issueCommentEventAttributedString {
    return nil;
}

- (NSAttributedString *)mrc_issueEventAttributedString {
    return nil;
}

- (NSAttributedString *)mrc_memberEventAttributedString {
    return nil;
}

- (NSAttributedString *)mrc_publicEventAttributedString {
    return nil;
}

- (NSAttributedString *)mrc_pullRequestCommentEventAttributedString {
    return nil;
}

- (NSAttributedString *)mrc_pullRequestEventAttributedString {
    return nil;
}

- (NSAttributedString *)mrc_pushEventAttributedString {
    return nil;
}

- (NSAttributedString *)mrc_refEventAttributedString {
    return nil;
}

- (NSAttributedString *)mrc_watchEventAttributedString {
    return nil;
}

@end
