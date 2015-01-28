#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FAKFontAwesome.h"

@implementation FAKFontAwesome

+ (UIFont *)iconFontWithSize:(CGFloat)size
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self registerIconFontWithURL:[[NSBundle mainBundle] URLForResource:@"FontAwesome" withExtension:@"otf"]];
    });
    
    UIFont *font = [UIFont fontWithName:@"FontAwesome" size:size];
    NSAssert(font, @"UIFont object should not be nil, check if the font file is added to the application bundle and you're using the correct font name.");
    return font;
}

// Generated Code
+ (instancetype)glassIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf000" size:size];
}

+ (instancetype)musicIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf001" size:size];
}

+ (instancetype)searchIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf002" size:size];
}

+ (instancetype)envelopeOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf003" size:size];
}

+ (instancetype)heartIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf004" size:size];
}

+ (instancetype)starIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf005" size:size];
}

+ (instancetype)starOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf006" size:size];
}

+ (instancetype)userIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf007" size:size];
}

+ (instancetype)filmIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf008" size:size];
}

+ (instancetype)thLargeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf009" size:size];
}

+ (instancetype)thIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf00a" size:size];
}

+ (instancetype)thListIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf00b" size:size];
}

+ (instancetype)checkIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf00c" size:size];
}

+ (instancetype)timesIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf00d" size:size];
}

+ (instancetype)searchPlusIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf00e" size:size];
}

+ (instancetype)searchMinusIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf010" size:size];
}

+ (instancetype)powerOffIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf011" size:size];
}

+ (instancetype)signalIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf012" size:size];
}

+ (instancetype)cogIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf013" size:size];
}

+ (instancetype)trashOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf014" size:size];
}

+ (instancetype)homeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf015" size:size];
}

+ (instancetype)fileOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf016" size:size];
}

+ (instancetype)clockOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf017" size:size];
}

+ (instancetype)roadIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf018" size:size];
}

+ (instancetype)downloadIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf019" size:size];
}

+ (instancetype)arrowCircleODownIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf01a" size:size];
}

+ (instancetype)arrowCircleOUpIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf01b" size:size];
}

+ (instancetype)inboxIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf01c" size:size];
}

+ (instancetype)playCircleOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf01d" size:size];
}

+ (instancetype)repeatIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf01e" size:size];
}

+ (instancetype)refreshIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf021" size:size];
}

+ (instancetype)listAltIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf022" size:size];
}

+ (instancetype)lockIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf023" size:size];
}

+ (instancetype)flagIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf024" size:size];
}

+ (instancetype)headphonesIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf025" size:size];
}

+ (instancetype)volumeOffIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf026" size:size];
}

+ (instancetype)volumeDownIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf027" size:size];
}

+ (instancetype)volumeUpIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf028" size:size];
}

+ (instancetype)qrcodeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf029" size:size];
}

+ (instancetype)barcodeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf02a" size:size];
}

+ (instancetype)tagIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf02b" size:size];
}

+ (instancetype)tagsIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf02c" size:size];
}

+ (instancetype)bookIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf02d" size:size];
}

+ (instancetype)bookmarkIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf02e" size:size];
}

+ (instancetype)printIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf02f" size:size];
}

+ (instancetype)cameraIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf030" size:size];
}

+ (instancetype)fontIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf031" size:size];
}

+ (instancetype)boldIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf032" size:size];
}

+ (instancetype)italicIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf033" size:size];
}

+ (instancetype)textHeightIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf034" size:size];
}

+ (instancetype)textWidthIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf035" size:size];
}

+ (instancetype)alignLeftIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf036" size:size];
}

+ (instancetype)alignCenterIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf037" size:size];
}

+ (instancetype)alignRightIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf038" size:size];
}

+ (instancetype)alignJustifyIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf039" size:size];
}

+ (instancetype)listIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf03a" size:size];
}

+ (instancetype)outdentIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf03b" size:size];
}

+ (instancetype)indentIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf03c" size:size];
}

+ (instancetype)videoCameraIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf03d" size:size];
}

+ (instancetype)pictureOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf03e" size:size];
}

+ (instancetype)pencilIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf040" size:size];
}

+ (instancetype)mapMarkerIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf041" size:size];
}

+ (instancetype)adjustIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf042" size:size];
}

+ (instancetype)tintIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf043" size:size];
}

+ (instancetype)pencilSquareOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf044" size:size];
}

+ (instancetype)shareSquareOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf045" size:size];
}

+ (instancetype)checkSquareOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf046" size:size];
}

+ (instancetype)arrowsIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf047" size:size];
}

+ (instancetype)stepBackwardIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf048" size:size];
}

+ (instancetype)fastBackwardIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf049" size:size];
}

+ (instancetype)backwardIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf04a" size:size];
}

+ (instancetype)playIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf04b" size:size];
}

+ (instancetype)pauseIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf04c" size:size];
}

+ (instancetype)stopIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf04d" size:size];
}

