//
//  NSMutableAttributedString+MRCEvents.h
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/13.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

// Font

#define MRCEventsNormalTitleFont    [UIFont systemFontOfSize:15]
#define MRCEventsBoldTitleFont      [UIFont boldSystemFontOfSize:16]
#define MRCEventsOcticonFont        [UIFont fontWithName:kOcticonsFamilyName size:16]
#define MRCEventsTimeFont           [UIFont systemFontOfSize:13]
#define MRCEventsNormalPullInfoFont [UIFont systemFontOfSize:12]
#define MRCEventsBoldPullInfoFont   [UIFont boldSystemFontOfSize:12]

// Foreground Color

#define MRCEventsTintedForegroundColor      HexRGB(0x4078c0)
#define MRCEventsNormalTitleForegroundColor HexRGB(0x666666)
#define MRCEventsBoldTitleForegroundColor   HexRGB(0x333333)
#define MRCEventsTimeForegroundColor        HexRGB(0xbbbbbb)
#define MRCEventsPullInfoForegroundColor    RGBAlpha(0, 0, 0, 0.5)

// Paragraph Style

#define MRCEventsParagraphStyle ({ \
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init]; \
    paragraphStyle.paragraphSpacingBefore = 5; \
    paragraphStyle; \
})

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
- (NSMutableAttributedString *)mrc_addRepositoryLinkAttributeWithName:(NSString *)name referenceName:(NSString *)referenceName;
- (NSMutableAttributedString *)mrc_addHTMLURLAttribute:(NSURL *)HTMLURL;

// Highlight

- (NSMutableAttributedString *)mrc_addHighlightAttribute;

// Combination

- (NSMutableAttributedString *)mrc_addOcticonAttributes;
- (NSMutableAttributedString *)mrc_addNormalTitleAttributes;
- (NSMutableAttributedString *)mrc_addBoldTitleAttributes;

@end
