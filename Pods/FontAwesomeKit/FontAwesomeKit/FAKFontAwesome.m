#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FAKFontAwesome.h"

@implementation FAKFontAwesome

+ (UIFont *)iconFontWithSize:(CGFloat)size
{
#ifndef DISABLE_FONTAWESOME_AUTO_REGISTRATION
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self registerIconFontWithURL:[[NSBundle mainBundle] URLForResource:@"FontAwesome" withExtension:@"otf"]];
    });
#endif
    
    UIFont *font = [UIFont fontWithName:@"FontAwesome" size:size];
    NSAssert(font, @"UIFont object should not be nil, check if the font file is added to the application bundle and you're using the correct font name.");
    return font;
}

// Generated Code
+ (instancetype)adjustIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf042" size:size]; }
+ (instancetype)adnIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf170" size:size]; }
+ (instancetype)alignCenterIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf037" size:size]; }
+ (instancetype)alignJustifyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf039" size:size]; }
+ (instancetype)alignLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf036" size:size]; }
+ (instancetype)alignRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf038" size:size]; }
+ (instancetype)ambulanceIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0f9" size:size]; }
+ (instancetype)anchorIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf13d" size:size]; }
+ (instancetype)androidIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf17b" size:size]; }
+ (instancetype)angellistIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf209" size:size]; }
+ (instancetype)angleDoubleDownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf103" size:size]; }
+ (instancetype)angleDoubleLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf100" size:size]; }
+ (instancetype)angleDoubleRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf101" size:size]; }
+ (instancetype)angleDoubleUpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf102" size:size]; }
+ (instancetype)angleDownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf107" size:size]; }
+ (instancetype)angleLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf104" size:size]; }
+ (instancetype)angleRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf105" size:size]; }
+ (instancetype)angleUpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf106" size:size]; }
+ (instancetype)appleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf179" size:size]; }
+ (instancetype)archiveIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf187" size:size]; }
+ (instancetype)areaChartIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1fe" size:size]; }
+ (instancetype)arrowCircleDownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0ab" size:size]; }
+ (instancetype)arrowCircleLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0a8" size:size]; }
+ (instancetype)arrowCircleODownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf01a" size:size]; }
+ (instancetype)arrowCircleOLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf190" size:size]; }
+ (instancetype)arrowCircleORightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf18e" size:size]; }
+ (instancetype)arrowCircleOUpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf01b" size:size]; }
+ (instancetype)arrowCircleRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0a9" size:size]; }
+ (instancetype)arrowCircleUpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0aa" size:size]; }
+ (instancetype)arrowDownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf063" size:size]; }
+ (instancetype)arrowLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf060" size:size]; }
+ (instancetype)arrowRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf061" size:size]; }
+ (instancetype)arrowUpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf062" size:size]; }
+ (instancetype)arrowsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf047" size:size]; }
+ (instancetype)arrowsAltIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0b2" size:size]; }
+ (instancetype)arrowsHIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf07e" size:size]; }
+ (instancetype)arrowsVIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf07d" size:size]; }
+ (instancetype)asteriskIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf069" size:size]; }
+ (instancetype)atIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1fa" size:size]; }
+ (instancetype)automobileIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b9" size:size]; }
+ (instancetype)backwardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf04a" size:size]; }
+ (instancetype)banIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf05e" size:size]; }
+ (instancetype)bankIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf19c" size:size]; }
+ (instancetype)barChartIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf080" size:size]; }
+ (instancetype)barChartOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf080" size:size]; }
+ (instancetype)barcodeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf02a" size:size]; }
+ (instancetype)barsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0c9" size:size]; }
+ (instancetype)beerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0fc" size:size]; }
+ (instancetype)behanceIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b4" size:size]; }
+ (instancetype)behanceSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b5" size:size]; }
+ (instancetype)bellIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0f3" size:size]; }
+ (instancetype)bellOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0a2" size:size]; }
+ (instancetype)bellSlashIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f6" size:size]; }
+ (instancetype)bellSlashOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f7" size:size]; }
+ (instancetype)bicycleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf206" size:size]; }
+ (instancetype)binocularsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e5" size:size]; }
+ (instancetype)birthdayCakeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1fd" size:size]; }
+ (instancetype)bitbucketIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf171" size:size]; }
+ (instancetype)bitbucketSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf172" size:size]; }
+ (instancetype)bitcoinIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf15a" size:size]; }
+ (instancetype)boldIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf032" size:size]; }
+ (instancetype)boltIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0e7" size:size]; }
+ (instancetype)bombIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e2" size:size]; }
+ (instancetype)bookIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf02d" size:size]; }
+ (instancetype)bookmarkIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf02e" size:size]; }
+ (instancetype)bookmarkOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf097" size:size]; }
+ (instancetype)briefcaseIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0b1" size:size]; }
+ (instancetype)btcIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf15a" size:size]; }
+ (instancetype)bugIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf188" size:size]; }
+ (instancetype)buildingIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ad" size:size]; }
+ (instancetype)buildingOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0f7" size:size]; }
+ (instancetype)bullhornIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0a1" size:size]; }
+ (instancetype)bullseyeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf140" size:size]; }
+ (instancetype)busIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf207" size:size]; }
+ (instancetype)cabIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ba" size:size]; }
+ (instancetype)calculatorIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ec" size:size]; }
+ (instancetype)calendarIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf073" size:size]; }
+ (instancetype)calendarOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf133" size:size]; }
+ (instancetype)cameraIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf030" size:size]; }
+ (instancetype)cameraRetroIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf083" size:size]; }
+ (instancetype)carIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b9" size:size]; }
+ (instancetype)caretDownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0d7" size:size]; }
+ (instancetype)caretLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0d9" size:size]; }
+ (instancetype)caretRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0da" size:size]; }
+ (instancetype)caretSquareODownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf150" size:size]; }
+ (instancetype)caretSquareOLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf191" size:size]; }
+ (instancetype)caretSquareORightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf152" size:size]; }
+ (instancetype)caretSquareOUpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf151" size:size]; }
+ (instancetype)caretUpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0d8" size:size]; }
+ (instancetype)ccIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf20a" size:size]; }
+ (instancetype)ccAmexIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f3" size:size]; }
+ (instancetype)ccDiscoverIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f2" size:size]; }
+ (instancetype)ccMastercardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f1" size:size]; }
+ (instancetype)ccPaypalIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f4" size:size]; }
+ (instancetype)ccStripeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f5" size:size]; }
+ (instancetype)ccVisaIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f0" size:size]; }
+ (instancetype)certificateIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0a3" size:size]; }
+ (instancetype)chainIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0c1" size:size]; }
+ (instancetype)chainBrokenIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf127" size:size]; }
+ (instancetype)checkIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf00c" size:size]; }
+ (instancetype)checkCircleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf058" size:size]; }
+ (instancetype)checkCircleOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf05d" size:size]; }
+ (instancetype)checkSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf14a" size:size]; }
+ (instancetype)checkSquareOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf046" size:size]; }
+ (instancetype)chevronCircleDownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf13a" size:size]; }
+ (instancetype)chevronCircleLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf137" size:size]; }
+ (instancetype)chevronCircleRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf138" size:size]; }
+ (instancetype)chevronCircleUpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf139" size:size]; }
+ (instancetype)chevronDownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf078" size:size]; }
+ (instancetype)chevronLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf053" size:size]; }
+ (instancetype)chevronRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf054" size:size]; }
+ (instancetype)chevronUpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf077" size:size]; }
+ (instancetype)childIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ae" size:size]; }
+ (instancetype)circleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf111" size:size]; }
+ (instancetype)circleOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf10c" size:size]; }
+ (instancetype)circleONotchIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ce" size:size]; }
+ (instancetype)circleThinIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1db" size:size]; }
+ (instancetype)clipboardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0ea" size:size]; }
+ (instancetype)clockOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf017" size:size]; }
+ (instancetype)closeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf00d" size:size]; }
+ (instancetype)cloudIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0c2" size:size]; }
+ (instancetype)cloudDownloadIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0ed" size:size]; }
+ (instancetype)cloudUploadIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0ee" size:size]; }
+ (instancetype)cnyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf157" size:size]; }
+ (instancetype)codeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf121" size:size]; }
+ (instancetype)codeForkIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf126" size:size]; }
+ (instancetype)codepenIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1cb" size:size]; }
+ (instancetype)coffeeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0f4" size:size]; }
+ (instancetype)cogIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf013" size:size]; }
+ (instancetype)cogsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf085" size:size]; }
+ (instancetype)columnsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0db" size:size]; }
+ (instancetype)commentIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf075" size:size]; }
+ (instancetype)commentOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0e5" size:size]; }
+ (instancetype)commentsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf086" size:size]; }
+ (instancetype)commentsOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0e6" size:size]; }
+ (instancetype)compassIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf14e" size:size]; }
+ (instancetype)compressIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf066" size:size]; }
+ (instancetype)copyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0c5" size:size]; }
+ (instancetype)copyrightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f9" size:size]; }
+ (instancetype)creditCardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf09d" size:size]; }
+ (instancetype)cropIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf125" size:size]; }
+ (instancetype)crosshairsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf05b" size:size]; }
+ (instancetype)css3IconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf13c" size:size]; }
+ (instancetype)cubeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b2" size:size]; }
+ (instancetype)cubesIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b3" size:size]; }
+ (instancetype)cutIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0c4" size:size]; }
+ (instancetype)cutleryIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0f5" size:size]; }
+ (instancetype)dashboardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0e4" size:size]; }
+ (instancetype)databaseIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c0" size:size]; }
+ (instancetype)dedentIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf03b" size:size]; }
+ (instancetype)deliciousIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a5" size:size]; }
+ (instancetype)desktopIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf108" size:size]; }
+ (instancetype)deviantartIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1bd" size:size]; }
+ (instancetype)diggIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a6" size:size]; }
+ (instancetype)dollarIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf155" size:size]; }
+ (instancetype)dotCircleOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf192" size:size]; }
+ (instancetype)downloadIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf019" size:size]; }
+ (instancetype)dribbbleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf17d" size:size]; }
+ (instancetype)dropboxIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf16b" size:size]; }
+ (instancetype)drupalIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a9" size:size]; }
+ (instancetype)editIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf044" size:size]; }
+ (instancetype)ejectIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf052" size:size]; }
+ (instancetype)ellipsisHIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf141" size:size]; }
+ (instancetype)ellipsisVIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf142" size:size]; }
+ (instancetype)empireIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d1" size:size]; }
+ (instancetype)envelopeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0e0" size:size]; }
+ (instancetype)envelopeOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf003" size:size]; }
+ (instancetype)envelopeSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf199" size:size]; }
+ (instancetype)eraserIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf12d" size:size]; }
+ (instancetype)eurIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf153" size:size]; }
+ (instancetype)euroIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf153" size:size]; }
+ (instancetype)exchangeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0ec" size:size]; }
+ (instancetype)exclamationIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf12a" size:size]; }
+ (instancetype)exclamationCircleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf06a" size:size]; }
+ (instancetype)exclamationTriangleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf071" size:size]; }
+ (instancetype)expandIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf065" size:size]; }
+ (instancetype)externalLinkIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf08e" size:size]; }
+ (instancetype)externalLinkSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf14c" size:size]; }
+ (instancetype)eyeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf06e" size:size]; }
+ (instancetype)eyeSlashIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf070" size:size]; }
+ (instancetype)eyedropperIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1fb" size:size]; }
+ (instancetype)facebookIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf09a" size:size]; }
+ (instancetype)facebookSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf082" size:size]; }
+ (instancetype)fastBackwardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf049" size:size]; }
+ (instancetype)fastForwardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf050" size:size]; }
+ (instancetype)faxIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ac" size:size]; }
+ (instancetype)femaleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf182" size:size]; }
+ (instancetype)fighterJetIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0fb" size:size]; }
+ (instancetype)fileIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf15b" size:size]; }
+ (instancetype)fileArchiveOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c6" size:size]; }
+ (instancetype)fileAudioOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c7" size:size]; }
+ (instancetype)fileCodeOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c9" size:size]; }
+ (instancetype)fileExcelOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c3" size:size]; }
+ (instancetype)fileImageOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c5" size:size]; }
+ (instancetype)fileMovieOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c8" size:size]; }
+ (instancetype)fileOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf016" size:size]; }
+ (instancetype)filePdfOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c1" size:size]; }
+ (instancetype)filePhotoOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c5" size:size]; }
+ (instancetype)filePictureOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c5" size:size]; }
+ (instancetype)filePowerpointOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c4" size:size]; }
+ (instancetype)fileSoundOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c7" size:size]; }
+ (instancetype)fileTextIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf15c" size:size]; }
+ (instancetype)fileTextOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0f6" size:size]; }
+ (instancetype)fileVideoOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c8" size:size]; }
+ (instancetype)fileWordOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c2" size:size]; }
+ (instancetype)fileZipOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c6" size:size]; }
+ (instancetype)filesOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0c5" size:size]; }
+ (instancetype)filmIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf008" size:size]; }
+ (instancetype)filterIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0b0" size:size]; }
+ (instancetype)fireIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf06d" size:size]; }
+ (instancetype)fireExtinguisherIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf134" size:size]; }
+ (instancetype)flagIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf024" size:size]; }
+ (instancetype)flagCheckeredIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf11e" size:size]; }
+ (instancetype)flagOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf11d" size:size]; }
+ (instancetype)flashIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0e7" size:size]; }
+ (instancetype)flaskIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0c3" size:size]; }
+ (instancetype)flickrIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf16e" size:size]; }
+ (instancetype)floppyOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0c7" size:size]; }
+ (instancetype)folderIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf07b" size:size]; }
+ (instancetype)folderOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf114" size:size]; }
+ (instancetype)folderOpenIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf07c" size:size]; }
+ (instancetype)folderOpenOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf115" size:size]; }
+ (instancetype)fontIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf031" size:size]; }
+ (instancetype)forwardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf04e" size:size]; }
+ (instancetype)foursquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf180" size:size]; }
+ (instancetype)frownOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf119" size:size]; }
+ (instancetype)futbolOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e3" size:size]; }
+ (instancetype)gamepadIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf11b" size:size]; }
+ (instancetype)gavelIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0e3" size:size]; }
+ (instancetype)gbpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf154" size:size]; }
+ (instancetype)geIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d1" size:size]; }
+ (instancetype)gearIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf013" size:size]; }
+ (instancetype)gearsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf085" size:size]; }
+ (instancetype)giftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf06b" size:size]; }
+ (instancetype)gitIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d3" size:size]; }
+ (instancetype)gitSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d2" size:size]; }
+ (instancetype)githubIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf09b" size:size]; }
+ (instancetype)githubAltIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf113" size:size]; }
+ (instancetype)githubSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf092" size:size]; }
+ (instancetype)gittipIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf184" size:size]; }
+ (instancetype)glassIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf000" size:size]; }
+ (instancetype)globeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0ac" size:size]; }
+ (instancetype)googleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a0" size:size]; }
+ (instancetype)googlePlusIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0d5" size:size]; }
+ (instancetype)googlePlusSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0d4" size:size]; }
+ (instancetype)googleWalletIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ee" size:size]; }
+ (instancetype)graduationCapIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf19d" size:size]; }
+ (instancetype)groupIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0c0" size:size]; }
+ (instancetype)hSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0fd" size:size]; }
+ (instancetype)hackerNewsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d4" size:size]; }
+ (instancetype)handODownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0a7" size:size]; }
+ (instancetype)handOLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0a5" size:size]; }
+ (instancetype)handORightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0a4" size:size]; }
+ (instancetype)handOUpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0a6" size:size]; }
+ (instancetype)hddOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0a0" size:size]; }
+ (instancetype)headerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1dc" size:size]; }
+ (instancetype)headphonesIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf025" size:size]; }
+ (instancetype)heartIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf004" size:size]; }
+ (instancetype)heartOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf08a" size:size]; }
+ (instancetype)historyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1da" size:size]; }
+ (instancetype)homeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf015" size:size]; }
+ (instancetype)hospitalOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0f8" size:size]; }
+ (instancetype)html5IconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf13b" size:size]; }
+ (instancetype)ilsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf20b" size:size]; }
+ (instancetype)imageIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf03e" size:size]; }
+ (instancetype)inboxIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf01c" size:size]; }
+ (instancetype)indentIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf03c" size:size]; }
+ (instancetype)infoIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf129" size:size]; }
+ (instancetype)infoCircleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf05a" size:size]; }
+ (instancetype)inrIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf156" size:size]; }
+ (instancetype)instagramIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf16d" size:size]; }
+ (instancetype)institutionIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf19c" size:size]; }
+ (instancetype)ioxhostIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf208" size:size]; }
+ (instancetype)italicIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf033" size:size]; }
+ (instancetype)joomlaIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1aa" size:size]; }
+ (instancetype)jpyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf157" size:size]; }
+ (instancetype)jsfiddleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1cc" size:size]; }
+ (instancetype)keyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf084" size:size]; }
+ (instancetype)keyboardOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf11c" size:size]; }
+ (instancetype)krwIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf159" size:size]; }
+ (instancetype)languageIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ab" size:size]; }
+ (instancetype)laptopIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf109" size:size]; }
+ (instancetype)lastfmIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf202" size:size]; }
+ (instancetype)lastfmSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf203" size:size]; }
+ (instancetype)leafIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf06c" size:size]; }
+ (instancetype)legalIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0e3" size:size]; }
+ (instancetype)lemonOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf094" size:size]; }
+ (instancetype)levelDownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf149" size:size]; }
+ (instancetype)levelUpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf148" size:size]; }
+ (instancetype)lifeBouyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1cd" size:size]; }
+ (instancetype)lifeBuoyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1cd" size:size]; }
+ (instancetype)lifeRingIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1cd" size:size]; }
+ (instancetype)lifeSaverIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1cd" size:size]; }
+ (instancetype)lightbulbOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0eb" size:size]; }
+ (instancetype)lineChartIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf201" size:size]; }
+ (instancetype)linkIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0c1" size:size]; }
+ (instancetype)linkedinIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0e1" size:size]; }
+ (instancetype)linkedinSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf08c" size:size]; }
+ (instancetype)linuxIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf17c" size:size]; }
+ (instancetype)listIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf03a" size:size]; }
+ (instancetype)listAltIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf022" size:size]; }
+ (instancetype)listOlIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0cb" size:size]; }
+ (instancetype)listUlIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0ca" size:size]; }
+ (instancetype)locationArrowIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf124" size:size]; }
+ (instancetype)lockIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf023" size:size]; }
+ (instancetype)longArrowDownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf175" size:size]; }
+ (instancetype)longArrowLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf177" size:size]; }
+ (instancetype)longArrowRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf178" size:size]; }
+ (instancetype)longArrowUpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf176" size:size]; }
+ (instancetype)magicIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0d0" size:size]; }
+ (instancetype)magnetIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf076" size:size]; }
+ (instancetype)mailForwardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf064" size:size]; }
+ (instancetype)mailReplyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf112" size:size]; }
+ (instancetype)mailReplyAllIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf122" size:size]; }
+ (instancetype)maleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf183" size:size]; }
+ (instancetype)mapMarkerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf041" size:size]; }
+ (instancetype)maxcdnIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf136" size:size]; }
+ (instancetype)meanpathIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf20c" size:size]; }
+ (instancetype)medkitIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0fa" size:size]; }
+ (instancetype)mehOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf11a" size:size]; }
+ (instancetype)microphoneIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf130" size:size]; }
+ (instancetype)microphoneSlashIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf131" size:size]; }
+ (instancetype)minusIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf068" size:size]; }
+ (instancetype)minusCircleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf056" size:size]; }
+ (instancetype)minusSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf146" size:size]; }
+ (instancetype)minusSquareOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf147" size:size]; }
+ (instancetype)mobileIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf10b" size:size]; }
+ (instancetype)mobilePhoneIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf10b" size:size]; }
+ (instancetype)moneyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0d6" size:size]; }
+ (instancetype)moonOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf186" size:size]; }
+ (instancetype)mortarBoardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf19d" size:size]; }
+ (instancetype)musicIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf001" size:size]; }
+ (instancetype)naviconIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0c9" size:size]; }
+ (instancetype)newspaperOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ea" size:size]; }
+ (instancetype)openidIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf19b" size:size]; }
+ (instancetype)outdentIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf03b" size:size]; }
+ (instancetype)pagelinesIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf18c" size:size]; }
+ (instancetype)paintBrushIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1fc" size:size]; }
+ (instancetype)paperPlaneIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d8" size:size]; }
+ (instancetype)paperPlaneOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d9" size:size]; }
+ (instancetype)paperclipIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0c6" size:size]; }
+ (instancetype)paragraphIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1dd" size:size]; }
+ (instancetype)pasteIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0ea" size:size]; }
+ (instancetype)pauseIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf04c" size:size]; }
+ (instancetype)pawIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b0" size:size]; }
+ (instancetype)paypalIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ed" size:size]; }
+ (instancetype)pencilIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf040" size:size]; }
+ (instancetype)pencilSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf14b" size:size]; }
+ (instancetype)pencilSquareOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf044" size:size]; }
+ (instancetype)phoneIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf095" size:size]; }
+ (instancetype)phoneSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf098" size:size]; }
+ (instancetype)photoIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf03e" size:size]; }
+ (instancetype)pictureOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf03e" size:size]; }
+ (instancetype)pieChartIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf200" size:size]; }
+ (instancetype)piedPiperIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a7" size:size]; }
+ (instancetype)piedPiperAltIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a8" size:size]; }
+ (instancetype)pinterestIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0d2" size:size]; }
+ (instancetype)pinterestSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0d3" size:size]; }
+ (instancetype)planeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf072" size:size]; }
+ (instancetype)playIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf04b" size:size]; }
+ (instancetype)playCircleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf144" size:size]; }
+ (instancetype)playCircleOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf01d" size:size]; }
+ (instancetype)plugIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e6" size:size]; }
+ (instancetype)plusIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf067" size:size]; }
+ (instancetype)plusCircleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf055" size:size]; }
+ (instancetype)plusSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0fe" size:size]; }
+ (instancetype)plusSquareOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf196" size:size]; }
+ (instancetype)powerOffIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf011" size:size]; }
+ (instancetype)printIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf02f" size:size]; }
+ (instancetype)puzzlePieceIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf12e" size:size]; }
+ (instancetype)qqIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d6" size:size]; }
+ (instancetype)qrcodeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf029" size:size]; }
+ (instancetype)questionIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf128" size:size]; }
+ (instancetype)questionCircleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf059" size:size]; }
+ (instancetype)quoteLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf10d" size:size]; }
+ (instancetype)quoteRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf10e" size:size]; }
+ (instancetype)raIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d0" size:size]; }
+ (instancetype)randomIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf074" size:size]; }
+ (instancetype)rebelIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d0" size:size]; }
+ (instancetype)recycleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b8" size:size]; }
+ (instancetype)redditIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a1" size:size]; }
+ (instancetype)redditSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a2" size:size]; }
+ (instancetype)refreshIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf021" size:size]; }
+ (instancetype)removeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf00d" size:size]; }
+ (instancetype)renrenIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf18b" size:size]; }
+ (instancetype)reorderIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0c9" size:size]; }
+ (instancetype)repeatIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf01e" size:size]; }
+ (instancetype)replyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf112" size:size]; }
+ (instancetype)replyAllIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf122" size:size]; }
+ (instancetype)retweetIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf079" size:size]; }
+ (instancetype)rmbIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf157" size:size]; }
+ (instancetype)roadIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf018" size:size]; }
+ (instancetype)rocketIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf135" size:size]; }
+ (instancetype)rotateLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0e2" size:size]; }
+ (instancetype)rotateRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf01e" size:size]; }
+ (instancetype)roubleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf158" size:size]; }
+ (instancetype)rssIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf09e" size:size]; }
+ (instancetype)rssSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf143" size:size]; }
+ (instancetype)rubIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf158" size:size]; }
+ (instancetype)rubleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf158" size:size]; }
+ (instancetype)rupeeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf156" size:size]; }
+ (instancetype)saveIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0c7" size:size]; }
+ (instancetype)scissorsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0c4" size:size]; }
+ (instancetype)searchIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf002" size:size]; }
+ (instancetype)searchMinusIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf010" size:size]; }
+ (instancetype)searchPlusIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf00e" size:size]; }
+ (instancetype)sendIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d8" size:size]; }
+ (instancetype)sendOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d9" size:size]; }
+ (instancetype)shareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf064" size:size]; }
+ (instancetype)shareAltIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e0" size:size]; }
+ (instancetype)shareAltSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e1" size:size]; }
+ (instancetype)shareSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf14d" size:size]; }
+ (instancetype)shareSquareOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf045" size:size]; }
+ (instancetype)shekelIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf20b" size:size]; }
+ (instancetype)sheqelIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf20b" size:size]; }
+ (instancetype)shieldIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf132" size:size]; }
+ (instancetype)shoppingCartIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf07a" size:size]; }
+ (instancetype)signInIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf090" size:size]; }
+ (instancetype)signOutIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf08b" size:size]; }
+ (instancetype)signalIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf012" size:size]; }
+ (instancetype)sitemapIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0e8" size:size]; }
+ (instancetype)skypeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf17e" size:size]; }
+ (instancetype)slackIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf198" size:size]; }
+ (instancetype)slidersIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1de" size:size]; }
+ (instancetype)slideshareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e7" size:size]; }
+ (instancetype)smileOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf118" size:size]; }
+ (instancetype)soccerBallOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e3" size:size]; }
+ (instancetype)sortIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0dc" size:size]; }
+ (instancetype)sortAlphaAscIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf15d" size:size]; }
+ (instancetype)sortAlphaDescIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf15e" size:size]; }
+ (instancetype)sortAmountAscIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf160" size:size]; }
+ (instancetype)sortAmountDescIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf161" size:size]; }
+ (instancetype)sortAscIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0de" size:size]; }
+ (instancetype)sortDescIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0dd" size:size]; }
+ (instancetype)sortDownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0dd" size:size]; }
+ (instancetype)sortNumericAscIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf162" size:size]; }
+ (instancetype)sortNumericDescIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf163" size:size]; }
+ (instancetype)sortUpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0de" size:size]; }
+ (instancetype)soundcloudIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1be" size:size]; }
+ (instancetype)spaceShuttleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf197" size:size]; }
+ (instancetype)spinnerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf110" size:size]; }
+ (instancetype)spoonIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b1" size:size]; }
+ (instancetype)spotifyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1bc" size:size]; }
+ (instancetype)squareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0c8" size:size]; }
+ (instancetype)squareOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf096" size:size]; }
+ (instancetype)stackExchangeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf18d" size:size]; }
+ (instancetype)stackOverflowIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf16c" size:size]; }
+ (instancetype)starIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf005" size:size]; }
+ (instancetype)starHalfIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf089" size:size]; }
+ (instancetype)starHalfEmptyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf123" size:size]; }
+ (instancetype)starHalfFullIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf123" size:size]; }
+ (instancetype)starHalfOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf123" size:size]; }
+ (instancetype)starOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf006" size:size]; }
+ (instancetype)steamIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b6" size:size]; }
+ (instancetype)steamSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b7" size:size]; }
+ (instancetype)stepBackwardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf048" size:size]; }
+ (instancetype)stepForwardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf051" size:size]; }
+ (instancetype)stethoscopeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0f1" size:size]; }
+ (instancetype)stopIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf04d" size:size]; }
+ (instancetype)strikethroughIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0cc" size:size]; }
+ (instancetype)stumbleuponIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a4" size:size]; }
+ (instancetype)stumbleuponCircleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a3" size:size]; }
+ (instancetype)subscriptIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf12c" size:size]; }
+ (instancetype)suitcaseIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0f2" size:size]; }
+ (instancetype)sunOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf185" size:size]; }
+ (instancetype)superscriptIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf12b" size:size]; }
+ (instancetype)supportIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1cd" size:size]; }
+ (instancetype)tableIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0ce" size:size]; }
+ (instancetype)tabletIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf10a" size:size]; }
+ (instancetype)tachometerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0e4" size:size]; }
+ (instancetype)tagIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf02b" size:size]; }
+ (instancetype)tagsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf02c" size:size]; }
+ (instancetype)tasksIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0ae" size:size]; }
+ (instancetype)taxiIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ba" size:size]; }
+ (instancetype)tencentWeiboIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d5" size:size]; }
+ (instancetype)terminalIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf120" size:size]; }
+ (instancetype)textHeightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf034" size:size]; }
+ (instancetype)textWidthIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf035" size:size]; }
+ (instancetype)thIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf00a" size:size]; }
+ (instancetype)thLargeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf009" size:size]; }
+ (instancetype)thListIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf00b" size:size]; }
+ (instancetype)thumbTackIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf08d" size:size]; }
+ (instancetype)thumbsDownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf165" size:size]; }
+ (instancetype)thumbsODownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf088" size:size]; }
+ (instancetype)thumbsOUpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf087" size:size]; }
+ (instancetype)thumbsUpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf164" size:size]; }
+ (instancetype)ticketIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf145" size:size]; }
+ (instancetype)timesIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf00d" size:size]; }
+ (instancetype)timesCircleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf057" size:size]; }
+ (instancetype)timesCircleOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf05c" size:size]; }
+ (instancetype)tintIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf043" size:size]; }
+ (instancetype)toggleDownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf150" size:size]; }
+ (instancetype)toggleLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf191" size:size]; }
+ (instancetype)toggleOffIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf204" size:size]; }
+ (instancetype)toggleOnIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf205" size:size]; }
+ (instancetype)toggleRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf152" size:size]; }
+ (instancetype)toggleUpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf151" size:size]; }
+ (instancetype)trashIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f8" size:size]; }
+ (instancetype)trashOIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf014" size:size]; }
+ (instancetype)treeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1bb" size:size]; }
+ (instancetype)trelloIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf181" size:size]; }
+ (instancetype)trophyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf091" size:size]; }
+ (instancetype)truckIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0d1" size:size]; }
+ (instancetype)tryIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf195" size:size]; }
+ (instancetype)ttyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e4" size:size]; }
+ (instancetype)tumblrIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf173" size:size]; }
+ (instancetype)tumblrSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf174" size:size]; }
+ (instancetype)turkishLiraIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf195" size:size]; }
+ (instancetype)twitchIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e8" size:size]; }
+ (instancetype)twitterIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf099" size:size]; }
+ (instancetype)twitterSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf081" size:size]; }
+ (instancetype)umbrellaIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0e9" size:size]; }
+ (instancetype)underlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0cd" size:size]; }
+ (instancetype)undoIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0e2" size:size]; }
+ (instancetype)universityIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf19c" size:size]; }
+ (instancetype)unlinkIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf127" size:size]; }
+ (instancetype)unlockIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf09c" size:size]; }
+ (instancetype)unlockAltIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf13e" size:size]; }
+ (instancetype)unsortedIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0dc" size:size]; }
+ (instancetype)uploadIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf093" size:size]; }
+ (instancetype)usdIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf155" size:size]; }
+ (instancetype)userIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf007" size:size]; }
+ (instancetype)userMdIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0f0" size:size]; }
+ (instancetype)usersIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0c0" size:size]; }
+ (instancetype)videoCameraIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf03d" size:size]; }
+ (instancetype)vimeoSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf194" size:size]; }
+ (instancetype)vineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ca" size:size]; }
+ (instancetype)vkIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf189" size:size]; }
+ (instancetype)volumeDownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf027" size:size]; }
+ (instancetype)volumeOffIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf026" size:size]; }
+ (instancetype)volumeUpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf028" size:size]; }
+ (instancetype)warningIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf071" size:size]; }
+ (instancetype)wechatIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d7" size:size]; }
+ (instancetype)weiboIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf18a" size:size]; }
+ (instancetype)weixinIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d7" size:size]; }
+ (instancetype)wheelchairIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf193" size:size]; }
+ (instancetype)wifiIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1eb" size:size]; }
+ (instancetype)windowsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf17a" size:size]; }
+ (instancetype)wonIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf159" size:size]; }
+ (instancetype)wordpressIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf19a" size:size]; }
+ (instancetype)wrenchIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf0ad" size:size]; }
+ (instancetype)xingIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf168" size:size]; }
+ (instancetype)xingSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf169" size:size]; }
+ (instancetype)yahooIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf19e" size:size]; }
+ (instancetype)yelpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e9" size:size]; }
+ (instancetype)yenIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf157" size:size]; }
+ (instancetype)youtubeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf167" size:size]; }
+ (instancetype)youtubePlayIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf16a" size:size]; }
+ (instancetype)youtubeSquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf166" size:size]; }