+ (instancetype)forwardIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf04e" size:size];
}

+ (instancetype)fastForwardIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf050" size:size];
}

+ (instancetype)stepForwardIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf051" size:size];
}

+ (instancetype)ejectIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf052" size:size];
}

+ (instancetype)chevronLeftIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf053" size:size];
}

+ (instancetype)chevronRightIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf054" size:size];
}

+ (instancetype)plusCircleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf055" size:size];
}

+ (instancetype)minusCircleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf056" size:size];
}

+ (instancetype)timesCircleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf057" size:size];
}

+ (instancetype)checkCircleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf058" size:size];
}

+ (instancetype)questionCircleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf059" size:size];
}

+ (instancetype)infoCircleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf05a" size:size];
}

+ (instancetype)crosshairsIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf05b" size:size];
}

+ (instancetype)timesCircleOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf05c" size:size];
}

+ (instancetype)checkCircleOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf05d" size:size];
}

+ (instancetype)banIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf05e" size:size];
}

+ (instancetype)arrowLeftIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf060" size:size];
}

+ (instancetype)arrowRightIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf061" size:size];
}

+ (instancetype)arrowUpIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf062" size:size];
}

+ (instancetype)arrowDownIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf063" size:size];
}

+ (instancetype)shareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf064" size:size];
}

+ (instancetype)expandIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf065" size:size];
}

+ (instancetype)compressIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf066" size:size];
}

+ (instancetype)plusIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf067" size:size];
}

+ (instancetype)minusIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf068" size:size];
}

+ (instancetype)asteriskIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf069" size:size];
}

+ (instancetype)exclamationCircleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf06a" size:size];
}

+ (instancetype)giftIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf06b" size:size];
}

+ (instancetype)leafIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf06c" size:size];
}

+ (instancetype)fireIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf06d" size:size];
}

+ (instancetype)eyeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf06e" size:size];
}

+ (instancetype)eyeSlashIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf070" size:size];
}

+ (instancetype)exclamationTriangleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf071" size:size];
}

+ (instancetype)planeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf072" size:size];
}

+ (instancetype)calendarIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf073" size:size];
}

+ (instancetype)randomIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf074" size:size];
}

+ (instancetype)commentIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf075" size:size];
}

+ (instancetype)magnetIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf076" size:size];
}

+ (instancetype)chevronUpIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf077" size:size];
}

+ (instancetype)chevronDownIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf078" size:size];
}

+ (instancetype)retweetIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf079" size:size];
}

+ (instancetype)shoppingCartIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf07a" size:size];
}

+ (instancetype)folderIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf07b" size:size];
}

+ (instancetype)folderOpenIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf07c" size:size];
}

+ (instancetype)arrowsVIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf07d" size:size];
}

+ (instancetype)arrowsHIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf07e" size:size];
}

+ (instancetype)barChartOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf080" size:size];
}

+ (instancetype)twitterSquareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf081" size:size];
}

+ (instancetype)facebookSquareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf082" size:size];
}

+ (instancetype)cameraRetroIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf083" size:size];
}

+ (instancetype)keyIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf084" size:size];
}

+ (instancetype)cogsIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf085" size:size];
}

+ (instancetype)commentsIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf086" size:size];
}

+ (instancetype)thumbsOUpIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf087" size:size];
}

+ (instancetype)thumbsODownIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf088" size:size];
}

+ (instancetype)starHalfIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf089" size:size];
}

+ (instancetype)heartOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf08a" size:size];
}

+ (instancetype)signOutIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf08b" size:size];
}

+ (instancetype)linkedinSquareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf08c" size:size];
}

+ (instancetype)thumbTackIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf08d" size:size];
}

+ (instancetype)externalLinkIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf08e" size:size];
}

+ (instancetype)signInIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf090" size:size];
}

+ (instancetype)trophyIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf091" size:size];
}

+ (instancetype)githubSquareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf092" size:size];
}

+ (instancetype)uploadIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf093" size:size];
}

+ (instancetype)lemonOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf094" size:size];
}

+ (instancetype)phoneIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf095" size:size];
}

+ (instancetype)squareOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf096" size:size];
}

+ (instancetype)bookmarkOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf097" size:size];
}

+ (instancetype)phoneSquareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf098" size:size];
}

+ (instancetype)twitterIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf099" size:size];
}

+ (instancetype)facebookIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf09a" size:size];
}

+ (instancetype)githubIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf09b" size:size];
}

+ (instancetype)unlockIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf09c" size:size];
}

+ (instancetype)creditCardIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf09d" size:size];
}

+ (instancetype)rssIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf09e" size:size];
}

+ (instancetype)hddOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0a0" size:size];
}

+ (instancetype)bullhornIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0a1" size:size];
}

+ (instancetype)bellIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0f3" size:size];
}

+ (instancetype)certificateIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0a3" size:size];
}

+ (instancetype)handORightIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0a4" size:size];
}

+ (instancetype)handOLeftIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0a5" size:size];
}

