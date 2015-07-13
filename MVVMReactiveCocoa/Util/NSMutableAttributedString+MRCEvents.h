//
//  NSMutableAttributedString+MRCEvents.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/13.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (MRCEvents)

// Font

- (void)mrc_addNormalTitleFontAttribute;
- (void)mrc_addBoldTitleFontAttribute;
- (void)mrc_addOcticonFontAttribute;
- (void)mrc_addTimeFontAttribute;
- (void)mrc_addNormalPullInfoFontAttribute;
- (void)mrc_addBoldPullInfoFontAttribute;

// Foreground Color

- (void)mrc_addTintedForegroundColorAttribute;
- (void)mrc_addNormalTitleForegroundColorAttribute;
- (void)mrc_addBoldTitleForegroundColorAttribute;
- (void)mrc_addTimeForegroundColorAttribute;
- (void)mrc_addPullInfoForegroundColorAttribute;

// Paragraph Style

- (void)mrc_addParagraphStyleAttribute;

// Link

- (void)mrc_addUserLink;
- (void)mrc_addRepositoryLinkWithBranch:(NSString *)branch;
- (void)mrc_addHTMLURL:(NSURL *)HTMLURL;

@end



