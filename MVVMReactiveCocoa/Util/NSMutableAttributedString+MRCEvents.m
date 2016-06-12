//
//  NSMutableAttributedString+MRCEvents.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/7/13.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "NSMutableAttributedString+MRCEvents.h"

NSString * const MRCLinkAttributeName = @"MRCLinkAttributeName";

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
    if (self.length > 0) {
        [self addAttribute:NSParagraphStyleAttributeName value:MRCEventsParagraphStyle range:NSMakeRange(0, MIN(2, self.length))];
    }
    return self;
}

#pragma mark - Link

- (NSMutableAttributedString *)mrc_addUserLinkAttribute {
    [self addAttribute:MRCLinkAttributeName value:[NSURL mrc_userLinkWithLogin:self.string] range:[self.string rangeOfString:self.string]];
    [self mrc_addHighlightAttribute];
    return self;
}

- (NSMutableAttributedString *)mrc_addRepositoryLinkAttributeWithName:(NSString *)name referenceName:(NSString *)referenceName {
    [self addAttribute:MRCLinkAttributeName value:[NSURL mrc_repositoryLinkWithName:name referenceName:referenceName] range:[self.string rangeOfString:self.string]];
    [self mrc_addHighlightAttribute];
    return self;
}

- (NSMutableAttributedString *)mrc_addHTMLURLAttribute:(NSURL *)HTMLURL {
    [self addAttribute:MRCLinkAttributeName value:HTMLURL range:[self.string rangeOfString:self.string]];
    [self mrc_addHighlightAttribute];
    return self;
}

#pragma mark - Highlight

- (NSMutableAttributedString *)mrc_addHighlightAttribute {
    YYTextBorder *highlightBorder = [[YYTextBorder alloc] init];
    
    highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
    highlightBorder.cornerRadius = 3;
//    highlightBorder.fillColor = HexRGB(0xbfdffe);
    highlightBorder.fillColor = HexRGB(0xD9D9D9);
    
    YYTextHighlight *highlight = [[YYTextHighlight alloc] init];
    [highlight setBackgroundBorder:highlightBorder];
    
    [self setTextHighlight:highlight range:[self.string rangeOfString:self.string]];
    
    return self;
}

#pragma mark - Combination

- (NSMutableAttributedString *)mrc_addOcticonAttributes {
    return [[self mrc_addOcticonFontAttribute] mrc_addTimeForegroundColorAttribute];
}

- (NSMutableAttributedString *)mrc_addNormalTitleAttributes {
    return [[self mrc_addNormalTitleFontAttribute] mrc_addNormalTitleForegroundColorAttribute];
}

- (NSMutableAttributedString *)mrc_addBoldTitleAttributes {
    return [[self mrc_addBoldTitleFontAttribute] mrc_addBoldTitleForegroundColorAttribute];
}

@end