+ (instancetype)handOUpIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0a6" size:size];
}

+ (instancetype)handODownIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0a7" size:size];
}

+ (instancetype)arrowCircleLeftIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0a8" size:size];
}

+ (instancetype)arrowCircleRightIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0a9" size:size];
}

+ (instancetype)arrowCircleUpIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0aa" size:size];
}

+ (instancetype)arrowCircleDownIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0ab" size:size];
}

+ (instancetype)globeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0ac" size:size];
}

+ (instancetype)wrenchIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0ad" size:size];
}

+ (instancetype)tasksIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0ae" size:size];
}

+ (instancetype)filterIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0b0" size:size];
}

+ (instancetype)briefcaseIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0b1" size:size];
}

+ (instancetype)arrowsAltIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0b2" size:size];
}

+ (instancetype)usersIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0c0" size:size];
}

+ (instancetype)linkIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0c1" size:size];
}

+ (instancetype)cloudIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0c2" size:size];
}

+ (instancetype)flaskIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0c3" size:size];
}

+ (instancetype)scissorsIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0c4" size:size];
}

+ (instancetype)filesOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0c5" size:size];
}

+ (instancetype)paperclipIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0c6" size:size];
}

+ (instancetype)floppyOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0c7" size:size];
}

+ (instancetype)squareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0c8" size:size];
}

+ (instancetype)barsIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0c9" size:size];
}

+ (instancetype)listUlIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0ca" size:size];
}

+ (instancetype)listOlIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0cb" size:size];
}

+ (instancetype)strikethroughIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0cc" size:size];
}

+ (instancetype)underlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0cd" size:size];
}

+ (instancetype)tableIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0ce" size:size];
}

+ (instancetype)magicIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0d0" size:size];
}

+ (instancetype)truckIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0d1" size:size];
}

+ (instancetype)pinterestIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0d2" size:size];
}

+ (instancetype)pinterestSquareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0d3" size:size];
}

+ (instancetype)googlePlusSquareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0d4" size:size];
}

+ (instancetype)googlePlusIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0d5" size:size];
}

+ (instancetype)moneyIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0d6" size:size];
}

+ (instancetype)caretDownIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0d7" size:size];
}

+ (instancetype)caretUpIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0d8" size:size];
}

+ (instancetype)caretLeftIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0d9" size:size];
}

+ (instancetype)caretRightIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0da" size:size];
}

+ (instancetype)columnsIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0db" size:size];
}

+ (instancetype)sortIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0dc" size:size];
}

+ (instancetype)sortAscIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0dd" size:size];
}

+ (instancetype)sortDescIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0de" size:size];
}

+ (instancetype)envelopeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0e0" size:size];
}

+ (instancetype)linkedinIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0e1" size:size];
}

+ (instancetype)undoIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0e2" size:size];
}

+ (instancetype)gavelIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0e3" size:size];
}

+ (instancetype)tachometerIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0e4" size:size];
}

+ (instancetype)commentOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0e5" size:size];
}

+ (instancetype)commentsOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0e6" size:size];
}

+ (instancetype)boltIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0e7" size:size];
}

+ (instancetype)sitemapIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0e8" size:size];
}

+ (instancetype)umbrellaIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0e9" size:size];
}

+ (instancetype)clipboardIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0ea" size:size];
}

+ (instancetype)lightbulbOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0eb" size:size];
}

+ (instancetype)exchangeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0ec" size:size];
}

+ (instancetype)cloudDownloadIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0ed" size:size];
}

+ (instancetype)cloudUploadIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0ee" size:size];
}

+ (instancetype)userMdIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0f0" size:size];
}

+ (instancetype)stethoscopeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0f1" size:size];
}

+ (instancetype)suitcaseIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0f2" size:size];
}

+ (instancetype)bellOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0a2" size:size];
}

+ (instancetype)coffeeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0f4" size:size];
}

+ (instancetype)cutleryIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0f5" size:size];
}

+ (instancetype)fileTextOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0f6" size:size];
}

+ (instancetype)buildingOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0f7" size:size];
}

+ (instancetype)hospitalOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0f8" size:size];
}

+ (instancetype)ambulanceIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0f9" size:size];
}

+ (instancetype)medkitIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0fa" size:size];
}

+ (instancetype)fighterJetIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0fb" size:size];
}

+ (instancetype)beerIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0fc" size:size];
}

+ (instancetype)hSquareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0fd" size:size];
}

+ (instancetype)plusSquareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf0fe" size:size];
}

+ (instancetype)angleDoubleLeftIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf100" size:size];
}

+ (instancetype)angleDoubleRightIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf101" size:size];
}

+ (instancetype)angleDoubleUpIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf102" size:size];
}

+ (instancetype)angleDoubleDownIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf103" size:size];
}

+ (instancetype)angleLeftIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf104" size:size];
}

+ (instancetype)angleRightIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf105" size:size];
}

+ (instancetype)angleUpIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf106" size:size];
}

