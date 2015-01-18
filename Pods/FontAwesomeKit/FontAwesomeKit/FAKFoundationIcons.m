#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FAKFoundationIcons.h"

@implementation FAKFoundationIcons

+ (UIFont *)iconFontWithSize:(CGFloat)size
{
#ifndef DISABLE_FOUNDATIONICONS_AUTO_REGISTRATION
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self registerIconFontWithURL: [[NSBundle mainBundle] URLForResource:@"foundation-icons" withExtension:@"ttf"]];
    });
#endif
    
    UIFont *font = [UIFont fontWithName:@"fontcustom" size:size];
    NSAssert(font, @"UIFont object should not be nil, check if the font file is added to the application bundle and you're using the correct font name.");
    return font;
}

// Generated Code
+ (instancetype)addressBookIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf100" size:size]; }
+ (instancetype)alertIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf101" size:size]; }
+ (instancetype)alignCenterIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf102" size:size]; }
+ (instancetype)alignJustifyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf103" size:size]; }
+ (instancetype)alignLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf104" size:size]; }
+ (instancetype)alignRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf105" size:size]; }
+ (instancetype)anchorIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf106" size:size]; }
+ (instancetype)annotateIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf107" size:size]; }
+ (instancetype)archiveIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf108" size:size]; }
+ (instancetype)arrowDownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf109" size:size]; }
+ (instancetype)arrowLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf10a" size:size]; }
+ (instancetype)arrowRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf10b" size:size]; }
+ (instancetype)arrowUpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf10c" size:size]; }
+ (instancetype)arrowsCompressIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf10d" size:size]; }
+ (instancetype)arrowsExpandIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf10e" size:size]; }
+ (instancetype)arrowsInIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf10f" size:size]; }
+ (instancetype)arrowsOutIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf110" size:size]; }
+ (instancetype)aslIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf111" size:size]; }
+ (instancetype)asteriskIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf112" size:size]; }
+ (instancetype)atSignIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf113" size:size]; }
+ (instancetype)backgroundColorIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf114" size:size]; }
+ (instancetype)batteryEmptyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf115" size:size]; }
+ (instancetype)batteryFullIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf116" size:size]; }
+ (instancetype)batteryHalfIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf117" size:size]; }
+ (instancetype)bitcoinCircleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf118" size:size]; }
+ (instancetype)bitcoinIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf119" size:size]; }
+ (instancetype)blindIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf11a" size:size]; }
+ (instancetype)bluetoothIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf11b" size:size]; }
+ (instancetype)boldIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf11c" size:size]; }
+ (instancetype)bookBookmarkIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf11d" size:size]; }
+ (instancetype)bookIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf11e" size:size]; }
+ (instancetype)bookmarkIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf11f" size:size]; }
+ (instancetype)brailleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf120" size:size]; }
+ (instancetype)burstNewIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf121" size:size]; }
+ (instancetype)burstSaleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf122" size:size]; }
+ (instancetype)burstIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf123" size:size]; }
+ (instancetype)calendarIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf124" size:size]; }
+ (instancetype)cameraIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf125" size:size]; }
+ (instancetype)checkIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf126" size:size]; }
+ (instancetype)checkboxIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf127" size:size]; }
+ (instancetype)clipboardNotesIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf128" size:size]; }
+ (instancetype)clipboardPencilIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf129" size:size]; }
+ (instancetype)clipboardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf12a" size:size]; }
+ (instancetype)clockIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf12b" size:size]; }
+ (instancetype)closedCaptionIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf12c" size:size]; }
+ (instancetype)cloudIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf12d" size:size]; }
+ (instancetype)commentMinusIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf12e" size:size]; }
+ (instancetype)commentQuotesIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf12f" size:size]; }
+ (instancetype)commentVideoIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf130" size:size]; }
+ (instancetype)commentIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf131" size:size]; }
+ (instancetype)commentsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf132" size:size]; }
+ (instancetype)compassIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf133" size:size]; }
+ (instancetype)contrastIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf134" size:size]; }
+ (instancetype)creditCardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf135" size:size]; }
+ (instancetype)cropIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf136" size:size]; }
+ (instancetype)crownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf137" size:size]; }
+ (instancetype)css3IconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf138" size:size]; }
+ (instancetype)databaseIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf139" size:size]; }
+ (instancetype)dieFiveIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf13a" size:size]; }
+ (instancetype)dieFourIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf13b" size:size]; }
+ (instancetype)dieOneIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf13c" size:size]; }
+ (instancetype)dieSixIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf13d" size:size]; }
+ (instancetype)dieThreeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf13e" size:size]; }
+ (instancetype)dieTwoIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf13f" size:size]; }
+ (instancetype)dislikeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf140" size:size]; }
+ (instancetype)dollarBillIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf141" size:size]; }
+ (instancetype)dollarIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf142" size:size]; }
+ (instancetype)downloadIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf143" size:size]; }
+ (instancetype)ejectIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf144" size:size]; }
+ (instancetype)elevatorIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf145" size:size]; }
+ (instancetype)euroIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf146" size:size]; }
+ (instancetype)eyeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf147" size:size]; }
+ (instancetype)fastForwardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf148" size:size]; }
+ (instancetype)femaleSymbolIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf149" size:size]; }
+ (instancetype)femaleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf14a" size:size]; }
+ (instancetype)filterIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf14b" size:size]; }
+ (instancetype)firstAidIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf14c" size:size]; }
+ (instancetype)flagIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf14d" size:size]; }
+ (instancetype)folderAddIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf14e" size:size]; }
+ (instancetype)folderLockIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf14f" size:size]; }
+ (instancetype)folderIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf150" size:size]; }
+ (instancetype)footIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf151" size:size]; }
+ (instancetype)foundationIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf152" size:size]; }
+ (instancetype)graphBarIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf153" size:size]; }
+ (instancetype)graphHorizontalIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf154" size:size]; }
+ (instancetype)graphPieIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf155" size:size]; }
+ (instancetype)graphTrendIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf156" size:size]; }
+ (instancetype)guideDogIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf157" size:size]; }
+ (instancetype)hearingAidIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf158" size:size]; }
+ (instancetype)heartIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf159" size:size]; }
+ (instancetype)homeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf15a" size:size]; }
+ (instancetype)html5IconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf15b" size:size]; }
+ (instancetype)indentLessIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf15c" size:size]; }
+ (instancetype)indentMoreIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf15d" size:size]; }
+ (instancetype)infoIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf15e" size:size]; }
+ (instancetype)italicIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf15f" size:size]; }
+ (instancetype)keyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf160" size:size]; }
+ (instancetype)laptopIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf161" size:size]; }
+ (instancetype)layoutIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf162" size:size]; }
+ (instancetype)lightbulbIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf163" size:size]; }
+ (instancetype)likeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf164" size:size]; }
+ (instancetype)linkIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf165" size:size]; }
+ (instancetype)listBulletIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf166" size:size]; }
+ (instancetype)listNumberIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf167" size:size]; }
+ (instancetype)listThumbnailsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf168" size:size]; }
+ (instancetype)listIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf169" size:size]; }
+ (instancetype)lockIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf16a" size:size]; }
+ (instancetype)loopIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf16b" size:size]; }
+ (instancetype)magnifyingGlassIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf16c" size:size]; }
+ (instancetype)mailIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf16d" size:size]; }
+ (instancetype)maleFemaleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf16e" size:size]; }
+ (instancetype)maleSymbolIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf16f" size:size]; }
+ (instancetype)maleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf170" size:size]; }
+ (instancetype)mapIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf171" size:size]; }
+ (instancetype)markerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf172" size:size]; }
+ (instancetype)megaphoneIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf173" size:size]; }
+ (instancetype)microphoneIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf174" size:size]; }
+ (instancetype)minusCircleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf175" size:size]; }
+ (instancetype)minusIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf176" size:size]; }
+ (instancetype)mobileSignalIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf177" size:size]; }
+ (instancetype)mobileIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf178" size:size]; }
+ (instancetype)monitorIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf179" size:size]; }
+ (instancetype)mountainsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf17a" size:size]; }
+ (instancetype)musicIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf17b" size:size]; }
+ (instancetype)nextIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf17c" size:size]; }
+ (instancetype)noDogsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf17d" size:size]; }
+ (instancetype)noSmokingIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf17e" size:size]; }
+ (instancetype)pageAddIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf17f" size:size]; }
+ (instancetype)pageCopyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf180" size:size]; }
+ (instancetype)pageCsvIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf181" size:size]; }
+ (instancetype)pageDeleteIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf182" size:size]; }
+ (instancetype)pageDocIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf183" size:size]; }
+ (instancetype)pageEditIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf184" size:size]; }
+ (instancetype)pageExportCsvIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf185" size:size]; }
+ (instancetype)pageExportDocIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf186" size:size]; }
+ (instancetype)pageExportPdfIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf187" size:size]; }
+ (instancetype)pageExportIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf188" size:size]; }
+ (instancetype)pageFilledIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf189" size:size]; }
+ (instancetype)pageMultipleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf18a" size:size]; }
+ (instancetype)pagePdfIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf18b" size:size]; }
+ (instancetype)pageRemoveIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf18c" size:size]; }
+ (instancetype)pageSearchIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf18d" size:size]; }
+ (instancetype)pageIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf18e" size:size]; }
+ (instancetype)paintBucketIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf18f" size:size]; }
+ (instancetype)paperclipIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf190" size:size]; }
+ (instancetype)pauseIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf191" size:size]; }
+ (instancetype)pawIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf192" size:size]; }
+ (instancetype)paypalIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf193" size:size]; }
+ (instancetype)pencilIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf194" size:size]; }
+ (instancetype)photoIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf195" size:size]; }
+ (instancetype)playCircleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf196" size:size]; }
+ (instancetype)playVideoIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf197" size:size]; }
+ (instancetype)playIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf198" size:size]; }
+ (instancetype)plusIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf199" size:size]; }
+ (instancetype)poundIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf19a" size:size]; }
+ (instancetype)powerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf19b" size:size]; }
+ (instancetype)previousIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf19c" size:size]; }
+ (instancetype)priceTagIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf19d" size:size]; }
+ (instancetype)pricetagMultipleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf19e" size:size]; }
+ (instancetype)printIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf19f" size:size]; }
+ (instancetype)prohibitedIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a0" size:size]; }
+ (instancetype)projectionScreenIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a1" size:size]; }
+ (instancetype)puzzleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a2" size:size]; }
+ (instancetype)quoteIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a3" size:size]; }
+ (instancetype)recordIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a4" size:size]; }
+ (instancetype)refreshIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a5" size:size]; }
+ (instancetype)resultsDemographicsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a6" size:size]; }
+ (instancetype)resultsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a7" size:size]; }
+ (instancetype)rewindTenIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a8" size:size]; }
+ (instancetype)rewindIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a9" size:size]; }
+ (instancetype)rssIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1aa" size:size]; }
+ (instancetype)safetyConeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ab" size:size]; }
+ (instancetype)saveIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ac" size:size]; }
+ (instancetype)shareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ad" size:size]; }
+ (instancetype)sheriffBadgeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ae" size:size]; }
+ (instancetype)shieldIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1af" size:size]; }
+ (instancetype)shoppingBagIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b0" size:size]; }
+ (instancetype)shoppingCartIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b1" size:size]; }
+ (instancetype)shuffleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b2" size:size]; }
+ (instancetype)skullIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b3" size:size]; }
+ (instancetype)social500pxIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b4" size:size]; }
+ (instancetype)socialAdobeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b5" size:size]; }
+ (instancetype)socialAmazonIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b6" size:size]; }
+ (instancetype)socialAndroidIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b7" size:size]; }
+ (instancetype)socialAppleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b8" size:size]; }
+ (instancetype)socialBehanceIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b9" size:size]; }
+ (instancetype)socialBingIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ba" size:size]; }
+ (instancetype)socialBloggerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1bb" size:size]; }
+ (instancetype)socialDeliciousIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1bc" size:size]; }
+ (instancetype)socialDesignerNewsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1bd" size:size]; }
+ (instancetype)socialDeviantArtIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1be" size:size]; }
+ (instancetype)socialDiggIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1bf" size:size]; }
+ (instancetype)socialDribbbleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c0" size:size]; }
+ (instancetype)socialDriveIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c1" size:size]; }
+ (instancetype)socialDropboxIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c2" size:size]; }
+ (instancetype)socialEvernoteIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c3" size:size]; }
+ (instancetype)socialFacebookIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c4" size:size]; }
+ (instancetype)socialFlickrIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c5" size:size]; }
+ (instancetype)socialForrstIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c6" size:size]; }
+ (instancetype)socialFoursquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c7" size:size]; }
+ (instancetype)socialGameCenterIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c8" size:size]; }
+ (instancetype)socialGithubIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c9" size:size]; }
+ (instancetype)socialGooglePlusIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ca" size:size]; }
+ (instancetype)socialHackerNewsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1cb" size:size]; }
+ (instancetype)socialHi5IconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1cc" size:size]; }
+ (instancetype)socialInstagramIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1cd" size:size]; }
+ (instancetype)socialJoomlaIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ce" size:size]; }
+ (instancetype)socialLastfmIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1cf" size:size]; }
+ (instancetype)socialLinkedinIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d0" size:size]; }
+ (instancetype)socialMediumIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d1" size:size]; }
+ (instancetype)socialMyspaceIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d2" size:size]; }
+ (instancetype)socialOrkutIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d3" size:size]; }
+ (instancetype)socialPathIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d4" size:size]; }
+ (instancetype)socialPicasaIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d5" size:size]; }
+ (instancetype)socialPinterestIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d6" size:size]; }
+ (instancetype)socialRdioIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d7" size:size]; }
+ (instancetype)socialRedditIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d8" size:size]; }
+ (instancetype)socialSkillshareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d9" size:size]; }
+ (instancetype)socialSkypeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1da" size:size]; }
+ (instancetype)socialSmashingMagIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1db" size:size]; }
+ (instancetype)socialSnapchatIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1dc" size:size]; }
+ (instancetype)socialSpotifyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1dd" size:size]; }
+ (instancetype)socialSquidooIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1de" size:size]; }
+ (instancetype)socialStackOverflowIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1df" size:size]; }
+ (instancetype)socialSteamIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e0" size:size]; }
+ (instancetype)socialStumbleuponIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e1" size:size]; }
+ (instancetype)socialTreehouseIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e2" size:size]; }
+ (instancetype)socialTumblrIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e3" size:size]; }
+ (instancetype)socialTwitterIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e4" size:size]; }
+ (instancetype)socialVimeoIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e5" size:size]; }
+ (instancetype)socialWindowsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e6" size:size]; }
+ (instancetype)socialXboxIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e7" size:size]; }
+ (instancetype)socialYahooIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e8" size:size]; }
+ (instancetype)socialYelpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e9" size:size]; }
+ (instancetype)socialYoutubeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ea" size:size]; }
+ (instancetype)socialZerplyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1eb" size:size]; }
+ (instancetype)socialZurbIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ec" size:size]; }
+ (instancetype)soundIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ed" size:size]; }
+ (instancetype)starIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ee" size:size]; }
+ (instancetype)stopIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ef" size:size]; }
+ (instancetype)strikethroughIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f0" size:size]; }
+ (instancetype)subscriptIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f1" size:size]; }
+ (instancetype)superscriptIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f2" size:size]; }
+ (instancetype)tabletLandscapeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f3" size:size]; }
+ (instancetype)tabletPortraitIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f4" size:size]; }
+ (instancetype)targetTwoIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f5" size:size]; }
+ (instancetype)targetIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f6" size:size]; }
+ (instancetype)telephoneAccessibleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f7" size:size]; }
+ (instancetype)telephoneIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f8" size:size]; }
+ (instancetype)textColorIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f9" size:size]; }
+ (instancetype)thumbnailsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1fa" size:size]; }
+ (instancetype)ticketIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1fb" size:size]; }
+ (instancetype)torsoBusinessIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1fc" size:size]; }
+ (instancetype)torsoFemaleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1fd" size:size]; }
+ (instancetype)torsoIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1fe" size:size]; }
+ (instancetype)torsosAllFemaleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ff" size:size]; }
+ (instancetype)torsosAllIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf200" size:size]; }
+ (instancetype)torsosFemaleMaleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf201" size:size]; }
+ (instancetype)torsosMaleFemaleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf202" size:size]; }
+ (instancetype)torsosIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf203" size:size]; }
+ (instancetype)trashIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf204" size:size]; }
+ (instancetype)treesIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf205" size:size]; }
+ (instancetype)trophyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf206" size:size]; }
+ (instancetype)underlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf207" size:size]; }
+ (instancetype)universalAccessIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf208" size:size]; }
+ (instancetype)unlinkIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf209" size:size]; }
+ (instancetype)unlockIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf20a" size:size]; }
+ (instancetype)uploadCloudIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf20b" size:size]; }
+ (instancetype)uploadIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf20c" size:size]; }
+ (instancetype)usbIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf20d" size:size]; }
+ (instancetype)videoIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf20e" size:size]; }
+ (instancetype)volumeNoneIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf20f" size:size]; }
+ (instancetype)volumeStrikeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf210" size:size]; }
+ (instancetype)volumeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf211" size:size]; }
+ (instancetype)webIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf212" size:size]; }
+ (instancetype)wheelchairIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf213" size:size]; }
+ (instancetype)widgetIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf214" size:size]; }
+ (instancetype)wrenchIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf215" size:size]; }
+ (instancetype)xCircleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf216" size:size]; }
+ (instancetype)xIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf217" size:size]; }
+ (instancetype)yenIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf218" size:size]; }
+ (instancetype)zoomInIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf219" size:size]; }
+ (instancetype)zoomOutIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf21a" size:size]; }

