//
//  OCTRef+MRCAdditions.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "OCTRef+MRCAdditions.h"

#define OCTRefBranchReferenceNamePrefix @"refs/heads/"
#define OCTRefTagReferenceNamePrefix    @"refs/tags/"

@implementation OCTRef (MRCAdditions)

NSString *mrc_defaultReferenceName() {
    return [OCTRefBranchReferenceNamePrefix stringByAppendingString:@"master"];
}

NSString *mrc_referenceNameWithBranchName(NSString *branchName) {
    NSCParameterAssert(branchName.length > 0);
    return [NSString stringWithFormat:@"%@%@", OCTRefBranchReferenceNamePrefix, branchName];
}

NSString *mrc_referenceNameWithTagName(NSString *tagName) {
    NSCParameterAssert(tagName.length > 0);
    return [NSString stringWithFormat:@"%@%@", OCTRefTagReferenceNamePrefix, tagName];
}

@end