+ (instancetype)angleDownIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf107" size:size];
}

+ (instancetype)desktopIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf108" size:size];
}

+ (instancetype)laptopIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf109" size:size];
}

+ (instancetype)tabletIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf10a" size:size];
}

+ (instancetype)mobileIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf10b" size:size];
}

+ (instancetype)circleOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf10c" size:size];
}

+ (instancetype)quoteLeftIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf10d" size:size];
}

+ (instancetype)quoteRightIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf10e" size:size];
}

+ (instancetype)spinnerIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf110" size:size];
}

+ (instancetype)circleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf111" size:size];
}

+ (instancetype)replyIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf112" size:size];
}

+ (instancetype)githubAltIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf113" size:size];
}

+ (instancetype)folderOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf114" size:size];
}

+ (instancetype)folderOpenOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf115" size:size];
}

+ (instancetype)smileOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf118" size:size];
}

+ (instancetype)frownOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf119" size:size];
}

+ (instancetype)mehOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf11a" size:size];
}

+ (instancetype)gamepadIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf11b" size:size];
}

+ (instancetype)keyboardOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf11c" size:size];
}

+ (instancetype)flagOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf11d" size:size];
}

+ (instancetype)flagCheckeredIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf11e" size:size];
}

+ (instancetype)terminalIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf120" size:size];
}

+ (instancetype)codeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf121" size:size];
}

+ (instancetype)replyAllIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf122" size:size];
}

+ (instancetype)mailReplyAllIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf122" size:size];
}

+ (instancetype)starHalfOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf123" size:size];
}

+ (instancetype)locationArrowIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf124" size:size];
}

+ (instancetype)cropIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf125" size:size];
}

+ (instancetype)codeForkIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf126" size:size];
}

+ (instancetype)chainBrokenIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf127" size:size];
}

+ (instancetype)questionIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf128" size:size];
}

+ (instancetype)infoIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf129" size:size];
}

+ (instancetype)exclamationIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf12a" size:size];
}

+ (instancetype)superscriptIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf12b" size:size];
}

+ (instancetype)subscriptIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf12c" size:size];
}

+ (instancetype)eraserIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf12d" size:size];
}

+ (instancetype)puzzlePieceIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf12e" size:size];
}

+ (instancetype)microphoneIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf130" size:size];
}

+ (instancetype)microphoneSlashIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf131" size:size];
}

+ (instancetype)shieldIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf132" size:size];
}

+ (instancetype)calendarOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf133" size:size];
}

+ (instancetype)fireExtinguisherIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf134" size:size];
}

+ (instancetype)rocketIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf135" size:size];
}

+ (instancetype)maxcdnIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf136" size:size];
}

+ (instancetype)chevronCircleLeftIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf137" size:size];
}

+ (instancetype)chevronCircleRightIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf138" size:size];
}

+ (instancetype)chevronCircleUpIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf139" size:size];
}

+ (instancetype)chevronCircleDownIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf13a" size:size];
}

+ (instancetype)html5IconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf13b" size:size];
}

+ (instancetype)css3IconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf13c" size:size];
}

+ (instancetype)anchorIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf13d" size:size];
}

+ (instancetype)unlockAltIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf13e" size:size];
}

+ (instancetype)bullseyeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf140" size:size];
}

+ (instancetype)ellipsisHIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf141" size:size];
}

+ (instancetype)ellipsisVIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf142" size:size];
}

+ (instancetype)rssSquareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf143" size:size];
}

+ (instancetype)playCircleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf144" size:size];
}

+ (instancetype)ticketIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf145" size:size];
}

+ (instancetype)minusSquareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf146" size:size];
}

+ (instancetype)minusSquareOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf147" size:size];
}

+ (instancetype)levelUpIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf148" size:size];
}

+ (instancetype)levelDownIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf149" size:size];
}

+ (instancetype)checkSquareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf14a" size:size];
}

+ (instancetype)pencilSquareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf14b" size:size];
}

+ (instancetype)externalLinkSquareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf14c" size:size];
}

+ (instancetype)shareSquareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf14d" size:size];
}

+ (instancetype)compassIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf14e" size:size];
}

+ (instancetype)caretSquareODownIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf150" size:size];
}

+ (instancetype)caretSquareOUpIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf151" size:size];
}

+ (instancetype)caretSquareORightIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf152" size:size];
}

+ (instancetype)eurIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf153" size:size];
}

+ (instancetype)gbpIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf154" size:size];
}

+ (instancetype)usdIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf155" size:size];
}

+ (instancetype)inrIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf156" size:size];
}

+ (instancetype)jpyIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf157" size:size];
}

+ (instancetype)rubIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf158" size:size];
}

+ (instancetype)krwIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf159" size:size];
}

+ (instancetype)btcIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf15a" size:size];
}

+ (instancetype)fileIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf15b" size:size];
}

+ (instancetype)fileTextIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf15c" size:size];
}

