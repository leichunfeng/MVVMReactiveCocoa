//
//  MRCNewsItemViewModel.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/5.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCNewsItemViewModel.h"

@interface MRCNewsItemViewModel ()

@property (strong, nonatomic, readwrite) OCTEvent *event;
@property (strong, nonatomic, readwrite) NSAttributedString *contentAttributedString;

@end

@implementation MRCNewsItemViewModel

- (instancetype)initWithEvent:(OCTEvent *)event {
    self = [super init];
    if (self) {
        self.event = event;
        
        NSMutableAttributedString *attributedString = nil;
        if ([event.type isEqualToString:@"CommitCommentEvent"]) {
            OCTCommitCommentEvent *concreteEvent = (OCTCommitCommentEvent *)event;
            
            NSString *commit = [NSString stringWithFormat:@"%@@%@", concreteEvent.repositoryName, concreteEvent.comment.commitSHA];
            NSString *string = [NSString stringWithFormat:@"%@ commented on commit %@", concreteEvent.actorLogin, commit];
            
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];

            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:[string rangeOfString:string]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:concreteEvent.actorLogin]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:commit]];
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
            } else if (concreteEvent.refType == OCTRefTypeTag) {
                object = @"tag";
            } else if (concreteEvent.refType == OCTRefTypeRepository) {
                object = @"repository";
            }
            
            NSString *refName = concreteEvent.refName ?: @"";
            NSString *at = (concreteEvent.refType == OCTRefTypeBranch || concreteEvent.refType == OCTRefTypeTag ? @"at" : @"");
            
            NSString *string = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", concreteEvent.actorLogin, action, object, refName, at, concreteEvent.repositoryName];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:[string rangeOfString:string]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:concreteEvent.actorLogin]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:refName]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:concreteEvent.repositoryName]];
        } else if ([event.type isEqualToString:@"ForkEvent"]) {
            OCTForkEvent *concreteEvent = (OCTForkEvent *)event;
            
            NSString *string = [NSString stringWithFormat:@"%@ forked %@ to %@", concreteEvent.actorLogin, concreteEvent.forkedRepositoryName, concreteEvent.repositoryName];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:[string rangeOfString:string]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:concreteEvent.actorLogin]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:concreteEvent.forkedRepositoryName]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:concreteEvent.repositoryName]];
        } else if ([event.type isEqualToString:@"IssueCommentEvent"]) {
            OCTIssueCommentEvent *concreteEvent = (OCTIssueCommentEvent *)event;
            
            NSString *issue = [NSString stringWithFormat:@"%@#%@", concreteEvent.repositoryName, concreteEvent.issue.title];
            NSString *string = [NSString stringWithFormat:@"%@ commented on issue %@", concreteEvent.actorLogin, issue];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:[string rangeOfString:string]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:concreteEvent.actorLogin]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:issue]];
        } else if ([event.type isEqualToString:@"IssuesEvent"]) {
            OCTIssueEvent *concreteEvent = (OCTIssueEvent *)event;
            
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
            
            NSString *issue = [NSString stringWithFormat:@"%@#%@", concreteEvent.repositoryName, concreteEvent.issue.title];
            NSString *string = [NSString stringWithFormat:@"%@ %@ issue %@", concreteEvent.actorLogin, action, issue];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:[string rangeOfString:string]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:concreteEvent.actorLogin]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:issue]];
        } else if ([event.type isEqualToString:@"MemberEvent"]) {
            OCTMemberEvent *concreteEvent = (OCTMemberEvent *)event;
            
            NSString *string = [NSString stringWithFormat:@"%@ added %@ to %@", concreteEvent.actorLogin, concreteEvent.memberLogin, concreteEvent.repositoryName];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:[string rangeOfString:string]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:concreteEvent.actorLogin]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:concreteEvent.memberLogin]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:concreteEvent.repositoryName]];
        } else if ([event.type isEqualToString:@"PublicEvent"]) {
            OCTPublicEvent *concreteEvent = (OCTPublicEvent *)event;
            
            NSString *string = [NSString stringWithFormat:@"%@ open sourced %@", concreteEvent.actorLogin, concreteEvent.repositoryName];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:[string rangeOfString:string]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:concreteEvent.actorLogin]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:concreteEvent.repositoryName]];
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
            
            NSString *pullRequest = [NSString stringWithFormat:@"%@#%@", concreteEvent.repositoryName, concreteEvent.pullRequest.title];
            NSString *string = [NSString stringWithFormat:@"%@ %@ pull request %@", concreteEvent.actorLogin, action, pullRequest];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:[string rangeOfString:string]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:concreteEvent.actorLogin]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:pullRequest]];
        } else if ([event.type isEqualToString:@"PullRequestReviewCommentEvent"]) {
            OCTPullRequestCommentEvent *concreteEvent = (OCTPullRequestCommentEvent *)event;
            
            NSString *pullRequest = [NSString stringWithFormat:@"%@#%@", concreteEvent.repositoryName, concreteEvent.pullRequest.title];
            NSString *string = [NSString stringWithFormat:@"%@ commented on pull request %@", concreteEvent.actorLogin, pullRequest];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:[string rangeOfString:string]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:concreteEvent.actorLogin]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:pullRequest]];
        } else if ([event.type isEqualToString:@"PushEvent"]) {
            OCTPushEvent *concreteEvent = (OCTPushEvent *)event;
            
            NSString *string = [NSString stringWithFormat:@"%@ pushed to %@ at %@", concreteEvent.actorLogin, concreteEvent.branchName, concreteEvent.repositoryName];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:[string rangeOfString:string]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:concreteEvent.actorLogin]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:concreteEvent.branchName]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:concreteEvent.repositoryName]];
        } else if ([event.type isEqualToString:@"WatchEvent"]) {
            OCTWatchEvent *concreteEvent = (OCTWatchEvent *)event;
            
            NSString *string = [NSString stringWithFormat:@"%@ starred %@", concreteEvent.actorLogin, concreteEvent.repositoryName];
            attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:[string rangeOfString:string]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:concreteEvent.actorLogin]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:HexRGB(0x4078c0) range:[string rangeOfString:concreteEvent.repositoryName]];
        }
        
        self.contentAttributedString = attributedString;
    }
    return self;
}

@end
