//
//  NSURL+MRCLink.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/13.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "NSURL+MRCLink.h"

#define MRCLinkUserScheme @"user"
#define MRCLinkRepositoryScheme @"repository"

extern NSString * const MRCLinkAttributeName;

@implementation NSURL (MRCLink)

- (MRCLinkType)type {
    if ([self.scheme isEqualToString:MRCLinkUserScheme]) {
        return MRCLinkTypeUser;
    } else if ([self.scheme isEqualToString:MRCLinkRepositoryScheme]) {
        return MRCLinkTypeRepository;
    }
    return MRCLinkTypeUnknown;
}

+ (instancetype)mrc_userLinkWithLogin:(NSString *)login {
    NSParameterAssert(login.length > 0);
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@", MRCLinkUserScheme, login]];;
}

+ (instancetype)mrc_repositoryLinkWithName:(NSString *)name referenceName:(NSString *)referenceName {
    NSParameterAssert(name.length > 0);
    
    referenceName = referenceName ?: MRCDefaultReferenceName(); // FIXME
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@?referenceName=%@", MRCLinkRepositoryScheme, name, referenceName]];
}

- (NSDictionary *)mrc_dictionary {
    if (self.type == MRCLinkTypeUser) {
        return @{
            @"user": @{
            	@"login": self.host ?: @""
            }
    	};
    } else if (self.type == MRCLinkTypeRepository) {
        return @{
        	@"repository": @{
                @"ownerLogin": self.host ?: @"",
                @"name": [self.path substringFromIndex:1] ?: @"",
            },
            @"referenceName": [self.query componentsSeparatedByString:@"="].lastObject ?: @""
        };
    }
    return nil;
}

@end

@implementation OCTEvent (MRCLink)

- (NSURL *)mrc_Link {
    NSMutableAttributedString *attributedString = nil;
    
    if ([self isMemberOfClass:[OCTCommitCommentEvent class]]) {
		attributedString = self.mrc_commentedCommitAttributedString;
    } else if ([self isMemberOfClass:[OCTForkEvent class]]) {
		attributedString = self.mrc_forkedRepositoryNameAttributedString;
    } else if ([self isMemberOfClass:[OCTIssueCommentEvent class]]) {
		attributedString = self.mrc_issueAttributedString;
    } else if ([self isMemberOfClass:[OCTIssueEvent class]]) {
		attributedString = self.mrc_issueAttributedString;
    } else if ([self isMemberOfClass:[OCTMemberEvent class]]) {
		attributedString = self.mrc_memberLoginAttributedString;
    } else if ([self isMemberOfClass:[OCTPublicEvent class]]) {
		attributedString = self.mrc_repositoryNameAttributedString;
    } else if ([self isMemberOfClass:[OCTPullRequestCommentEvent class]]) {
		attributedString = self.mrc_pullRequestAttributedString;
    } else if ([self isMemberOfClass:[OCTPullRequestEvent class]]) {
		attributedString = self.mrc_pullRequestAttributedString;
    } else if ([self isMemberOfClass:[OCTPushEvent class]]) {
		attributedString = self.mrc_branchNameAttributedString;
    } else if ([self isMemberOfClass:[OCTRefEvent class]]) {
        if ([self.mrc_refNameAttributedString attribute:MRCLinkAttributeName atIndex:0 effectiveRange:NULL]) {
            attributedString = self.mrc_refNameAttributedString;
        } else {
            attributedString = self.mrc_repositoryNameAttributedString;
        }
    } else if ([self isMemberOfClass:[OCTWatchEvent class]]) {
		attributedString = self.mrc_repositoryNameAttributedString;
    }
    
    return [attributedString attribute:MRCLinkAttributeName atIndex:0 effectiveRange:NULL];
}

@end