+ (instancetype)sortAlphaAscIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf15d" size:size];
}

+ (instancetype)sortAlphaDescIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf15e" size:size];
}

+ (instancetype)sortAmountAscIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf160" size:size];
}

+ (instancetype)sortAmountDescIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf161" size:size];
}

+ (instancetype)sortNumericAscIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf162" size:size];
}

+ (instancetype)sortNumericDescIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf163" size:size];
}

+ (instancetype)thumbsUpIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf164" size:size];
}

+ (instancetype)thumbsDownIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf165" size:size];
}

+ (instancetype)youtubeSquareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf166" size:size];
}

+ (instancetype)youtubeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf167" size:size];
}

+ (instancetype)xingIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf168" size:size];
}

+ (instancetype)xingSquareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf169" size:size];
}

+ (instancetype)youtubePlayIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf16a" size:size];
}

+ (instancetype)dropboxIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf16b" size:size];
}

+ (instancetype)stackOverflowIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf16c" size:size];
}

+ (instancetype)instagramIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf16d" size:size];
}

+ (instancetype)flickrIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf16e" size:size];
}

+ (instancetype)adnIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf170" size:size];
}

+ (instancetype)bitbucketIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf171" size:size];
}

+ (instancetype)bitbucketSquareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf172" size:size];
}

+ (instancetype)tumblrIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf173" size:size];
}

+ (instancetype)tumblrSquareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf174" size:size];
}

+ (instancetype)longArrowDownIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf175" size:size];
}

+ (instancetype)longArrowUpIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf176" size:size];
}

+ (instancetype)longArrowLeftIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf177" size:size];
}

+ (instancetype)longArrowRightIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf178" size:size];
}

+ (instancetype)appleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf179" size:size];
}

+ (instancetype)windowsIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf17a" size:size];
}

+ (instancetype)androidIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf17b" size:size];
}

+ (instancetype)linuxIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf17c" size:size];
}

+ (instancetype)dribbbleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf17d" size:size];
}

+ (instancetype)skypeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf17e" size:size];
}

+ (instancetype)foursquareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf180" size:size];
}

+ (instancetype)trelloIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf181" size:size];
}

+ (instancetype)femaleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf182" size:size];
}

+ (instancetype)maleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf183" size:size];
}

+ (instancetype)gittipIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf184" size:size];
}

+ (instancetype)sunOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf185" size:size];
}

+ (instancetype)moonOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf186" size:size];
}

+ (instancetype)archiveIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf187" size:size];
}

+ (instancetype)bugIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf188" size:size];
}

+ (instancetype)vkIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf189" size:size];
}

+ (instancetype)weiboIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf18a" size:size];
}

+ (instancetype)renrenIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf18b" size:size];
}

+ (instancetype)pagelinesIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf18c" size:size];
}

+ (instancetype)stackExchangeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf18d" size:size];
}

+ (instancetype)arrowCircleORightIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf18e" size:size];
}

+ (instancetype)arrowCircleOLeftIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf190" size:size];
}

+ (instancetype)caretSquareOLeftIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf191" size:size];
}

+ (instancetype)dotCircleOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf192" size:size];
}

+ (instancetype)wheelchairIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf193" size:size];
}

+ (instancetype)vimeoSquareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf194" size:size];
}

+ (instancetype)tryIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf195" size:size];
}

+ (instancetype)plusSquareOIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\uf196" size:size];
}


