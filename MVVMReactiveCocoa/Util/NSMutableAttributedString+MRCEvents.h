//
//  NSMutableAttributedString+MRCEvents.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/13.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MRCEvents)

- (NSMutableAttributedString *)mrc_attributedString;

@end

@interface NSMutableAttributedString (MRCEvents)

// Font

- (NSMutableAttributedString *)mrc_addNormalTitleFontAttribute;
- (NSMutableAttributedString *)mrc_addBoldTitleFontAttribute;
- (NSMutableAttributedString *)mrc_addOcticonFontAttribute;
- (NSMutableAttributedString *)mrc_addTimeFontAttribute;
- (NSMutableAttributedString *)mrc_addNormalPullInfoFontAttribute;
- (NSMutableAttributedString *)mrc_addBoldPullInfoFontAttribute;

// Foreground Color

- (NSMutableAttributedString *)mrc_addTintedForegroundColorAttribute;
- (NSMutableAttributedString *)mrc_addNormalTitleForegroundColorAttribute;
- (NSMutableAttributedString *)mrc_addBoldTitleForegroundColorAttribute;
- (NSMutableAttributedString *)mrc_addTimeForegroundColorAttribute;
- (NSMutableAttributedString *)mrc_addPullInfoForegroundColorAttribute;

// Background Color

- (NSMutableAttributedString *)mrc_addBackgroundColorAttribute;

// Paragraph Style

- (NSMutableAttributedString *)mrc_addParagraphStyleAttribute;

// Link

- (NSMutableAttributedString *)mrc_addUserLinkAttribute;
- (NSMutableAttributedString *)mrc_addRepositoryLinkAttributeWithReferenceName:(NSString *)referenceName;
- (NSMutableAttributedString *)mrc_addHTMLURLAttribute:(NSURL *)HTMLURL;

// Combination

- (NSMutableAttributedString *)mrc_addOcticonAttributes;
- (NSMutableAttributedString *)mrc_addNormalTitleAttributes;
- (NSMutableAttributedString *)mrc_addBoldTitleAttributes;

@end



