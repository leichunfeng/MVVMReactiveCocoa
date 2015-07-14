//
//  OCTRef+MRCAdditions.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "OCTRef+MRCAdditions.h"

#define MRCRefBranchReferenceNamePrefix @"refs/heads/"
#define MRCRefTagReferenceNamePrefix    @"refs/tags/"

@implementation OCTRef (MRCAdditions)

NSString *MRCDefaultReferenceName() {
    return [MRCRefBranchReferenceNamePrefix stringByAppendingString:@"master"];
}

NSString *MRCReferenceNameWithBranchName(NSString *branchName) {
    NSCParameterAssert(branchName.length > 0);
    return [NSString stringWithFormat:@"%@%@", MRCRefBranchReferenceNamePrefix, branchName];
}

NSString *MRCReferenceNameWithTagName(NSString *tagName) {
    NSCParameterAssert(tagName.length > 0);
    return [NSString stringWithFormat:@"%@%@", MRCRefTagReferenceNamePrefix, tagName];
}

@end
