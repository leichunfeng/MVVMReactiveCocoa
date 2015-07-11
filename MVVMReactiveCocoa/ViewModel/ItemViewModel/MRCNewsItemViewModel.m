//
//  MRCNewsItemViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/5.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCNewsItemViewModel.h"
#import "TTTTimeIntervalFormatter.h"

@interface MRCNewsItemViewModel ()

@property (strong, nonatomic, readwrite) OCTEvent *event;
@property (strong, nonatomic, readwrite) NSAttributedString *contentAttributedString;
@property (copy, nonatomic, readwrite) NSString *occurTime;

@end

@implementation MRCNewsItemViewModel

- (instancetype)initWithEvent:(OCTEvent *)event {
    self = [super init];
    if (self) {
        self.event = event;

        NSMutableAttributedString *attributedString = nil;
        NSString *string = nil;
        NSString *actionIcon = @"";
        NSString *target = event.repositoryName;
        
        NSDictionary *stringAttributes = @{ NSForegroundColorAttributeName: HexRGB(0x4078c0),
                                            NSFontAttributeName: [UIFont boldSystemFontOfSize:16] };
        NSDictionary *actionIconAttributes = @{ NSFontAttributeName: [UIFont fontWithName:kOcticonsFamilyName size:16],
                                                NSForegroundColorAttributeName: [UIColor grayColor] };
        
        if ([event.type isEqualToString:@"CommitCommentEvent"]) {
            OCTCommitCommentEvent *concreteEvent = (OCTCommitCommentEvent *)event;
            
            actionIcon = [NSString octicon_iconStringForEnum:OCTIconCommentDiscussion];
            
            NSString *commit = [NSString stringWithFormat:@"%@@%@", concreteEvent.repositoryName, [concreteEvent.comment.commitSHA substringToIndex:7]];
            string = [NSString stringWithFormat:@"%@  %@ commented on commit %@", actionIcon, concreteEvent.actorLogin, commit];
            
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:string]];
            
            target = commit;
        } else if ([event.type isEqualToString:@"CreateEvent"] || [event.type isEqualToString:@"DeleteEvent"]) {
            OCTRefEvent *concreteEvent = (OCTRefEvent *)event;
            
            NSString *action = @"";
            if (concreteEvent.eventType == OCTRefEventCreated) {
                action = @"created";
            } else if (concreteEvent.eventType == OCTRefEventDeleted) {
                action = @"deleted";
            }
            
            NSString *object = @"";
            if (concreteEvent.refType == OCTRefTypeBranch) {
                object = @"branch";
                actionIcon = [NSString octicon_iconStringForEnum:OCTIconGitBranch];
            } else if (concreteEvent.refType == OCTRefTypeTag) {
                object = @"tag";
                actionIcon = [NSString octicon_iconStringForEnum:OCTIconTag];
            } else if (concreteEvent.refType == OCTRefTypeRepository) {
                object = @"repository";
                actionIcon = [NSString octicon_iconStringForEnum:OCTIconRepo];
            }
            
            NSString *refName = concreteEvent.refName ? [concreteEvent.refName stringByAppendingString:@" "] : @"";
            NSString *at = (concreteEvent.refType == OCTRefTypeBranch || concreteEvent.refType == OCTRefTypeTag ? @"at " : @"");
            
            string = [NSString stringWithFormat:@"%@  %@ %@ %@ %@%@%@", actionIcon, concreteEvent.actorLogin, action, object, refName, at, concreteEvent.repositoryName];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:string]];
            [attributedString addAttributes:stringAttributes range:[string rangeOfString:refName]];
        } else if ([event.type isEqualToString:@"ForkEvent"]) {
            OCTForkEvent *concreteEvent = (OCTForkEvent *)event;
            
            actionIcon = [NSString octicon_iconStringForEnum:OCTIconGitBranch];
            
            string = [NSString stringWithFormat:@"%@  %@ forked %@ to %@", actionIcon, concreteEvent.actorLogin, concreteEvent.repositoryName, concreteEvent.forkedRepositoryName];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:string]];
            [attributedString addAttributes:stringAttributes range:[string rangeOfString:concreteEvent.forkedRepositoryName]];
        } else if ([event.type isEqualToString:@"IssueCommentEvent"]) {
            OCTIssueCommentEvent *concreteEvent = (OCTIssueCommentEvent *)event;
            
            actionIcon = [NSString octicon_iconStringForEnum:OCTIconCommentDiscussion];
            
            NSString *issue = [NSString stringWithFormat:@"%@#%@", concreteEvent.repositoryName, [concreteEvent.issue.URL.absoluteString componentsSeparatedByString:@"/"].lastObject];
            string = [NSString stringWithFormat:@"%@  %@ commented on issue %@", actionIcon, concreteEvent.actorLogin, issue];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:string]];
            
            target = issue;
        } else if ([event.type isEqualToString:@"IssuesEvent"]) {
            OCTIssueEvent *concreteEvent = (OCTIssueEvent *)event;
            
            NSString *action = @"";
            if (concreteEvent.action == OCTIssueActionOpened) {
                action = @"opened";
                actionIcon = [NSString octicon_iconStringForEnum:OCTIconIssueOpened];
            } else if (concreteEvent.action == OCTIssueActionClosed) {
                action = @"closed";
                actionIcon = [NSString octicon_iconStringForEnum:OCTIconIssueClosed];
            } else if (concreteEvent.action == OCTIssueActionReopened) {
                action = @"reopened";
                actionIcon = [NSString octicon_iconStringForEnum:OCTIconIssueReopened];
            } else if (concreteEvent.action == OCTIssueActionSynchronized) {
                action = @"synchronized";
            }
            
            NSString *issue = [NSString stringWithFormat:@"%@#%@", concreteEvent.repositoryName, [concreteEvent.issue.URL.absoluteString componentsSeparatedByString:@"/"].lastObject];
            string = [NSString stringWithFormat:@"%@  %@ %@ issue %@", actionIcon, concreteEvent.actorLogin, action, issue];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:string]];
            
            target = issue;
        } else if ([event.type isEqualToString:@"MemberEvent"]) {
            OCTMemberEvent *concreteEvent = (OCTMemberEvent *)event;
            
            actionIcon = [NSString octicon_iconStringForEnum:OCTIconOrganization];
            
            string = [NSString stringWithFormat:@"%@  %@ added %@ to %@", actionIcon, concreteEvent.actorLogin, concreteEvent.memberLogin, concreteEvent.repositoryName];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:string]];
            [attributedString addAttributes:stringAttributes range:[string rangeOfString:concreteEvent.memberLogin]];
        } else if ([event.type isEqualToString:@"PublicEvent"]) {
            OCTPublicEvent *concreteEvent = (OCTPublicEvent *)event;
            
            actionIcon = [NSString octicon_iconStringForEnum:OCTIconRepo];
            
            string = [NSString stringWithFormat:@"%@  %@ open sourced %@", actionIcon, concreteEvent.actorLogin, concreteEvent.repositoryName];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:string]];
        } else if ([event.type isEqualToString:@"PullRequestEvent"]) {
            OCTPullRequestEvent *concreteEvent = (OCTPullRequestEvent *)event;
            
            NSString *action = @"";
            if (concreteEvent.action == OCTIssueActionOpened) {
                action = @"opened";
            } else if (concreteEvent.action == OCTIssueActionClosed) {
                action = @"closed";
            } else if (concreteEvent.action == OCTIssueActionReopened) {
                action = @"reopened";
            } else if (concreteEvent.action == OCTIssueActionSynchronized) {
                action = @"synchronized";
            }
            
            actionIcon = [NSString octicon_iconStringForEnum:OCTIconGitPullRequest];
            
            NSString *pullRequest = [NSString stringWithFormat:@"%@#%@", concreteEvent.repositoryName, [concreteEvent.pullRequest.URL.absoluteString componentsSeparatedByString:@"/"].lastObject];
            string = [NSString stringWithFormat:@"%@  %@ %@ pull request %@", actionIcon, concreteEvent.actorLogin, action, pullRequest];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:string]];
            
            target = pullRequest;
        } else if ([event.type isEqualToString:@"PullRequestReviewCommentEvent"]) {
            OCTPullRequestCommentEvent *concreteEvent = (OCTPullRequestCommentEvent *)event;
            
            actionIcon = [NSString octicon_iconStringForEnum:OCTIconCommentDiscussion];
            
            NSString *pullRequest = [NSString stringWithFormat:@"%@#%@", concreteEvent.repositoryName, [concreteEvent.comment.pullRequestAPIURL.absoluteString componentsSeparatedByString:@"/"].lastObject];
            string = [NSString stringWithFormat:@"%@  %@ commented on pull request %@", actionIcon, concreteEvent.actorLogin, pullRequest];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:string]];
            
            target = pullRequest;
        } else if ([event.type isEqualToString:@"PushEvent"]) {
            OCTPushEvent *concreteEvent = (OCTPushEvent *)event;
            
            actionIcon = [NSString octicon_iconStringForEnum:OCTIconGitCommit];
            
            string = [NSString stringWithFormat:@"%@  %@ pushed to %@ at %@", actionIcon, concreteEvent.actorLogin, concreteEvent.branchName, concreteEvent.repositoryName];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:string]];
            [attributedString addAttributes:stringAttributes range:[string rangeOfString:concreteEvent.branchName]];
        } else if ([event.type isEqualToString:@"WatchEvent"]) {
            OCTWatchEvent *concreteEvent = (OCTWatchEvent *)event;
            
            actionIcon = [NSString octicon_iconStringForIconIdentifier:@"Star"];
            
            string = [NSString stringWithFormat:@"%@  %@ starred %@", actionIcon, concreteEvent.actorLogin, concreteEvent.repositoryName];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:string]];
        } else {
            NSLog(@"Unknown event type: %@", event.type);
        }

        [attributedString addAttributes:actionIconAttributes range:[string rangeOfString:actionIcon]];
        [attributedString addAttributes:stringAttributes range:[string rangeOfString:event.actorLogin]];
        [attributedString addAttributes:stringAttributes range:[string rangeOfString:target]];
        
        self.contentAttributedString = attributedString;
        
        TTTTimeIntervalFormatter *timeIntervalFormatter = [TTTTimeIntervalFormatter new];
        timeIntervalFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        self.occurTime = [timeIntervalFormatter stringForTimeIntervalFromDate:[NSDate date] toDate:event.date].copy;
    }
    return self;
}

- (MRCNewsItemViewModelType)type {
    if ([self.event.type isEqualToString:@"CommitCommentEvent"]) {
        return MRCNewsItemViewModelTypeCommented;
    } else if ([self.event.type isEqualToString:@"CreateEvent"] || [self.event.type isEqualToString:@"DeleteEvent"]) {
    } else if ([self.event.type isEqualToString:@"ForkEvent"]) {
    } else if ([self.event.type isEqualToString:@"IssueCommentEvent"]) {
    } else if ([self.event.type isEqualToString:@"IssuesEvent"]) {
    } else if ([self.event.type isEqualToString:@"MemberEvent"]) {
    } else if ([self.event.type isEqualToString:@"PublicEvent"]) {
    } else if ([self.event.type isEqualToString:@"PullRequestEvent"]) {
    } else if ([self.event.type isEqualToString:@"PullRequestReviewCommentEvent"]) {
    } else if ([self.event.type isEqualToString:@"PushEvent"]) {
    } else if ([self.event.type isEqualToString:@"WatchEvent"]) {
    } else {
        NSLog(@"Unknown self.event type: %@", self.event.type);
    }
    return MRCNewsItemViewModelTypeStarred;
}

@end
