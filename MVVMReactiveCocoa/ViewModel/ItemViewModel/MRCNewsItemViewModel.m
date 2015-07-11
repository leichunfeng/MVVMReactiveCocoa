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
@property (strong, nonatomic, readwrite) NSString *imageIdentifier;
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
        NSString *target = event.repositoryName;
        
        NSDictionary *attributes = @{ NSForegroundColorAttributeName: HexRGB(0x4078c0),
                                      NSFontAttributeName: [UIFont boldSystemFontOfSize:16] };
        
        self.imageIdentifier = @"Unknown";

        if ([event.type isEqualToString:@"CommitCommentEvent"]) {
            OCTCommitCommentEvent *concreteEvent = (OCTCommitCommentEvent *)event;
            
            NSString *commit = [NSString stringWithFormat:@"%@@%@", concreteEvent.repositoryName, concreteEvent.comment.commitSHA];
            string = [NSString stringWithFormat:@"%@ commented on commit %@", concreteEvent.actorLogin, commit];
            
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:string]];
            
            target = commit;
            
            self.imageIdentifier = @"CommentDiscussion";
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
                self.imageIdentifier = @"GitBranch";
            } else if (concreteEvent.refType == OCTRefTypeTag) {
                object = @"tag";
                self.imageIdentifier = @"Tag";
            } else if (concreteEvent.refType == OCTRefTypeRepository) {
                object = @"repository";
                self.imageIdentifier = @"Repo";
            }
            
            NSString *refName = concreteEvent.refName ? [concreteEvent.refName stringByAppendingString:@" "] : @"";
            NSString *at = (concreteEvent.refType == OCTRefTypeBranch || concreteEvent.refType == OCTRefTypeTag ? @"at " : @"");
            
            string = [NSString stringWithFormat:@"%@ %@ %@ %@%@%@", concreteEvent.actorLogin, action, object, refName, at, concreteEvent.repositoryName];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:string]];
            [attributedString addAttributes:attributes range:[string rangeOfString:refName]];
        } else if ([event.type isEqualToString:@"ForkEvent"]) {
            OCTForkEvent *concreteEvent = (OCTForkEvent *)event;
            
            string = [NSString stringWithFormat:@"%@ forked %@ to %@", concreteEvent.actorLogin, concreteEvent.repositoryName, concreteEvent.forkedRepositoryName];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:string]];
            [attributedString addAttributes:attributes range:[string rangeOfString:concreteEvent.forkedRepositoryName]];
            
            self.imageIdentifier = @"GitBranch";
        } else if ([event.type isEqualToString:@"IssueCommentEvent"]) {
            OCTIssueCommentEvent *concreteEvent = (OCTIssueCommentEvent *)event;
            
            NSString *issue = [NSString stringWithFormat:@"%@#%@", concreteEvent.repositoryName, [concreteEvent.issue.URL.absoluteString componentsSeparatedByString:@"/"].lastObject];
            string = [NSString stringWithFormat:@"%@ commented on issue %@", concreteEvent.actorLogin, issue];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:string]];
            
            target = issue;
            
            self.imageIdentifier = @"CommentDiscussion";
        } else if ([event.type isEqualToString:@"IssuesEvent"]) {
            OCTIssueEvent *concreteEvent = (OCTIssueEvent *)event;
            
            NSString *action = @"";
            if (concreteEvent.action == OCTIssueActionOpened) {
                action = @"opened";
                self.imageIdentifier = @"IssueOpened";
            } else if (concreteEvent.action == OCTIssueActionClosed) {
                action = @"closed";
                self.imageIdentifier = @"IssueClosed";
            } else if (concreteEvent.action == OCTIssueActionReopened) {
                action = @"reopened";
                self.imageIdentifier = @"IssueReopened";
            } else if (concreteEvent.action == OCTIssueActionSynchronized) {
                action = @"synchronized";
            }
            
            NSString *issue = [NSString stringWithFormat:@"%@#%@", concreteEvent.repositoryName, [concreteEvent.issue.URL.absoluteString componentsSeparatedByString:@"/"].lastObject];
            string = [NSString stringWithFormat:@"%@ %@ issue %@", concreteEvent.actorLogin, action, issue];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:string]];
            
            target = issue;
        } else if ([event.type isEqualToString:@"MemberEvent"]) {
            OCTMemberEvent *concreteEvent = (OCTMemberEvent *)event;
            
            string = [NSString stringWithFormat:@"%@ added %@ to %@", concreteEvent.actorLogin, concreteEvent.memberLogin, concreteEvent.repositoryName];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:string]];
            [attributedString addAttributes:attributes range:[string rangeOfString:concreteEvent.memberLogin]];
        } else if ([event.type isEqualToString:@"PublicEvent"]) {
            OCTPublicEvent *concreteEvent = (OCTPublicEvent *)event;
            
            string = [NSString stringWithFormat:@"%@ open sourced %@", concreteEvent.actorLogin, concreteEvent.repositoryName];
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
            
            NSString *pullRequest = [NSString stringWithFormat:@"%@#%@", concreteEvent.repositoryName, [concreteEvent.pullRequest.URL.absoluteString componentsSeparatedByString:@"/"].lastObject];
            string = [NSString stringWithFormat:@"%@ %@ pull request %@", concreteEvent.actorLogin, action, pullRequest];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:string]];
            
            target = pullRequest;
            
            self.imageIdentifier = @"GitPullRequest";
        } else if ([event.type isEqualToString:@"PullRequestReviewCommentEvent"]) {
            OCTPullRequestCommentEvent *concreteEvent = (OCTPullRequestCommentEvent *)event;
            
            NSString *pullRequest = [NSString stringWithFormat:@"%@#%@", concreteEvent.repositoryName, [concreteEvent.comment.pullRequestAPIURL.absoluteString componentsSeparatedByString:@"/"].lastObject];
            string = [NSString stringWithFormat:@"%@ commented on pull request %@", concreteEvent.actorLogin, pullRequest];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:string]];
            
            target = pullRequest;
            
            self.imageIdentifier = @"CommentDiscussion";
        } else if ([event.type isEqualToString:@"PushEvent"]) {
            OCTPushEvent *concreteEvent = (OCTPushEvent *)event;
            
            string = [NSString stringWithFormat:@"%@ pushed to %@ at %@", concreteEvent.actorLogin, concreteEvent.branchName, concreteEvent.repositoryName];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:string]];
            [attributedString addAttributes:attributes range:[string rangeOfString:concreteEvent.branchName]];
            
            self.imageIdentifier = @"GitCommit";
        } else if ([event.type isEqualToString:@"WatchEvent"]) {
            OCTWatchEvent *concreteEvent = (OCTWatchEvent *)event;
            
            string = [NSString stringWithFormat:@"%@ starred %@", concreteEvent.actorLogin, concreteEvent.repositoryName];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[string rangeOfString:string]];
            
            self.imageIdentifier = @"Star";
        } else {
            NSLog(@"Unknown event type: %@", event.type);
        }

        [attributedString addAttributes:attributes range:[string rangeOfString:event.actorLogin]];
        [attributedString addAttributes:attributes range:[string rangeOfString:target]];
        
        self.contentAttributedString = attributedString;
        
        TTTTimeIntervalFormatter *timeIntervalFormatter = [TTTTimeIntervalFormatter new];
        timeIntervalFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        self.occurTime = [timeIntervalFormatter stringForTimeIntervalFromDate:[NSDate date] toDate:event.date].copy;
    }
    return self;
}

@end
