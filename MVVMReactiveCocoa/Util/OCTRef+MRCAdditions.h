//
//  OCTRef+MRCAdditions.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/14.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <OctoKit/OctoKit.h>

@interface OCTRef (MRCAdditions)

NSString *mrc_defaultReferenceName();
NSString *mrc_referenceNameWithBranchName(NSString *branchName);
NSString *mrc_referenceNameWithTagName(NSString *tagName);

@end