+ (NSDictionary *)allIcons {
    return @{
             @"\uf100" : @"addressBook",
             @"\uf101" : @"alert",
             @"\uf102" : @"alignCenter",
             @"\uf103" : @"alignJustify",
             @"\uf104" : @"alignLeft",
             @"\uf105" : @"alignRight",
             @"\uf106" : @"anchor",
             @"\uf107" : @"annotate",
             @"\uf108" : @"archive",
             @"\uf109" : @"arrowDown",
             @"\uf10a" : @"arrowLeft",
             @"\uf10b" : @"arrowRight",
             @"\uf10c" : @"arrowUp",
             @"\uf10d" : @"arrowsCompress",
             @"\uf10e" : @"arrowsExpand",
             @"\uf10f" : @"arrowsIn",
             @"\uf110" : @"arrowsOut",
             @"\uf111" : @"asl",
             @"\uf112" : @"asterisk",
             @"\uf113" : @"atSign",
             @"\uf114" : @"backgroundColor",
             @"\uf115" : @"batteryEmpty",
             @"\uf116" : @"batteryFull",
             @"\uf117" : @"batteryHalf",
             @"\uf118" : @"bitcoinCircle",
             @"\uf119" : @"bitcoin",
             @"\uf11a" : @"blind",
             @"\uf11b" : @"bluetooth",
             @"\uf11c" : @"bold",
             @"\uf11d" : @"bookBookmark",
             @"\uf11e" : @"book",
             @"\uf11f" : @"bookmark",
             @"\uf120" : @"braille",
             @"\uf121" : @"burstNew",
             @"\uf122" : @"burstSale",
             @"\uf123" : @"burst",
             @"\uf124" : @"calendar",
             @"\uf125" : @"camera",
             @"\uf126" : @"check",
             @"\uf127" : @"checkbox",
             @"\uf128" : @"clipboardNotes",
             @"\uf129" : @"clipboardPencil",
             @"\uf12a" : @"clipboard",
             @"\uf12b" : @"clock",
             @"\uf12c" : @"closedCaption",
             @"\uf12d" : @"cloud",
             @"\uf12e" : @"commentMinus",
             @"\uf12f" : @"commentQuotes",
             @"\uf130" : @"commentVideo",
             @"\uf131" : @"comment",
             @"\uf132" : @"comments",
             @"\uf133" : @"compass",
             @"\uf134" : @"contrast",
             @"\uf135" : @"creditCard",
             @"\uf136" : @"crop",
             @"\uf137" : @"crown",
             @"\uf138" : @"css3",
             @"\uf139" : @"database",
             @"\uf13a" : @"dieFive",
             @"\uf13b" : @"dieFour",
             @"\uf13c" : @"dieOne",
             @"\uf13d" : @"dieSix",
             @"\uf13e" : @"dieThree",
             @"\uf13f" : @"dieTwo",
             @"\uf140" : @"dislike",
             @"\uf141" : @"dollarBill",
             @"\uf142" : @"dollar",
             @"\uf143" : @"download",
             @"\uf144" : @"eject",
             @"\uf145" : @"elevator",
             @"\uf146" : @"euro",
             @"\uf147" : @"eye",
             @"\uf148" : @"fastForward",
             @"\uf149" : @"femaleSymbol",
             @"\uf14a" : @"female",
             @"\uf14b" : @"filter",
             @"\uf14c" : @"firstAid",
             @"\uf14d" : @"flag",
             @"\uf14e" : @"folderAdd",
             @"\uf14f" : @"folderLock",
             @"\uf150" : @"folder",
             @"\uf151" : @"foot",
             @"\uf152" : @"foundation",
             @"\uf153" : @"graphBar",
             @"\uf154" : @"graphHorizontal",
             @"\uf155" : @"graphPie",
             @"\uf156" : @"graphTrend",
             @"\uf157" : @"guideDog",
             @"\uf158" : @"hearingAid",
             @"\uf159" : @"heart",
             @"\uf15a" : @"home",
             @"\uf15b" : @"html5",
             @"\uf15c" : @"indentLess",
             @"\uf15d" : @"indentMore",
             @"\uf15e" : @"info",
             @"\uf15f" : @"italic",
             @"\uf160" : @"key",
             @"\uf161" : @"laptop",
             @"\uf162" : @"layout",
             @"\uf163" : @"lightbulb",
             @"\uf164" : @"like",
             @"\uf165" : @"link",
             @"\uf166" : @"listBullet",
             @"\uf167" : @"listNumber",
             @"\uf168" : @"listThumbnails",
             @"\uf169" : @"list",
             @"\uf16a" : @"lock",
             @"\uf16b" : @"loop",
             @"\uf16c" : @"magnifyingGlass",
             @"\uf16d" : @"mail",
             @"\uf16e" : @"maleFemale",
             @"\uf16f" : @"maleSymbol",
             @"\uf170" : @"male",
             @"\uf171" : @"map",
             @"\uf172" : @"marker",
             @"\uf173" : @"megaphone",
             @"\uf174" : @"microphone",
             @"\uf175" : @"minusCircle",
             @"\uf176" : @"minus",
             @"\uf177" : @"mobileSignal",
             @"\uf178" : @"mobile",
             @"\uf179" : @"monitor",
             @"\uf17a" : @"mountains",
             @"\uf17b" : @"music",
             @"\uf17c" : @"next",
             @"\uf17d" : @"noDogs",
             @"\uf17e" : @"noSmoking",
             @"\uf17f" : @"pageAdd",
             @"\uf180" : @"pageCopy",
             @"\uf181" : @"pageCsv",
             @"\uf182" : @"pageDelete",
             @"\uf183" : @"pageDoc",
             @"\uf184" : @"pageEdit",
             @"\uf185" : @"pageExportCsv",
             @"\uf186" : @"pageExportDoc",
             @"\uf187" : @"pageExportPdf",
             @"\uf188" : @"pageExport",
             @"\uf189" : @"pageFilled",
             @"\uf18a" : @"pageMultiple",
             @"\uf18b" : @"pagePdf",
             @"\uf18c" : @"pageRemove",
             @"\uf18d" : @"pageSearch",
             @"\uf18e" : @"page",
             @"\uf18f" : @"paintBucket",
             @"\uf190" : @"paperclip",
             @"\uf191" : @"pause",
             @"\uf192" : @"paw",
             @"\uf193" : @"paypal",
             @"\uf194" : @"pencil",
             @"\uf195" : @"photo",
             @"\uf196" : @"playCircle",
             @"\uf197" : @"playVideo",
             @"\uf198" : @"play",
             @"\uf199" : @"plus",
             @"\uf19a" : @"pound",
             @"\uf19b" : @"power",
             @"\uf19c" : @"previous",
             @"\uf19d" : @"priceTag",
             @"\uf19e" : @"pricetagMultiple",
             @"\uf19f" : @"print",
             @"\uf1a0" : @"prohibited",
             @"\uf1a1" : @"projectionScreen",
             @"\uf1a2" : @"puzzle",
             @"\uf1a3" : @"quote",
             @"\uf1a4" : @"record",
             @"\uf1a5" : @"refresh",
             @"\uf1a6" : @"resultsDemographics",
             @"\uf1a7" : @"results",
             @"\uf1a8" : @"rewindTen",
             @"\uf1a9" : @"rewind",
             @"\uf1aa" : @"rss",
             @"\uf1ab" : @"safetyCone",
             @"\uf1ac" : @"save",
             @"\uf1ad" : @"share",
             @"\uf1ae" : @"sheriffBadge",
             @"\uf1af" : @"shield",
             @"\uf1b0" : @"shoppingBag",
             @"\uf1b1" : @"shoppingCart",
             @"\uf1b2" : @"shuffle",
             @"\uf1b3" : @"skull",
             @"\uf1b4" : @"social500px",
             @"\uf1b5" : @"socialAdobe",
             @"\uf1b6" : @"socialAmazon",
             @"\uf1b7" : @"socialAndroid",
             @"\uf1b8" : @"socialApple",
             @"\uf1b9" : @"socialBehance",
             @"\uf1ba" : @"socialBing",
             @"\uf1bb" : @"socialBlogger",
             @"\uf1bc" : @"socialDelicious",
             @"\uf1bd" : @"socialDesignerNews",
             @"\uf1be" : @"socialDeviantArt",
             @"\uf1bf" : @"socialDigg",
             @"\uf1c0" : @"socialDribbble",
             @"\uf1c1" : @"socialDrive",
             @"\uf1c2" : @"socialDropbox",
             @"\uf1c3" : @"socialEvernote",
             @"\uf1c4" : @"socialFacebook",
             @"\uf1c5" : @"socialFlickr",
             @"\uf1c6" : @"socialForrst",
             @"\uf1c7" : @"socialFoursquare",
             @"\uf1c8" : @"socialGameCenter",
             @"\uf1c9" : @"socialGithub",
             @"\uf1ca" : @"socialGooglePlus",
             @"\uf1cb" : @"socialHackerNews",
             @"\uf1cc" : @"socialHi5",
             @"\uf1cd" : @"socialInstagram",
             @"\uf1ce" : @"socialJoomla",
             @"\uf1cf" : @"socialLastfm",
             @"\uf1d0" : @"socialLinkedin",
             @"\uf1d1" : @"socialMedium",
             @"\uf1d2" : @"socialMyspace",
             @"\uf1d3" : @"socialOrkut",
             @"\uf1d4" : @"socialPath",
             @"\uf1d5" : @"socialPicasa",
             @"\uf1d6" : @"socialPinterest",
             @"\uf1d7" : @"socialRdio",
             @"\uf1d8" : @"socialReddit",
             @"\uf1d9" : @"socialSkillshare",
             @"\uf1da" : @"socialSkype",
             @"\uf1db" : @"socialSmashingMag",
             @"\uf1dc" : @"socialSnapchat",
             @"\uf1dd" : @"socialSpotify",
             @"\uf1de" : @"socialSquidoo",
             @"\uf1df" : @"socialStackOverflow",
             @"\uf1e0" : @"socialSteam",
             @"\uf1e1" : @"socialStumbleupon",
             @"\uf1e2" : @"socialTreehouse",
             @"\uf1e3" : @"socialTumblr",
             @"\uf1e4" : @"socialTwitter",
             @"\uf1e5" : @"socialVimeo",
             @"\uf1e6" : @"socialWindows",
             @"\uf1e7" : @"socialXbox",
             @"\uf1e8" : @"socialYahoo",
             @"\uf1e9" : @"socialYelp",
             @"\uf1ea" : @"socialYoutube",
             @"\uf1eb" : @"socialZerply",
             @"\uf1ec" : @"socialZurb",
             @"\uf1ed" : @"sound",
             @"\uf1ee" : @"star",
             @"\uf1ef" : @"stop",
             @"\uf1f0" : @"strikethrough",
             @"\uf1f1" : @"subscript",
             @"\uf1f2" : @"superscript",
             @"\uf1f3" : @"tabletLandscape",
             @"\uf1f4" : @"tabletPortrait",
             @"\uf1f5" : @"targetTwo",
             @"\uf1f6" : @"target",
             @"\uf1f7" : @"telephoneAccessible",
             @"\uf1f8" : @"telephone",
             @"\uf1f9" : @"textColor",
             @"\uf1fa" : @"thumbnails",
             @"\uf1fb" : @"ticket",
             @"\uf1fc" : @"torsoBusiness",
             @"\uf1fd" : @"torsoFemale",
             @"\uf1fe" : @"torso",
             @"\uf1ff" : @"torsosAllFemale",
             @"\uf200" : @"torsosAll",
             @"\uf201" : @"torsosFemaleMale",
             @"\uf202" : @"torsosMaleFemale",
             @"\uf203" : @"torsos",
             @"\uf204" : @"trash",
             @"\uf205" : @"trees",
             @"\uf206" : @"trophy",
             @"\uf207" : @"underline",
             @"\uf208" : @"universalAccess",
             @"\uf209" : @"unlink",
             @"\uf20a" : @"unlock",
             @"\uf20b" : @"uploadCloud",
             @"\uf20c" : @"upload",
             @"\uf20d" : @"usb",
             @"\uf20e" : @"video",
             @"\uf20f" : @"volumeNone",
             @"\uf210" : @"volumeStrike",
             @"\uf211" : @"volume",
             @"\uf212" : @"web",
             @"\uf213" : @"wheelchair",
             @"\uf214" : @"widget",
             @"\uf215" : @"wrench",
             @"\uf216" : @"xCircle",
             @"\uf217" : @"x",
             @"\uf218" : @"yen",
             @"\uf219" : @"zoomIn",
             @"\uf21a" : @"zoomOut",
             
             };
}


@end
