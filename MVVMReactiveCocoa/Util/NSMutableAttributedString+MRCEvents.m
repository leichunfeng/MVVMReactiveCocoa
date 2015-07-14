//
//  NSMutableAttributedString+MRCEvents.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/13.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "NSMutableAttributedString+MRCEvents.h"

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
	paragraphStyle.paragraphSpacing = 5; \
	paragraphStyle; \
})

@implementation NSString (MRCEvents)

- (NSMutableAttributedString *)mrc_attributedString {
    return [[NSMutableAttributedString alloc] initWithString:self];
}

@end

@implementation NSMutableAttributedString (MRCEvents)

#pragma mark - Font

- (NSMutableAttributedString *)mrc_addNormalTitleFontAttribute {
    [self addAttribute:NSFontAttributeName value:MRCEventsNormalTitleFont range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)mrc_addBoldTitleFontAttribute {
    [self addAttribute:NSFontAttributeName value:MRCEventsBoldTitleFont range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)mrc_addOcticonFontAttribute {
    [self addAttribute:NSFontAttributeName value:MRCEventsOcticonFont range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)mrc_addTimeFontAttribute {
    [self addAttribute:NSFontAttributeName value:MRCEventsTimeFont range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)mrc_addNormalPullInfoFontAttribute {
    [self addAttribute:NSFontAttributeName value:MRCEventsNormalPullInfoFont range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)mrc_addBoldPullInfoFontAttribute {
    [self addAttribute:NSFontAttributeName value:MRCEventsBoldPullInfoFont range:[self.string rangeOfString:self.string]];
    return self;
}

#pragma mark - Foreground Color

- (NSMutableAttributedString *)mrc_addTintedForegroundColorAttribute {
    [self addAttribute:NSForegroundColorAttributeName value:MRCEventsTintedForegroundColor range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)mrc_addNormalTitleForegroundColorAttribute {
    [self addAttribute:NSForegroundColorAttributeName value:MRCEventsNormalTitleForegroundColor range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)mrc_addBoldTitleForegroundColorAttribute {
    [self addAttribute:NSForegroundColorAttributeName value:MRCEventsBoldTitleForegroundColor range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)mrc_addTimeForegroundColorAttribute {
    [self addAttribute:NSForegroundColorAttributeName value:MRCEventsTimeForegroundColor range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)mrc_addPullInfoForegroundColorAttribute {
    [self addAttribute:NSForegroundColorAttributeName value:MRCEventsPullInfoForegroundColor range:[self.string rangeOfString:self.string]];
    return self;
}

#pragma mark - Background Color

- (NSMutableAttributedString *)mrc_addBackgroundColorAttribute {
    [self addAttribute:NSBackgroundColorAttributeName value:HexRGB(0xe8f1f6) range:[self.string rangeOfString:self.string]];
    return self;
}

#pragma mark - Paragraph Style

- (NSMutableAttributedString *)mrc_addParagraphStyleAttribute {
    [self addAttribute:NSParagraphStyleAttributeName value:MRCEventsParagraphStyle range:NSMakeRange(0, 1)];
    return self;
}

#pragma mark - Link

- (NSMutableAttributedString *)mrc_addUserLinkAttribute {
    [self addAttribute:NSLinkAttributeName value:[NSURL mrc_userLinkWithLogin:self.string] range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)mrc_addRepositoryLinkAttributeWithReferenceName:(NSString *)referenceName {
    [self addAttribute:NSLinkAttributeName value:[NSURL mrc_repositoryLinkWithName:self.string referenceName:referenceName] range:[self.string rangeOfString:self.string]];
    return self;
}

- (NSMutableAttributedString *)mrc_addHTMLURLAttribute:(NSURL *)HTMLURL {
    [self addAttribute:NSLinkAttributeName value:HTMLURL range:[self.string rangeOfString:self.string]];
    return self;
}

#pragma mark - Combination

- (NSMutableAttributedString *)mrc_addOcticonAttributes {
    [self appendString:@"  "];
    return [[self mrc_addOcticonFontAttribute] mrc_addTimeForegroundColorAttribute];
}

- (NSMutableAttributedString *)mrc_addNormalTitleAttributes {
    return [[self mrc_addBoldTitleFontAttribute] mrc_addBoldTitleForegroundColorAttribute];
}

- (NSMutableAttributedString *)mrc_addBoldTitleAttributes {
    return [[self mrc_addBoldTitleFontAttribute] mrc_addBoldTitleForegroundColorAttribute];
}

@end