+ (NSDictionary *)allIcons {
    return @{
             @"\uf042" : @"adjust",
             @"\uf170" : @"adn",
             @"\uf037" : @"alignCenter",
             @"\uf039" : @"alignJustify",
             @"\uf036" : @"alignLeft",
             @"\uf038" : @"alignRight",
             @"\uf0f9" : @"ambulance",
             @"\uf13d" : @"anchor",
             @"\uf17b" : @"android",
             @"\uf209" : @"angellist",
             @"\uf103" : @"angleDoubleDown",
             @"\uf100" : @"angleDoubleLeft",
             @"\uf101" : @"angleDoubleRight",
             @"\uf102" : @"angleDoubleUp",
             @"\uf107" : @"angleDown",
             @"\uf104" : @"angleLeft",
             @"\uf105" : @"angleRight",
             @"\uf106" : @"angleUp",
             @"\uf179" : @"apple",
             @"\uf187" : @"archive",
             @"\uf1fe" : @"areaChart",
             @"\uf0ab" : @"arrowCircleDown",
             @"\uf0a8" : @"arrowCircleLeft",
             @"\uf01a" : @"arrowCircleODown",
             @"\uf190" : @"arrowCircleOLeft",
             @"\uf18e" : @"arrowCircleORight",
             @"\uf01b" : @"arrowCircleOUp",
             @"\uf0a9" : @"arrowCircleRight",
             @"\uf0aa" : @"arrowCircleUp",
             @"\uf063" : @"arrowDown",
             @"\uf060" : @"arrowLeft",
             @"\uf061" : @"arrowRight",
             @"\uf062" : @"arrowUp",
             @"\uf047" : @"arrows",
             @"\uf0b2" : @"arrowsAlt",
             @"\uf07e" : @"arrowsH",
             @"\uf07d" : @"arrowsV",
             @"\uf069" : @"asterisk",
             @"\uf1fa" : @"at",
             @"\uf1b9" : @"automobile",
             @"\uf04a" : @"backward",
             @"\uf05e" : @"ban",
             @"\uf19c" : @"bank",
             @"\uf080" : @"barChart",
             @"\uf080" : @"barChartO",
             @"\uf02a" : @"barcode",
             @"\uf0c9" : @"bars",
             @"\uf0fc" : @"beer",
             @"\uf1b4" : @"behance",
             @"\uf1b5" : @"behanceSquare",
             @"\uf0f3" : @"bell",
             @"\uf0a2" : @"bellO",
             @"\uf1f6" : @"bellSlash",
             @"\uf1f7" : @"bellSlashO",
             @"\uf206" : @"bicycle",
             @"\uf1e5" : @"binoculars",
             @"\uf1fd" : @"birthdayCake",
             @"\uf171" : @"bitbucket",
             @"\uf172" : @"bitbucketSquare",
             @"\uf15a" : @"bitcoin",
             @"\uf032" : @"bold",
             @"\uf0e7" : @"bolt",
             @"\uf1e2" : @"bomb",
             @"\uf02d" : @"book",
             @"\uf02e" : @"bookmark",
             @"\uf097" : @"bookmarkO",
             @"\uf0b1" : @"briefcase",
             @"\uf15a" : @"btc",
             @"\uf188" : @"bug",
             @"\uf1ad" : @"building",
             @"\uf0f7" : @"buildingO",
             @"\uf0a1" : @"bullhorn",
             @"\uf140" : @"bullseye",
             @"\uf207" : @"bus",
             @"\uf1ba" : @"cab",
             @"\uf1ec" : @"calculator",
             @"\uf073" : @"calendar",
             @"\uf133" : @"calendarO",
             @"\uf030" : @"camera",
             @"\uf083" : @"cameraRetro",
             @"\uf1b9" : @"car",
             @"\uf0d7" : @"caretDown",
             @"\uf0d9" : @"caretLeft",
             @"\uf0da" : @"caretRight",
             @"\uf150" : @"caretSquareODown",
             @"\uf191" : @"caretSquareOLeft",
             @"\uf152" : @"caretSquareORight",
             @"\uf151" : @"caretSquareOUp",
             @"\uf0d8" : @"caretUp",
             @"\uf20a" : @"cc",
             @"\uf1f3" : @"ccAmex",
             @"\uf1f2" : @"ccDiscover",
             @"\uf1f1" : @"ccMastercard",
             @"\uf1f4" : @"ccPaypal",
             @"\uf1f5" : @"ccStripe",
             @"\uf1f0" : @"ccVisa",
             @"\uf0a3" : @"certificate",
             @"\uf0c1" : @"chain",
             @"\uf127" : @"chainBroken",
             @"\uf00c" : @"check",
             @"\uf058" : @"checkCircle",
             @"\uf05d" : @"checkCircleO",
             @"\uf14a" : @"checkSquare",
             @"\uf046" : @"checkSquareO",
             @"\uf13a" : @"chevronCircleDown",
             @"\uf137" : @"chevronCircleLeft",
             @"\uf138" : @"chevronCircleRight",
             @"\uf139" : @"chevronCircleUp",
             @"\uf078" : @"chevronDown",
             @"\uf053" : @"chevronLeft",
             @"\uf054" : @"chevronRight",
             @"\uf077" : @"chevronUp",
             @"\uf1ae" : @"child",
             @"\uf111" : @"circle",
             @"\uf10c" : @"circleO",
             @"\uf1ce" : @"circleONotch",
             @"\uf1db" : @"circleThin",
             @"\uf0ea" : @"clipboard",
             @"\uf017" : @"clockO",
             @"\uf00d" : @"close",
             @"\uf0c2" : @"cloud",
             @"\uf0ed" : @"cloudDownload",
             @"\uf0ee" : @"cloudUpload",
             @"\uf157" : @"cny",
             @"\uf121" : @"code",
             @"\uf126" : @"codeFork",
             @"\uf1cb" : @"codepen",
             @"\uf0f4" : @"coffee",
             @"\uf013" : @"cog",
             @"\uf085" : @"cogs",
             @"\uf0db" : @"columns",
             @"\uf075" : @"comment",
             @"\uf0e5" : @"commentO",
             @"\uf086" : @"comments",
             @"\uf0e6" : @"commentsO",
             @"\uf14e" : @"compass",
             @"\uf066" : @"compress",
             @"\uf0c5" : @"copy",
             @"\uf1f9" : @"copyright",
             @"\uf09d" : @"creditCard",
             @"\uf125" : @"crop",
             @"\uf05b" : @"crosshairs",
             @"\uf13c" : @"css3",
             @"\uf1b2" : @"cube",
             @"\uf1b3" : @"cubes",
             @"\uf0c4" : @"cut",
             @"\uf0f5" : @"cutlery",
             @"\uf0e4" : @"dashboard",
             @"\uf1c0" : @"database",
             @"\uf03b" : @"dedent",
             @"\uf1a5" : @"delicious",
             @"\uf108" : @"desktop",
             @"\uf1bd" : @"deviantart",
             @"\uf1a6" : @"digg",
             @"\uf155" : @"dollar",
             @"\uf192" : @"dotCircleO",
             @"\uf019" : @"download",
             @"\uf17d" : @"dribbble",
             @"\uf16b" : @"dropbox",
             @"\uf1a9" : @"drupal",
             @"\uf044" : @"edit",
             @"\uf052" : @"eject",
             @"\uf141" : @"ellipsisH",
             @"\uf142" : @"ellipsisV",
             @"\uf1d1" : @"empire",
             @"\uf0e0" : @"envelope",
             @"\uf003" : @"envelopeO",
             @"\uf199" : @"envelopeSquare",
             @"\uf12d" : @"eraser",
             @"\uf153" : @"eur",
             @"\uf153" : @"euro",
             @"\uf0ec" : @"exchange",
             @"\uf12a" : @"exclamation",
             @"\uf06a" : @"exclamationCircle",
             @"\uf071" : @"exclamationTriangle",
             @"\uf065" : @"expand",
             @"\uf08e" : @"externalLink",
             @"\uf14c" : @"externalLinkSquare",
             @"\uf06e" : @"eye",
             @"\uf070" : @"eyeSlash",
             @"\uf1fb" : @"eyedropper",
             @"\uf09a" : @"facebook",
             @"\uf082" : @"facebookSquare",
             @"\uf049" : @"fastBackward",
             @"\uf050" : @"fastForward",
             @"\uf1ac" : @"fax",
             @"\uf182" : @"female",
             @"\uf0fb" : @"fighterJet",
             @"\uf15b" : @"file",
             @"\uf1c6" : @"fileArchiveO",
             @"\uf1c7" : @"fileAudioO",
             @"\uf1c9" : @"fileCodeO",
             @"\uf1c3" : @"fileExcelO",
             @"\uf1c5" : @"fileImageO",
             @"\uf1c8" : @"fileMovieO",
             @"\uf016" : @"fileO",
             @"\uf1c1" : @"filePdfO",
             @"\uf1c5" : @"filePhotoO",
             @"\uf1c5" : @"filePictureO",
             @"\uf1c4" : @"filePowerpointO",
             @"\uf1c7" : @"fileSoundO",
             @"\uf15c" : @"fileText",
             @"\uf0f6" : @"fileTextO",
             @"\uf1c8" : @"fileVideoO",
             @"\uf1c2" : @"fileWordO",
             @"\uf1c6" : @"fileZipO",
             @"\uf0c5" : @"filesO",
             @"\uf008" : @"film",
             @"\uf0b0" : @"filter",
             @"\uf06d" : @"fire",
             @"\uf134" : @"fireExtinguisher",
             @"\uf024" : @"flag",
             @"\uf11e" : @"flagCheckered",
             @"\uf11d" : @"flagO",
             @"\uf0e7" : @"flash",
             @"\uf0c3" : @"flask",
             @"\uf16e" : @"flickr",
             @"\uf0c7" : @"floppyO",
             @"\uf07b" : @"folder",
             @"\uf114" : @"folderO",
             @"\uf07c" : @"folderOpen",
             @"\uf115" : @"folderOpenO",
             @"\uf031" : @"font",
             @"\uf04e" : @"forward",
             @"\uf180" : @"foursquare",
             @"\uf119" : @"frownO",
             @"\uf1e3" : @"futbolO",
             @"\uf11b" : @"gamepad",
             @"\uf0e3" : @"gavel",
             @"\uf154" : @"gbp",
             @"\uf1d1" : @"ge",
             @"\uf013" : @"gear",
             @"\uf085" : @"gears",
             @"\uf06b" : @"gift",
             @"\uf1d3" : @"git",
             @"\uf1d2" : @"gitSquare",
             @"\uf09b" : @"github",
             @"\uf113" : @"githubAlt",
             @"\uf092" : @"githubSquare",
             @"\uf184" : @"gittip",
             @"\uf000" : @"glass",
             @"\uf0ac" : @"globe",
             @"\uf1a0" : @"google",
             @"\uf0d5" : @"googlePlus",
             @"\uf0d4" : @"googlePlusSquare",
             @"\uf1ee" : @"googleWallet",
             @"\uf19d" : @"graduationCap",
             @"\uf0c0" : @"group",
             @"\uf0fd" : @"hSquare",
             @"\uf1d4" : @"hackerNews",
             @"\uf0a7" : @"handODown",
             @"\uf0a5" : @"handOLeft",
             @"\uf0a4" : @"handORight",
             @"\uf0a6" : @"handOUp",
             @"\uf0a0" : @"hddO",
             @"\uf1dc" : @"header",
             @"\uf025" : @"headphones",
             @"\uf004" : @"heart",
             @"\uf08a" : @"heartO",
             @"\uf1da" : @"history",
             @"\uf015" : @"home",
             @"\uf0f8" : @"hospitalO",
             @"\uf13b" : @"html5",
             @"\uf20b" : @"ils",
             @"\uf03e" : @"image",
             @"\uf01c" : @"inbox",
             @"\uf03c" : @"indent",
             @"\uf129" : @"info",
             @"\uf05a" : @"infoCircle",
             @"\uf156" : @"inr",
             @"\uf16d" : @"instagram",
             @"\uf19c" : @"institution",
             @"\uf208" : @"ioxhost",
             @"\uf033" : @"italic",
             @"\uf1aa" : @"joomla",
             @"\uf157" : @"jpy",
             @"\uf1cc" : @"jsfiddle",
             @"\uf084" : @"key",
             @"\uf11c" : @"keyboardO",
             @"\uf159" : @"krw",
             @"\uf1ab" : @"language",
             @"\uf109" : @"laptop",
             @"\uf202" : @"lastfm",
             @"\uf203" : @"lastfmSquare",
             @"\uf06c" : @"leaf",
             @"\uf0e3" : @"legal",
             @"\uf094" : @"lemonO",
             @"\uf149" : @"levelDown",
             @"\uf148" : @"levelUp",
             @"\uf1cd" : @"lifeBouy",
             @"\uf1cd" : @"lifeBuoy",
             @"\uf1cd" : @"lifeRing",
             @"\uf1cd" : @"lifeSaver",
             @"\uf0eb" : @"lightbulbO",
             @"\uf201" : @"lineChart",
             @"\uf0c1" : @"link",
             @"\uf0e1" : @"linkedin",
             @"\uf08c" : @"linkedinSquare",
             @"\uf17c" : @"linux",
             @"\uf03a" : @"list",
             @"\uf022" : @"listAlt",
             @"\uf0cb" : @"listOl",
             @"\uf0ca" : @"listUl",
             @"\uf124" : @"locationArrow",
             @"\uf023" : @"lock",
             @"\uf175" : @"longArrowDown",
             @"\uf177" : @"longArrowLeft",
             @"\uf178" : @"longArrowRight",
             @"\uf176" : @"longArrowUp",
             @"\uf0d0" : @"magic",
             @"\uf076" : @"magnet",
             @"\uf064" : @"mailForward",
             @"\uf112" : @"mailReply",
             @"\uf122" : @"mailReplyAll",
             @"\uf183" : @"male",
             @"\uf041" : @"mapMarker",
             @"\uf136" : @"maxcdn",
             @"\uf20c" : @"meanpath",
             @"\uf0fa" : @"medkit",
             @"\uf11a" : @"mehO",
             @"\uf130" : @"microphone",
             @"\uf131" : @"microphoneSlash",
             @"\uf068" : @"minus",
             @"\uf056" : @"minusCircle",
             @"\uf146" : @"minusSquare",
             @"\uf147" : @"minusSquareO",
             @"\uf10b" : @"mobile",
             @"\uf10b" : @"mobilePhone",
             @"\uf0d6" : @"money",
             @"\uf186" : @"moonO",
             @"\uf19d" : @"mortarBoard",
             @"\uf001" : @"music",
             @"\uf0c9" : @"navicon",
             @"\uf1ea" : @"newspaperO",
             @"\uf19b" : @"openid",
             @"\uf03b" : @"outdent",
             @"\uf18c" : @"pagelines",
             @"\uf1fc" : @"paintBrush",
             @"\uf1d8" : @"paperPlane",
             @"\uf1d9" : @"paperPlaneO",
             @"\uf0c6" : @"paperclip",
             @"\uf1dd" : @"paragraph",
             @"\uf0ea" : @"paste",
             @"\uf04c" : @"pause",
             @"\uf1b0" : @"paw",
             @"\uf1ed" : @"paypal",
             @"\uf040" : @"pencil",
             @"\uf14b" : @"pencilSquare",
             @"\uf044" : @"pencilSquareO",
             @"\uf095" : @"phone",
             @"\uf098" : @"phoneSquare",
             @"\uf03e" : @"photo",
             @"\uf03e" : @"pictureO",
             @"\uf200" : @"pieChart",
             @"\uf1a7" : @"piedPiper",
             @"\uf1a8" : @"piedPiperAlt",
             @"\uf0d2" : @"pinterest",
             @"\uf0d3" : @"pinterestSquare",
             @"\uf072" : @"plane",
             @"\uf04b" : @"play",
             @"\uf144" : @"playCircle",
             @"\uf01d" : @"playCircleO",
             @"\uf1e6" : @"plug",
             @"\uf067" : @"plus",
             @"\uf055" : @"plusCircle",
             @"\uf0fe" : @"plusSquare",
             @"\uf196" : @"plusSquareO",
             @"\uf011" : @"powerOff",
             @"\uf02f" : @"print",
             @"\uf12e" : @"puzzlePiece",
             @"\uf1d6" : @"qq",
             @"\uf029" : @"qrcode",
             @"\uf128" : @"question",
             @"\uf059" : @"questionCircle",
             @"\uf10d" : @"quoteLeft",
             @"\uf10e" : @"quoteRight",
             @"\uf1d0" : @"ra",
             @"\uf074" : @"random",
             @"\uf1d0" : @"rebel",
             @"\uf1b8" : @"recycle",
             @"\uf1a1" : @"reddit",
             @"\uf1a2" : @"redditSquare",
             @"\uf021" : @"refresh",
             @"\uf00d" : @"remove",
             @"\uf18b" : @"renren",
             @"\uf0c9" : @"reorder",
             @"\uf01e" : @"repeat",
             @"\uf112" : @"reply",
             @"\uf122" : @"replyAll",
             @"\uf079" : @"retweet",
             @"\uf157" : @"rmb",
             @"\uf018" : @"road",
             @"\uf135" : @"rocket",
             @"\uf0e2" : @"rotateLeft",
             @"\uf01e" : @"rotateRight",
             @"\uf158" : @"rouble",
             @"\uf09e" : @"rss",
             @"\uf143" : @"rssSquare",
             @"\uf158" : @"rub",
             @"\uf158" : @"ruble",
             @"\uf156" : @"rupee",
             @"\uf0c7" : @"save",
             @"\uf0c4" : @"scissors",
             @"\uf002" : @"search",
             @"\uf010" : @"searchMinus",
             @"\uf00e" : @"searchPlus",
             @"\uf1d8" : @"send",
             @"\uf1d9" : @"sendO",
             @"\uf064" : @"share",
             @"\uf1e0" : @"shareAlt",
             @"\uf1e1" : @"shareAltSquare",
             @"\uf14d" : @"shareSquare",
             @"\uf045" : @"shareSquareO",
             @"\uf20b" : @"shekel",
             @"\uf20b" : @"sheqel",
             @"\uf132" : @"shield",
             @"\uf07a" : @"shoppingCart",
             @"\uf090" : @"signIn",
             @"\uf08b" : @"signOut",
             @"\uf012" : @"signal",
             @"\uf0e8" : @"sitemap",
             @"\uf17e" : @"skype",
             @"\uf198" : @"slack",
             @"\uf1de" : @"sliders",
             @"\uf1e7" : @"slideshare",
             @"\uf118" : @"smileO",
             @"\uf1e3" : @"soccerBallO",
             @"\uf0dc" : @"sort",
             @"\uf15d" : @"sortAlphaAsc",
             @"\uf15e" : @"sortAlphaDesc",
             @"\uf160" : @"sortAmountAsc",
             @"\uf161" : @"sortAmountDesc",
             @"\uf0de" : @"sortAsc",
             @"\uf0dd" : @"sortDesc",
             @"\uf0dd" : @"sortDown",
             @"\uf162" : @"sortNumericAsc",
             @"\uf163" : @"sortNumericDesc",
             @"\uf0de" : @"sortUp",
             @"\uf1be" : @"soundcloud",
             @"\uf197" : @"spaceShuttle",
             @"\uf110" : @"spinner",
             @"\uf1b1" : @"spoon",
             @"\uf1bc" : @"spotify",
             @"\uf0c8" : @"square",
             @"\uf096" : @"squareO",
             @"\uf18d" : @"stackExchange",
             @"\uf16c" : @"stackOverflow",
             @"\uf005" : @"star",
             @"\uf089" : @"starHalf",
             @"\uf123" : @"starHalfEmpty",
             @"\uf123" : @"starHalfFull",
             @"\uf123" : @"starHalfO",
             @"\uf006" : @"starO",
             @"\uf1b6" : @"steam",
             @"\uf1b7" : @"steamSquare",
             @"\uf048" : @"stepBackward",
             @"\uf051" : @"stepForward",
             @"\uf0f1" : @"stethoscope",
             @"\uf04d" : @"stop",
             @"\uf0cc" : @"strikethrough",
             @"\uf1a4" : @"stumbleupon",
             @"\uf1a3" : @"stumbleuponCircle",
             @"\uf12c" : @"subscript",
             @"\uf0f2" : @"suitcase",
             @"\uf185" : @"sunO",
             @"\uf12b" : @"superscript",
             @"\uf1cd" : @"support",
             @"\uf0ce" : @"table",
             @"\uf10a" : @"tablet",
             @"\uf0e4" : @"tachometer",
             @"\uf02b" : @"tag",
             @"\uf02c" : @"tags",
             @"\uf0ae" : @"tasks",
             @"\uf1ba" : @"taxi",
             @"\uf1d5" : @"tencentWeibo",
             @"\uf120" : @"terminal",
             @"\uf034" : @"textHeight",
             @"\uf035" : @"textWidth",
             @"\uf00a" : @"th",
             @"\uf009" : @"thLarge",
             @"\uf00b" : @"thList",
             @"\uf08d" : @"thumbTack",
             @"\uf165" : @"thumbsDown",
             @"\uf088" : @"thumbsODown",
             @"\uf087" : @"thumbsOUp",
             @"\uf164" : @"thumbsUp",
             @"\uf145" : @"ticket",
             @"\uf00d" : @"times",
             @"\uf057" : @"timesCircle",
             @"\uf05c" : @"timesCircleO",
             @"\uf043" : @"tint",
             @"\uf150" : @"toggleDown",
             @"\uf191" : @"toggleLeft",
             @"\uf204" : @"toggleOff",
             @"\uf205" : @"toggleOn",
             @"\uf152" : @"toggleRight",
             @"\uf151" : @"toggleUp",
             @"\uf1f8" : @"trash",
             @"\uf014" : @"trashO",
             @"\uf1bb" : @"tree",
             @"\uf181" : @"trello",
             @"\uf091" : @"trophy",
             @"\uf0d1" : @"truck",
             @"\uf195" : @"try",
             @"\uf1e4" : @"tty",
             @"\uf173" : @"tumblr",
             @"\uf174" : @"tumblrSquare",
             @"\uf195" : @"turkishLira",
             @"\uf1e8" : @"twitch",
             @"\uf099" : @"twitter",
             @"\uf081" : @"twitterSquare",
             @"\uf0e9" : @"umbrella",
             @"\uf0cd" : @"underline",
             @"\uf0e2" : @"undo",
             @"\uf19c" : @"university",
             @"\uf127" : @"unlink",
             @"\uf09c" : @"unlock",
             @"\uf13e" : @"unlockAlt",
             @"\uf0dc" : @"unsorted",
             @"\uf093" : @"upload",
             @"\uf155" : @"usd",
             @"\uf007" : @"user",
             @"\uf0f0" : @"userMd",
             @"\uf0c0" : @"users",
             @"\uf03d" : @"videoCamera",
             @"\uf194" : @"vimeoSquare",
             @"\uf1ca" : @"vine",
             @"\uf189" : @"vk",
             @"\uf027" : @"volumeDown",
             @"\uf026" : @"volumeOff",
             @"\uf028" : @"volumeUp",
             @"\uf071" : @"warning",
             @"\uf1d7" : @"wechat",
             @"\uf18a" : @"weibo",
             @"\uf1d7" : @"weixin",
             @"\uf193" : @"wheelchair",
             @"\uf1eb" : @"wifi",
             @"\uf17a" : @"windows",
             @"\uf159" : @"won",
             @"\uf19a" : @"wordpress",
             @"\uf0ad" : @"wrench",
             @"\uf168" : @"xing",
             @"\uf169" : @"xingSquare",
             @"\uf19e" : @"yahoo",
             @"\uf1e9" : @"yelp",
             @"\uf157" : @"yen",
             @"\uf167" : @"youtube",
             @"\uf16a" : @"youtubePlay",
             @"\uf166" : @"youtubeSquare",
             
             };
}

@end