+ (NSDictionary *)allIcons
{
    return @{
             @"\uf000" : @"glass",
             @"\uf001" : @"music",
             @"\uf002" : @"search",
             @"\uf003" : @"envelopeO",
             @"\uf004" : @"heart",
             @"\uf005" : @"star",
             @"\uf006" : @"starO",
             @"\uf007" : @"user",
             @"\uf008" : @"film",
             @"\uf009" : @"thLarge",
             @"\uf00a" : @"th",
             @"\uf00b" : @"thList",
             @"\uf00c" : @"check",
             @"\uf00d" : @"times",
             @"\uf00e" : @"searchPlus",
             @"\uf010" : @"searchMinus",
             @"\uf011" : @"powerOff",
             @"\uf012" : @"signal",
             @"\uf013" : @"cog",
             @"\uf014" : @"trashO",
             @"\uf015" : @"home",
             @"\uf016" : @"fileO",
             @"\uf017" : @"clockO",
             @"\uf018" : @"road",
             @"\uf019" : @"download",
             @"\uf01a" : @"arrowCircleODown",
             @"\uf01b" : @"arrowCircleOUp",
             @"\uf01c" : @"inbox",
             @"\uf01d" : @"playCircleO",
             @"\uf01e" : @"repeat",
             @"\uf021" : @"refresh",
             @"\uf022" : @"listAlt",
             @"\uf023" : @"lock",
             @"\uf024" : @"flag",
             @"\uf025" : @"headphones",
             @"\uf026" : @"volumeOff",
             @"\uf027" : @"volumeDown",
             @"\uf028" : @"volumeUp",
             @"\uf029" : @"qrcode",
             @"\uf02a" : @"barcode",
             @"\uf02b" : @"tag",
             @"\uf02c" : @"tags",
             @"\uf02d" : @"book",
             @"\uf02e" : @"bookmark",
             @"\uf02f" : @"print",
             @"\uf030" : @"camera",
             @"\uf031" : @"font",
             @"\uf032" : @"bold",
             @"\uf033" : @"italic",
             @"\uf034" : @"textHeight",
             @"\uf035" : @"textWidth",
             @"\uf036" : @"alignLeft",
             @"\uf037" : @"alignCenter",
             @"\uf038" : @"alignRight",
             @"\uf039" : @"alignJustify",
             @"\uf03a" : @"list",
             @"\uf03b" : @"outdent",
             @"\uf03c" : @"indent",
             @"\uf03d" : @"videoCamera",
             @"\uf03e" : @"pictureO",
             @"\uf040" : @"pencil",
             @"\uf041" : @"mapMarker",
             @"\uf042" : @"adjust",
             @"\uf043" : @"tint",
             @"\uf044" : @"pencilSquareO",
             @"\uf045" : @"shareSquareO",
             @"\uf046" : @"checkSquareO",
             @"\uf047" : @"arrows",
             @"\uf048" : @"stepBackward",
             @"\uf049" : @"fastBackward",
             @"\uf04a" : @"backward",
             @"\uf04b" : @"play",
             @"\uf04c" : @"pause",
             @"\uf04d" : @"stop",
             @"\uf04e" : @"forward",
             @"\uf050" : @"fastForward",
             @"\uf051" : @"stepForward",
             @"\uf052" : @"eject",
             @"\uf053" : @"chevronLeft",
             @"\uf054" : @"chevronRight",
             @"\uf055" : @"plusCircle",
             @"\uf056" : @"minusCircle",
             @"\uf057" : @"timesCircle",
             @"\uf058" : @"checkCircle",
             @"\uf059" : @"questionCircle",
             @"\uf05a" : @"infoCircle",
             @"\uf05b" : @"crosshairs",
             @"\uf05c" : @"timesCircleO",
             @"\uf05d" : @"checkCircleO",
             @"\uf05e" : @"ban",
             @"\uf060" : @"arrowLeft",
             @"\uf061" : @"arrowRight",
             @"\uf062" : @"arrowUp",
             @"\uf063" : @"arrowDown",
             @"\uf064" : @"share",
             @"\uf065" : @"expand",
             @"\uf066" : @"compress",
             @"\uf067" : @"plus",
             @"\uf068" : @"minus",
             @"\uf069" : @"asterisk",
             @"\uf06a" : @"exclamationCircle",
             @"\uf06b" : @"gift",
             @"\uf06c" : @"leaf",
             @"\uf06d" : @"fire",
             @"\uf06e" : @"eye",
             @"\uf070" : @"eyeSlash",
             @"\uf071" : @"exclamationTriangle",
             @"\uf072" : @"plane",
             @"\uf073" : @"calendar",
             @"\uf074" : @"random",
             @"\uf075" : @"comment",
             @"\uf076" : @"magnet",
             @"\uf077" : @"chevronUp",
             @"\uf078" : @"chevronDown",
             @"\uf079" : @"retweet",
             @"\uf07a" : @"shoppingCart",
             @"\uf07b" : @"folder",
             @"\uf07c" : @"folderOpen",
             @"\uf07d" : @"arrowsV",
             @"\uf07e" : @"arrowsH",
             @"\uf080" : @"barChartO",
             @"\uf081" : @"twitterSquare",
             @"\uf082" : @"facebookSquare",
             @"\uf083" : @"cameraRetro",
             @"\uf084" : @"key",
             @"\uf085" : @"cogs",
             @"\uf086" : @"comments",
             @"\uf087" : @"thumbsOUp",
             @"\uf088" : @"thumbsODown",
             @"\uf089" : @"starHalf",
             @"\uf08a" : @"heartO",
             @"\uf08b" : @"signOut",
             @"\uf08c" : @"linkedinSquare",
             @"\uf08d" : @"thumbTack",
             @"\uf08e" : @"externalLink",
             @"\uf090" : @"signIn",
             @"\uf091" : @"trophy",
             @"\uf092" : @"githubSquare",
             @"\uf093" : @"upload",
             @"\uf094" : @"lemonO",
             @"\uf095" : @"phone",
             @"\uf096" : @"squareO",
             @"\uf097" : @"bookmarkO",
             @"\uf098" : @"phoneSquare",
             @"\uf099" : @"twitter",
             @"\uf09a" : @"facebook",
             @"\uf09b" : @"github",
             @"\uf09c" : @"unlock",
             @"\uf09d" : @"creditCard",
             @"\uf09e" : @"rss",
             @"\uf0a0" : @"hddO",
             @"\uf0a1" : @"bullhorn",
             @"\uf0f3" : @"bell",
             @"\uf0a3" : @"certificate",
             @"\uf0a4" : @"handORight",
             @"\uf0a5" : @"handOLeft",
             @"\uf0a6" : @"handOUp",
             @"\uf0a7" : @"handODown",
             @"\uf0a8" : @"arrowCircleLeft",
             @"\uf0a9" : @"arrowCircleRight",
             @"\uf0aa" : @"arrowCircleUp",
             @"\uf0ab" : @"arrowCircleDown",
             @"\uf0ac" : @"globe",
             @"\uf0ad" : @"wrench",
             @"\uf0ae" : @"tasks",
             @"\uf0b0" : @"filter",
             @"\uf0b1" : @"briefcase",
             @"\uf0b2" : @"arrowsAlt",
             @"\uf0c0" : @"users",
             @"\uf0c1" : @"link",
             @"\uf0c2" : @"cloud",
             @"\uf0c3" : @"flask",
             @"\uf0c4" : @"scissors",
             @"\uf0c5" : @"filesO",
             @"\uf0c6" : @"paperclip",
             @"\uf0c7" : @"floppyO",
             @"\uf0c8" : @"square",
             @"\uf0c9" : @"bars",
             @"\uf0ca" : @"listUl",
             @"\uf0cb" : @"listOl",
             @"\uf0cc" : @"strikethrough",
             @"\uf0cd" : @"underline",
             @"\uf0ce" : @"table",
             @"\uf0d0" : @"magic",
             @"\uf0d1" : @"truck",
             @"\uf0d2" : @"pinterest",
             @"\uf0d3" : @"pinterestSquare",
             @"\uf0d4" : @"googlePlusSquare",
             @"\uf0d5" : @"googlePlus",
             @"\uf0d6" : @"money",
             @"\uf0d7" : @"caretDown",
             @"\uf0d8" : @"caretUp",
             @"\uf0d9" : @"caretLeft",
             @"\uf0da" : @"caretRight",
             @"\uf0db" : @"columns",
             @"\uf0dc" : @"sort",
             @"\uf0dd" : @"sortAsc",
             @"\uf0de" : @"sortDesc",
             @"\uf0e0" : @"envelope",
             @"\uf0e1" : @"linkedin",
             @"\uf0e2" : @"undo",
             @"\uf0e3" : @"gavel",
             @"\uf0e4" : @"tachometer",
             @"\uf0e5" : @"commentO",
             @"\uf0e6" : @"commentsO",
             @"\uf0e7" : @"bolt",
             @"\uf0e8" : @"sitemap",
             @"\uf0e9" : @"umbrella",
             @"\uf0ea" : @"clipboard",
             @"\uf0eb" : @"lightbulbO",
             @"\uf0ec" : @"exchange",
             @"\uf0ed" : @"cloudDownload",
             @"\uf0ee" : @"cloudUpload",
             @"\uf0f0" : @"userMd",
             @"\uf0f1" : @"stethoscope",
             @"\uf0f2" : @"suitcase",
             @"\uf0a2" : @"bellO",
             @"\uf0f4" : @"coffee",
             @"\uf0f5" : @"cutlery",
             @"\uf0f6" : @"fileTextO",
             @"\uf0f7" : @"buildingO",
             @"\uf0f8" : @"hospitalO",
             @"\uf0f9" : @"ambulance",
             @"\uf0fa" : @"medkit",
             @"\uf0fb" : @"fighterJet",
             @"\uf0fc" : @"beer",
             @"\uf0fd" : @"hSquare",
             @"\uf0fe" : @"plusSquare",
             @"\uf100" : @"angleDoubleLeft",
             @"\uf101" : @"angleDoubleRight",
             @"\uf102" : @"angleDoubleUp",
             @"\uf103" : @"angleDoubleDown",
             @"\uf104" : @"angleLeft",
             @"\uf105" : @"angleRight",
             @"\uf106" : @"angleUp",
             @"\uf107" : @"angleDown",
             @"\uf108" : @"desktop",
             @"\uf109" : @"laptop",
             @"\uf10a" : @"tablet",
             @"\uf10b" : @"mobile",
             @"\uf10c" : @"circleO",
             @"\uf10d" : @"quoteLeft",
             @"\uf10e" : @"quoteRight",
             @"\uf110" : @"spinner",
             @"\uf111" : @"circle",
             @"\uf112" : @"reply",
             @"\uf113" : @"githubAlt",
             @"\uf114" : @"folderO",
             @"\uf115" : @"folderOpenO",
             @"\uf118" : @"smileO",
             @"\uf119" : @"frownO",
             @"\uf11a" : @"mehO",
             @"\uf11b" : @"gamepad",
             @"\uf11c" : @"keyboardO",
             @"\uf11d" : @"flagO",
             @"\uf11e" : @"flagCheckered",
             @"\uf120" : @"terminal",
             @"\uf121" : @"code",
             @"\uf122" : @"replyAll",
             @"\uf122" : @"mailReplyAll",
             @"\uf123" : @"starHalfO",
             @"\uf124" : @"locationArrow",
             @"\uf125" : @"crop",
             @"\uf126" : @"codeFork",
             @"\uf127" : @"chainBroken",
             @"\uf128" : @"question",
             @"\uf129" : @"info",
             @"\uf12a" : @"exclamation",
             @"\uf12b" : @"superscript",
             @"\uf12c" : @"subscript",
             @"\uf12d" : @"eraser",
             @"\uf12e" : @"puzzlePiece",
             @"\uf130" : @"microphone",
             @"\uf131" : @"microphoneSlash",
             @"\uf132" : @"shield",
             @"\uf133" : @"calendarO",
             @"\uf134" : @"fireExtinguisher",
             @"\uf135" : @"rocket",
             @"\uf136" : @"maxcdn",
             @"\uf137" : @"chevronCircleLeft",
             @"\uf138" : @"chevronCircleRight",
             @"\uf139" : @"chevronCircleUp",
             @"\uf13a" : @"chevronCircleDown",
             @"\uf13b" : @"html5",
             @"\uf13c" : @"css3",
             @"\uf13d" : @"anchor",
             @"\uf13e" : @"unlockAlt",
             @"\uf140" : @"bullseye",
             @"\uf141" : @"ellipsisH",
             @"\uf142" : @"ellipsisV",
             @"\uf143" : @"rssSquare",
             @"\uf144" : @"playCircle",
             @"\uf145" : @"ticket",
             @"\uf146" : @"minusSquare",
             @"\uf147" : @"minusSquareO",
             @"\uf148" : @"levelUp",
             @"\uf149" : @"levelDown",
             @"\uf14a" : @"checkSquare",
             @"\uf14b" : @"pencilSquare",
             @"\uf14c" : @"externalLinkSquare",
             @"\uf14d" : @"shareSquare",
             @"\uf14e" : @"compass",
             @"\uf150" : @"caretSquareODown",
             @"\uf151" : @"caretSquareOUp",
             @"\uf152" : @"caretSquareORight",
             @"\uf153" : @"eur",
             @"\uf154" : @"gbp",
             @"\uf155" : @"usd",
             @"\uf156" : @"inr",
             @"\uf157" : @"jpy",
             @"\uf158" : @"rub",
             @"\uf159" : @"krw",
             @"\uf15a" : @"btc",
             @"\uf15b" : @"file",
             @"\uf15c" : @"fileText",
             @"\uf15d" : @"sortAlphaAsc",
             @"\uf15e" : @"sortAlphaDesc",
             @"\uf160" : @"sortAmountAsc",
             @"\uf161" : @"sortAmountDesc",
             @"\uf162" : @"sortNumericAsc",
             @"\uf163" : @"sortNumericDesc",
             @"\uf164" : @"thumbsUp",
             @"\uf165" : @"thumbsDown",
             @"\uf166" : @"youtubeSquare",
             @"\uf167" : @"youtube",
             @"\uf168" : @"xing",
             @"\uf169" : @"xingSquare",
             @"\uf16a" : @"youtubePlay",
             @"\uf16b" : @"dropbox",
             @"\uf16c" : @"stackOverflow",
             @"\uf16d" : @"instagram",
             @"\uf16e" : @"flickr",
             @"\uf170" : @"adn",
             @"\uf171" : @"bitbucket",
             @"\uf172" : @"bitbucketSquare",
             @"\uf173" : @"tumblr",
             @"\uf174" : @"tumblrSquare",
             @"\uf175" : @"longArrowDown",
             @"\uf176" : @"longArrowUp",
             @"\uf177" : @"longArrowLeft",
             @"\uf178" : @"longArrowRight",
             @"\uf179" : @"apple",
             @"\uf17a" : @"windows",
             @"\uf17b" : @"android",
             @"\uf17c" : @"linux",
             @"\uf17d" : @"dribbble",
             @"\uf17e" : @"skype",
             @"\uf180" : @"foursquare",
             @"\uf181" : @"trello",
             @"\uf182" : @"female",
             @"\uf183" : @"male",
             @"\uf184" : @"gittip",
             @"\uf185" : @"sunO",
             @"\uf186" : @"moonO",
             @"\uf187" : @"archive",
             @"\uf188" : @"bug",
             @"\uf189" : @"vk",
             @"\uf18a" : @"weibo",
             @"\uf18b" : @"renren",
             @"\uf18c" : @"pagelines",
             @"\uf18d" : @"stackExchange",
             @"\uf18e" : @"arrowCircleORight",
             @"\uf190" : @"arrowCircleOLeft",
             @"\uf191" : @"caretSquareOLeft",
             @"\uf192" : @"dotCircleO",
             @"\uf193" : @"wheelchair",
             @"\uf194" : @"vimeoSquare",
             @"\uf195" : @"try",
             @"\uf196" : @"plusSquareO",
             
             };
}

@end
