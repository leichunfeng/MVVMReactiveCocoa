#import "FAKIonIcons.h"

@implementation FAKIonIcons

+ (UIFont *)iconFontWithSize:(CGFloat)size
{
#ifndef DISABLE_IONICONS_AUTO_REGISTRATION
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self registerIconFontWithURL: [[NSBundle mainBundle] URLForResource:@"ionicons" withExtension:@"ttf"]];
    });
#endif
    
    UIFont *font = [UIFont fontWithName:@"Ionicons" size:size];
    NSAssert(font, @"UIFont object should not be nil, check if the font file is added to the application bundle and you're using the correct font name.");
    return font;
}

// Generated Code
+ (instancetype)alertIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf101" size:size]; }
+ (instancetype)alertCircledIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf100" size:size]; }
+ (instancetype)androidAddIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2c7" size:size]; }
+ (instancetype)androidAddContactIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2c6" size:size]; }
+ (instancetype)androidAlarmIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2c8" size:size]; }
+ (instancetype)androidArchiveIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2c9" size:size]; }
+ (instancetype)androidArrowBackIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2ca" size:size]; }
+ (instancetype)androidArrowDownLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2cb" size:size]; }
+ (instancetype)androidArrowDownRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2cc" size:size]; }
+ (instancetype)androidArrowForwardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf30f" size:size]; }
+ (instancetype)androidArrowUpLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2cd" size:size]; }
+ (instancetype)androidArrowUpRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2ce" size:size]; }
+ (instancetype)androidBatteryIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2cf" size:size]; }
+ (instancetype)androidBookIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2d0" size:size]; }
+ (instancetype)androidCalendarIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2d1" size:size]; }
+ (instancetype)androidCallIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2d2" size:size]; }
+ (instancetype)androidCameraIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2d3" size:size]; }
+ (instancetype)androidChatIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2d4" size:size]; }
+ (instancetype)androidCheckmarkIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2d5" size:size]; }
+ (instancetype)androidClockIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2d6" size:size]; }
+ (instancetype)androidCloseIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2d7" size:size]; }
+ (instancetype)androidContactIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2d8" size:size]; }
+ (instancetype)androidContactsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2d9" size:size]; }
+ (instancetype)androidDataIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2da" size:size]; }
+ (instancetype)androidDeveloperIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2db" size:size]; }
+ (instancetype)androidDisplayIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2dc" size:size]; }
+ (instancetype)androidDownloadIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2dd" size:size]; }
+ (instancetype)androidDrawerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf310" size:size]; }
+ (instancetype)androidDropdownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2de" size:size]; }
+ (instancetype)androidEarthIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2df" size:size]; }
+ (instancetype)androidFolderIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2e0" size:size]; }
+ (instancetype)androidForumsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2e1" size:size]; }
+ (instancetype)androidFriendsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2e2" size:size]; }
+ (instancetype)androidHandIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2e3" size:size]; }
+ (instancetype)androidImageIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2e4" size:size]; }
+ (instancetype)androidInboxIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2e5" size:size]; }
+ (instancetype)androidInformationIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2e6" size:size]; }
+ (instancetype)androidKeypadIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2e7" size:size]; }
+ (instancetype)androidLightbulbIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2e8" size:size]; }
+ (instancetype)androidLocateIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2e9" size:size]; }
+ (instancetype)androidLocationIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2ea" size:size]; }
+ (instancetype)androidMailIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2eb" size:size]; }
+ (instancetype)androidMicrophoneIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2ec" size:size]; }
+ (instancetype)androidMixerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2ed" size:size]; }
+ (instancetype)androidMoreIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2ee" size:size]; }
+ (instancetype)androidNoteIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2ef" size:size]; }
+ (instancetype)androidPlaystoreIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2f0" size:size]; }
+ (instancetype)androidPrinterIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2f1" size:size]; }
+ (instancetype)androidPromotionIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2f2" size:size]; }
+ (instancetype)androidReminderIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2f3" size:size]; }
+ (instancetype)androidRemoveIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2f4" size:size]; }
+ (instancetype)androidSearchIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2f5" size:size]; }
+ (instancetype)androidSendIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2f6" size:size]; }
+ (instancetype)androidSettingsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2f7" size:size]; }
+ (instancetype)androidShareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2f8" size:size]; }
+ (instancetype)androidSocialIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2fa" size:size]; }
+ (instancetype)androidSocialUserIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2f9" size:size]; }
+ (instancetype)androidSortIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2fb" size:size]; }
+ (instancetype)androidStairDrawerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf311" size:size]; }
+ (instancetype)androidStarIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2fc" size:size]; }
+ (instancetype)androidStopwatchIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2fd" size:size]; }
+ (instancetype)androidStorageIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2fe" size:size]; }
+ (instancetype)androidSystemBackIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2ff" size:size]; }
+ (instancetype)androidSystemHomeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf300" size:size]; }
+ (instancetype)androidSystemWindowsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf301" size:size]; }
+ (instancetype)androidTimerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf302" size:size]; }
+ (instancetype)androidTrashIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf303" size:size]; }
+ (instancetype)androidUserMenuIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf312" size:size]; }
+ (instancetype)androidVolumeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf304" size:size]; }
+ (instancetype)androidWifiIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf305" size:size]; }
+ (instancetype)apertureIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf313" size:size]; }
+ (instancetype)archiveIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf102" size:size]; }
+ (instancetype)arrowDownAIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf103" size:size]; }
+ (instancetype)arrowDownBIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf104" size:size]; }
+ (instancetype)arrowDownCIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf105" size:size]; }
+ (instancetype)arrowExpandIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf25e" size:size]; }
+ (instancetype)arrowGraphDownLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf25f" size:size]; }
+ (instancetype)arrowGraphDownRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf260" size:size]; }
+ (instancetype)arrowGraphUpLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf261" size:size]; }
+ (instancetype)arrowGraphUpRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf262" size:size]; }
+ (instancetype)arrowLeftAIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf106" size:size]; }
+ (instancetype)arrowLeftBIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf107" size:size]; }
+ (instancetype)arrowLeftCIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf108" size:size]; }
+ (instancetype)arrowMoveIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf263" size:size]; }
+ (instancetype)arrowResizeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf264" size:size]; }
+ (instancetype)arrowReturnLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf265" size:size]; }
+ (instancetype)arrowReturnRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf266" size:size]; }
+ (instancetype)arrowRightAIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf109" size:size]; }
+ (instancetype)arrowRightBIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf10a" size:size]; }
+ (instancetype)arrowRightCIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf10b" size:size]; }
+ (instancetype)arrowShrinkIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf267" size:size]; }
+ (instancetype)arrowSwapIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf268" size:size]; }
+ (instancetype)arrowUpAIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf10c" size:size]; }
+ (instancetype)arrowUpBIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf10d" size:size]; }
+ (instancetype)arrowUpCIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf10e" size:size]; }
+ (instancetype)asteriskIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf314" size:size]; }
+ (instancetype)atIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf10f" size:size]; }
+ (instancetype)bagIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf110" size:size]; }
+ (instancetype)batteryChargingIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf111" size:size]; }
+ (instancetype)batteryEmptyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf112" size:size]; }
+ (instancetype)batteryFullIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf113" size:size]; }
+ (instancetype)batteryHalfIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf114" size:size]; }
+ (instancetype)batteryLowIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf115" size:size]; }
+ (instancetype)beakerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf269" size:size]; }
+ (instancetype)beerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf26a" size:size]; }
+ (instancetype)bluetoothIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf116" size:size]; }
+ (instancetype)bonfireIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf315" size:size]; }
+ (instancetype)bookmarkIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf26b" size:size]; }
+ (instancetype)briefcaseIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf26c" size:size]; }
+ (instancetype)bugIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2be" size:size]; }
+ (instancetype)calculatorIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf26d" size:size]; }
+ (instancetype)calendarIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf117" size:size]; }
+ (instancetype)cameraIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf118" size:size]; }
+ (instancetype)cardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf119" size:size]; }
+ (instancetype)cashIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf316" size:size]; }
+ (instancetype)chatboxIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf11b" size:size]; }
+ (instancetype)chatboxWorkingIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf11a" size:size]; }
+ (instancetype)chatboxesIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf11c" size:size]; }
+ (instancetype)chatbubbleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf11e" size:size]; }
+ (instancetype)chatbubbleWorkingIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf11d" size:size]; }
+ (instancetype)chatbubblesIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf11f" size:size]; }
+ (instancetype)checkmarkIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf122" size:size]; }
+ (instancetype)checkmarkCircledIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf120" size:size]; }
+ (instancetype)checkmarkRoundIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf121" size:size]; }
+ (instancetype)chevronDownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf123" size:size]; }
+ (instancetype)chevronLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf124" size:size]; }
+ (instancetype)chevronRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf125" size:size]; }
+ (instancetype)chevronUpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf126" size:size]; }
+ (instancetype)clipboardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf127" size:size]; }
+ (instancetype)clockIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf26e" size:size]; }
+ (instancetype)closeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf12a" size:size]; }
+ (instancetype)closeCircledIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf128" size:size]; }
+ (instancetype)closeRoundIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf129" size:size]; }
+ (instancetype)closedCaptioningIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf317" size:size]; }
+ (instancetype)cloudIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf12b" size:size]; }
+ (instancetype)codeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf271" size:size]; }
+ (instancetype)codeDownloadIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf26f" size:size]; }
+ (instancetype)codeWorkingIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf270" size:size]; }
+ (instancetype)coffeeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf272" size:size]; }
+ (instancetype)compassIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf273" size:size]; }
+ (instancetype)composeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf12c" size:size]; }
+ (instancetype)connectionBarsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf274" size:size]; }
+ (instancetype)contrastIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf275" size:size]; }
+ (instancetype)cubeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf318" size:size]; }
+ (instancetype)discIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf12d" size:size]; }
+ (instancetype)documentIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf12f" size:size]; }
+ (instancetype)documentTextIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf12e" size:size]; }
+ (instancetype)dragIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf130" size:size]; }
+ (instancetype)earthIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf276" size:size]; }
+ (instancetype)editIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2bf" size:size]; }
+ (instancetype)eggIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf277" size:size]; }
+ (instancetype)ejectIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf131" size:size]; }
+ (instancetype)emailIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf132" size:size]; }
+ (instancetype)eyeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf133" size:size]; }
+ (instancetype)eyeDisabledIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf306" size:size]; }
+ (instancetype)femaleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf278" size:size]; }
+ (instancetype)filingIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf134" size:size]; }
+ (instancetype)filmMarkerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf135" size:size]; }
+ (instancetype)fireballIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf319" size:size]; }
+ (instancetype)flagIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf279" size:size]; }
+ (instancetype)flameIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf31a" size:size]; }
+ (instancetype)flashIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf137" size:size]; }
+ (instancetype)flashOffIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf136" size:size]; }
+ (instancetype)flaskIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf138" size:size]; }
+ (instancetype)folderIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf139" size:size]; }
+ (instancetype)forkIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf27a" size:size]; }
+ (instancetype)forkRepoIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2c0" size:size]; }
+ (instancetype)forwardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf13a" size:size]; }
+ (instancetype)funnelIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf31b" size:size]; }
+ (instancetype)gameControllerAIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf13b" size:size]; }
+ (instancetype)gameControllerBIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf13c" size:size]; }
+ (instancetype)gearAIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf13d" size:size]; }
+ (instancetype)gearBIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf13e" size:size]; }
+ (instancetype)gridIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf13f" size:size]; }
+ (instancetype)hammerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf27b" size:size]; }
+ (instancetype)happyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf31c" size:size]; }
+ (instancetype)headphoneIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf140" size:size]; }
+ (instancetype)heartIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf141" size:size]; }
+ (instancetype)heartBrokenIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf31d" size:size]; }
+ (instancetype)helpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf143" size:size]; }
+ (instancetype)helpBuoyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf27c" size:size]; }
+ (instancetype)helpCircledIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf142" size:size]; }
+ (instancetype)homeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf144" size:size]; }
+ (instancetype)icecreamIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf27d" size:size]; }
+ (instancetype)iconSocialGooglePlusIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf146" size:size]; }
+ (instancetype)iconSocialGooglePlusOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf145" size:size]; }
+ (instancetype)imageIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf147" size:size]; }
+ (instancetype)imagesIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf148" size:size]; }
+ (instancetype)informationIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf14a" size:size]; }
+ (instancetype)informationCircledIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf149" size:size]; }
+ (instancetype)ionicIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf14b" size:size]; }
+ (instancetype)ios7AlarmIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf14d" size:size]; }
+ (instancetype)ios7AlarmOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf14c" size:size]; }
+ (instancetype)ios7AlbumsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf14f" size:size]; }
+ (instancetype)ios7AlbumsOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf14e" size:size]; }
+ (instancetype)ios7AmericanfootballIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf31f" size:size]; }
+ (instancetype)ios7AmericanfootballOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf31e" size:size]; }
+ (instancetype)ios7AnalyticsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf321" size:size]; }
+ (instancetype)ios7AnalyticsOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf320" size:size]; }
+ (instancetype)ios7ArrowBackIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf150" size:size]; }
+ (instancetype)ios7ArrowDownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf151" size:size]; }
+ (instancetype)ios7ArrowForwardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf152" size:size]; }
+ (instancetype)ios7ArrowLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf153" size:size]; }
+ (instancetype)ios7ArrowRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf154" size:size]; }
+ (instancetype)ios7ArrowThinDownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf27e" size:size]; }
+ (instancetype)ios7ArrowThinLeftIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf27f" size:size]; }
+ (instancetype)ios7ArrowThinRightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf280" size:size]; }
+ (instancetype)ios7ArrowThinUpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf281" size:size]; }
+ (instancetype)ios7ArrowUpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf155" size:size]; }
+ (instancetype)ios7AtIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf157" size:size]; }
+ (instancetype)ios7AtOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf156" size:size]; }
+ (instancetype)ios7BarcodeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf323" size:size]; }
+ (instancetype)ios7BarcodeOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf322" size:size]; }
+ (instancetype)ios7BaseballIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf325" size:size]; }
+ (instancetype)ios7BaseballOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf324" size:size]; }
+ (instancetype)ios7BasketballIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf327" size:size]; }
+ (instancetype)ios7BasketballOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf326" size:size]; }
+ (instancetype)ios7BellIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf159" size:size]; }
+ (instancetype)ios7BellOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf158" size:size]; }
+ (instancetype)ios7BoltIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf15b" size:size]; }
+ (instancetype)ios7BoltOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf15a" size:size]; }
+ (instancetype)ios7BookmarksIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf15d" size:size]; }
+ (instancetype)ios7BookmarksOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf15c" size:size]; }
+ (instancetype)ios7BoxIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf15f" size:size]; }
+ (instancetype)ios7BoxOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf15e" size:size]; }
+ (instancetype)ios7BriefcaseIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf283" size:size]; }
+ (instancetype)ios7BriefcaseOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf282" size:size]; }
+ (instancetype)ios7BrowsersIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf161" size:size]; }
+ (instancetype)ios7BrowsersOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf160" size:size]; }
+ (instancetype)ios7CalculatorIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf285" size:size]; }
+ (instancetype)ios7CalculatorOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf284" size:size]; }
+ (instancetype)ios7CalendarIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf163" size:size]; }
+ (instancetype)ios7CalendarOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf162" size:size]; }
+ (instancetype)ios7CameraIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf165" size:size]; }
+ (instancetype)ios7CameraOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf164" size:size]; }
+ (instancetype)ios7CartIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf167" size:size]; }
+ (instancetype)ios7CartOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf166" size:size]; }
+ (instancetype)ios7ChatboxesIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf169" size:size]; }
+ (instancetype)ios7ChatboxesOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf168" size:size]; }
+ (instancetype)ios7ChatbubbleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf16b" size:size]; }
+ (instancetype)ios7ChatbubbleOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf16a" size:size]; }
+ (instancetype)ios7CheckmarkIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf16e" size:size]; }
+ (instancetype)ios7CheckmarkEmptyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf16c" size:size]; }
+ (instancetype)ios7CheckmarkOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf16d" size:size]; }
+ (instancetype)ios7CircleFilledIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf16f" size:size]; }
+ (instancetype)ios7CircleOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf170" size:size]; }
+ (instancetype)ios7ClockIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf172" size:size]; }
+ (instancetype)ios7ClockOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf171" size:size]; }
+ (instancetype)ios7CloseIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2bc" size:size]; }
+ (instancetype)ios7CloseEmptyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2bd" size:size]; }
+ (instancetype)ios7CloseOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2bb" size:size]; }
+ (instancetype)ios7CloudIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf178" size:size]; }
+ (instancetype)ios7CloudDownloadIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf174" size:size]; }
+ (instancetype)ios7CloudDownloadOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf173" size:size]; }
+ (instancetype)ios7CloudOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf175" size:size]; }
+ (instancetype)ios7CloudUploadIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf177" size:size]; }
+ (instancetype)ios7CloudUploadOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf176" size:size]; }
+ (instancetype)ios7CloudyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf17a" size:size]; }
+ (instancetype)ios7CloudyNightIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf308" size:size]; }
+ (instancetype)ios7CloudyNightOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf307" size:size]; }
+ (instancetype)ios7CloudyOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf179" size:size]; }
+ (instancetype)ios7CogIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf17c" size:size]; }
+ (instancetype)ios7CogOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf17b" size:size]; }
+ (instancetype)ios7ComposeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf17e" size:size]; }
+ (instancetype)ios7ComposeOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf17d" size:size]; }
+ (instancetype)ios7ContactIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf180" size:size]; }
+ (instancetype)ios7ContactOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf17f" size:size]; }
+ (instancetype)ios7CopyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf182" size:size]; }
+ (instancetype)ios7CopyOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf181" size:size]; }
+ (instancetype)ios7DownloadIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf184" size:size]; }
+ (instancetype)ios7DownloadOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf183" size:size]; }
+ (instancetype)ios7DragIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf185" size:size]; }
+ (instancetype)ios7EmailIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf187" size:size]; }
+ (instancetype)ios7EmailOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf186" size:size]; }
+ (instancetype)ios7ExpandIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf30d" size:size]; }
+ (instancetype)ios7EyeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf189" size:size]; }
+ (instancetype)ios7EyeOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf188" size:size]; }
+ (instancetype)ios7FastforwardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf18b" size:size]; }
+ (instancetype)ios7FastforwardOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf18a" size:size]; }
+ (instancetype)ios7FilingIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf18d" size:size]; }
+ (instancetype)ios7FilingOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf18c" size:size]; }
+ (instancetype)ios7FilmIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf18f" size:size]; }
+ (instancetype)ios7FilmOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf18e" size:size]; }
+ (instancetype)ios7FlagIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf191" size:size]; }
+ (instancetype)ios7FlagOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf190" size:size]; }
+ (instancetype)ios7FolderIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf193" size:size]; }
+ (instancetype)ios7FolderOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf192" size:size]; }
+ (instancetype)ios7FootballIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf329" size:size]; }
+ (instancetype)ios7FootballOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf328" size:size]; }
+ (instancetype)ios7GearIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf195" size:size]; }
+ (instancetype)ios7GearOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf194" size:size]; }
+ (instancetype)ios7GlassesIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf197" size:size]; }
+ (instancetype)ios7GlassesOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf196" size:size]; }
+ (instancetype)ios7HeartIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf199" size:size]; }
+ (instancetype)ios7HeartOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf198" size:size]; }
+ (instancetype)ios7HelpIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf19c" size:size]; }
+ (instancetype)ios7HelpEmptyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf19a" size:size]; }
+ (instancetype)ios7HelpOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf19b" size:size]; }
+ (instancetype)ios7HomeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf32b" size:size]; }
+ (instancetype)ios7HomeOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf32a" size:size]; }
+ (instancetype)ios7InfiniteIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf19e" size:size]; }
+ (instancetype)ios7InfiniteOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf19d" size:size]; }
+ (instancetype)ios7InformationIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a1" size:size]; }
+ (instancetype)ios7InformationEmptyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf19f" size:size]; }
+ (instancetype)ios7InformationOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a0" size:size]; }
+ (instancetype)ios7IonicOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a2" size:size]; }
+ (instancetype)ios7KeypadIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a4" size:size]; }
+ (instancetype)ios7KeypadOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a3" size:size]; }
+ (instancetype)ios7LightbulbIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf287" size:size]; }
+ (instancetype)ios7LightbulbOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf286" size:size]; }
+ (instancetype)ios7LocationIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a6" size:size]; }
+ (instancetype)ios7LocationOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a5" size:size]; }
+ (instancetype)ios7LockedIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a8" size:size]; }
+ (instancetype)ios7LockedOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a7" size:size]; }
+ (instancetype)ios7LoopIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf32d" size:size]; }
+ (instancetype)ios7LoopStrongIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf32c" size:size]; }
+ (instancetype)ios7MedkitIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf289" size:size]; }
+ (instancetype)ios7MedkitOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf288" size:size]; }
+ (instancetype)ios7MicIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ab" size:size]; }
+ (instancetype)ios7MicOffIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1a9" size:size]; }
+ (instancetype)ios7MicOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1aa" size:size]; }
+ (instancetype)ios7MinusIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ae" size:size]; }
+ (instancetype)ios7MinusEmptyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ac" size:size]; }
+ (instancetype)ios7MinusOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ad" size:size]; }
+ (instancetype)ios7MonitorIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b0" size:size]; }
+ (instancetype)ios7MonitorOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1af" size:size]; }
+ (instancetype)ios7MoonIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b2" size:size]; }
+ (instancetype)ios7MoonOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b1" size:size]; }
+ (instancetype)ios7MoreIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b4" size:size]; }
+ (instancetype)ios7MoreOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b3" size:size]; }
+ (instancetype)ios7MusicalNoteIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b5" size:size]; }
+ (instancetype)ios7MusicalNotesIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b6" size:size]; }
+ (instancetype)ios7NavigateIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b8" size:size]; }
+ (instancetype)ios7NavigateOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b7" size:size]; }
+ (instancetype)ios7PaperIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf32f" size:size]; }
+ (instancetype)ios7PaperOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf32e" size:size]; }
+ (instancetype)ios7PaperplaneIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ba" size:size]; }
+ (instancetype)ios7PaperplaneOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1b9" size:size]; }
+ (instancetype)ios7PartlysunnyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1bc" size:size]; }
+ (instancetype)ios7PartlysunnyOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1bb" size:size]; }
+ (instancetype)ios7PauseIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1be" size:size]; }
+ (instancetype)ios7PauseOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1bd" size:size]; }
+ (instancetype)ios7PawIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf331" size:size]; }
+ (instancetype)ios7PawOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf330" size:size]; }
+ (instancetype)ios7PeopleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c0" size:size]; }
+ (instancetype)ios7PeopleOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1bf" size:size]; }
+ (instancetype)ios7PersonIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c2" size:size]; }
+ (instancetype)ios7PersonOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c1" size:size]; }
+ (instancetype)ios7PersonaddIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c4" size:size]; }
+ (instancetype)ios7PersonaddOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c3" size:size]; }
+ (instancetype)ios7PhotosIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c6" size:size]; }
+ (instancetype)ios7PhotosOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c5" size:size]; }
+ (instancetype)ios7PieIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf28b" size:size]; }
+ (instancetype)ios7PieOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf28a" size:size]; }
+ (instancetype)ios7PlayIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c8" size:size]; }
+ (instancetype)ios7PlayOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c7" size:size]; }
+ (instancetype)ios7PlusIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1cb" size:size]; }
+ (instancetype)ios7PlusEmptyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1c9" size:size]; }
+ (instancetype)ios7PlusOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ca" size:size]; }
+ (instancetype)ios7PricetagIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf28d" size:size]; }
+ (instancetype)ios7PricetagOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf28c" size:size]; }
+ (instancetype)ios7PricetagsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf333" size:size]; }
+ (instancetype)ios7PricetagsOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf332" size:size]; }
+ (instancetype)ios7PrinterIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1cd" size:size]; }
+ (instancetype)ios7PrinterOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1cc" size:size]; }
+ (instancetype)ios7PulseIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf335" size:size]; }
+ (instancetype)ios7PulseStrongIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf334" size:size]; }
+ (instancetype)ios7RainyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1cf" size:size]; }
+ (instancetype)ios7RainyOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ce" size:size]; }
+ (instancetype)ios7RecordingIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d1" size:size]; }
+ (instancetype)ios7RecordingOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d0" size:size]; }
+ (instancetype)ios7RedoIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d3" size:size]; }
+ (instancetype)ios7RedoOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d2" size:size]; }
+ (instancetype)ios7RefreshIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d6" size:size]; }
+ (instancetype)ios7RefreshEmptyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d4" size:size]; }
+ (instancetype)ios7RefreshOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d5" size:size]; }
+ (instancetype)ios7ReloadbeforeionIos7ReloadingIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf28e" size:size]; }
+ (instancetype)ios7ReverseCameraIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf337" size:size]; }
+ (instancetype)ios7ReverseCameraOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf336" size:size]; }
+ (instancetype)ios7RewindIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d8" size:size]; }
+ (instancetype)ios7RewindOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d7" size:size]; }
+ (instancetype)ios7SearchIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1da" size:size]; }
+ (instancetype)ios7SearchStrongIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1d9" size:size]; }
+ (instancetype)ios7SettingsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf339" size:size]; }
+ (instancetype)ios7SettingsStrongIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf338" size:size]; }
+ (instancetype)ios7ShrinkIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf30e" size:size]; }
+ (instancetype)ios7SkipbackwardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1dc" size:size]; }
+ (instancetype)ios7SkipbackwardOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1db" size:size]; }
+ (instancetype)ios7SkipforwardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1de" size:size]; }
+ (instancetype)ios7SkipforwardOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1dd" size:size]; }
+ (instancetype)ios7SnowyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf309" size:size]; }
+ (instancetype)ios7SpeedometerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf290" size:size]; }
+ (instancetype)ios7SpeedometerOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf28f" size:size]; }
+ (instancetype)ios7StarIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e0" size:size]; }
+ (instancetype)ios7StarHalfIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf33a" size:size]; }
+ (instancetype)ios7StarOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1df" size:size]; }
+ (instancetype)ios7StopwatchIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e2" size:size]; }
+ (instancetype)ios7StopwatchOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e1" size:size]; }
+ (instancetype)ios7SunnyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e4" size:size]; }
+ (instancetype)ios7SunnyOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e3" size:size]; }
+ (instancetype)ios7TelephoneIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e6" size:size]; }
+ (instancetype)ios7TelephoneOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e5" size:size]; }
+ (instancetype)ios7TennisballIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf33c" size:size]; }
+ (instancetype)ios7TennisballOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf33b" size:size]; }
+ (instancetype)ios7ThunderstormIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e8" size:size]; }
+ (instancetype)ios7ThunderstormOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e7" size:size]; }
+ (instancetype)ios7TimeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf292" size:size]; }
+ (instancetype)ios7TimeOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf291" size:size]; }
+ (instancetype)ios7TimerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ea" size:size]; }
+ (instancetype)ios7TimerOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1e9" size:size]; }
+ (instancetype)ios7ToggleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf33e" size:size]; }
+ (instancetype)ios7ToggleOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf33d" size:size]; }
+ (instancetype)ios7TrashIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ec" size:size]; }
+ (instancetype)ios7TrashOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1eb" size:size]; }
+ (instancetype)ios7UndoIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ee" size:size]; }
+ (instancetype)ios7UndoOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ed" size:size]; }
+ (instancetype)ios7UnlockedIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f0" size:size]; }
+ (instancetype)ios7UnlockedOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ef" size:size]; }
+ (instancetype)ios7UploadIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f2" size:size]; }
+ (instancetype)ios7UploadOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f1" size:size]; }
+ (instancetype)ios7VideocamIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f4" size:size]; }
+ (instancetype)ios7VideocamOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f3" size:size]; }
+ (instancetype)ios7VolumeHighIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f5" size:size]; }
+ (instancetype)ios7VolumeLowIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f6" size:size]; }
+ (instancetype)ios7WineglassIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf294" size:size]; }
+ (instancetype)ios7WineglassOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf293" size:size]; }
+ (instancetype)ios7WorldIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f8" size:size]; }
+ (instancetype)ios7WorldOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f7" size:size]; }
+ (instancetype)ipadIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1f9" size:size]; }
+ (instancetype)iphoneIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1fa" size:size]; }
+ (instancetype)ipodIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1fb" size:size]; }
+ (instancetype)jetIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf295" size:size]; }
+ (instancetype)keyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf296" size:size]; }
+ (instancetype)knifeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf297" size:size]; }
+ (instancetype)laptopIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1fc" size:size]; }
+ (instancetype)leafIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1fd" size:size]; }
+ (instancetype)levelsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf298" size:size]; }
+ (instancetype)lightbulbIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf299" size:size]; }
+ (instancetype)linkIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1fe" size:size]; }
+ (instancetype)loadAbeforeionLoadingAIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf29a" size:size]; }
+ (instancetype)loadBbeforeionLoadingBIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf29b" size:size]; }
+ (instancetype)loadCbeforeionLoadingCIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf29c" size:size]; }
+ (instancetype)loadDbeforeionLoadingDIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf29d" size:size]; }
+ (instancetype)locationIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf1ff" size:size]; }
+ (instancetype)lockedIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf200" size:size]; }
+ (instancetype)logInIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf29e" size:size]; }
+ (instancetype)logOutIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf29f" size:size]; }
+ (instancetype)loopbeforeionLoopingIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf201" size:size]; }
+ (instancetype)magnetIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2a0" size:size]; }
+ (instancetype)maleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2a1" size:size]; }
+ (instancetype)manIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf202" size:size]; }
+ (instancetype)mapIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf203" size:size]; }
+ (instancetype)medkitIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2a2" size:size]; }
+ (instancetype)mergeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf33f" size:size]; }
+ (instancetype)micAIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf204" size:size]; }
+ (instancetype)micBIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf205" size:size]; }
+ (instancetype)micCIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf206" size:size]; }
+ (instancetype)minusIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf209" size:size]; }
+ (instancetype)minusCircledIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf207" size:size]; }
+ (instancetype)minusRoundIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf208" size:size]; }
+ (instancetype)modelSIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2c1" size:size]; }
+ (instancetype)monitorIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf20a" size:size]; }
+ (instancetype)moreIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf20b" size:size]; }
+ (instancetype)mouseIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf340" size:size]; }
+ (instancetype)musicNoteIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf20c" size:size]; }
+ (instancetype)naviconIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf20e" size:size]; }
+ (instancetype)naviconRoundIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf20d" size:size]; }
+ (instancetype)navigateIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2a3" size:size]; }
+ (instancetype)networkIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf341" size:size]; }
+ (instancetype)noSmokingIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2c2" size:size]; }
+ (instancetype)nuclearIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2a4" size:size]; }
+ (instancetype)outletIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf342" size:size]; }
+ (instancetype)paperAirplaneIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2c3" size:size]; }
+ (instancetype)paperclipIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf20f" size:size]; }
+ (instancetype)pauseIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf210" size:size]; }
+ (instancetype)personIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf213" size:size]; }
+ (instancetype)personAddIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf211" size:size]; }
+ (instancetype)personStalkerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf212" size:size]; }
+ (instancetype)pieGraphIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2a5" size:size]; }
+ (instancetype)pinIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2a6" size:size]; }
+ (instancetype)pinpointIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2a7" size:size]; }
+ (instancetype)pizzaIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2a8" size:size]; }
+ (instancetype)planeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf214" size:size]; }
+ (instancetype)planetIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf343" size:size]; }
+ (instancetype)playIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf215" size:size]; }
+ (instancetype)playstationIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf30a" size:size]; }
+ (instancetype)plusIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf218" size:size]; }
+ (instancetype)plusCircledIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf216" size:size]; }
+ (instancetype)plusRoundIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf217" size:size]; }
+ (instancetype)podiumIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf344" size:size]; }
+ (instancetype)poundIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf219" size:size]; }
+ (instancetype)powerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2a9" size:size]; }
+ (instancetype)pricetagIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2aa" size:size]; }
+ (instancetype)pricetagsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2ab" size:size]; }
+ (instancetype)printerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf21a" size:size]; }
+ (instancetype)pullRequestIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf345" size:size]; }
+ (instancetype)qrScannerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf346" size:size]; }
+ (instancetype)quoteIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf347" size:size]; }
+ (instancetype)radioWavesIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2ac" size:size]; }
+ (instancetype)recordIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf21b" size:size]; }
+ (instancetype)refreshbeforeionRefreshingIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf21c" size:size]; }
+ (instancetype)replyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf21e" size:size]; }
+ (instancetype)replyAllIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf21d" size:size]; }
+ (instancetype)ribbonAIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf348" size:size]; }
+ (instancetype)ribbonBIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf349" size:size]; }
+ (instancetype)sadIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf34a" size:size]; }
+ (instancetype)scissorsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf34b" size:size]; }
+ (instancetype)searchIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf21f" size:size]; }
+ (instancetype)settingsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2ad" size:size]; }
+ (instancetype)shareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf220" size:size]; }
+ (instancetype)shuffleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf221" size:size]; }
+ (instancetype)skipBackwardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf222" size:size]; }
+ (instancetype)skipForwardIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf223" size:size]; }
+ (instancetype)socialAndroidIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf225" size:size]; }
+ (instancetype)socialAndroidOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf224" size:size]; }
+ (instancetype)socialAppleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf227" size:size]; }
+ (instancetype)socialAppleOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf226" size:size]; }
+ (instancetype)socialBitcoinIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2af" size:size]; }
+ (instancetype)socialBitcoinOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2ae" size:size]; }
+ (instancetype)socialBufferIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf229" size:size]; }
+ (instancetype)socialBufferOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf228" size:size]; }
+ (instancetype)socialDesignernewsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf22b" size:size]; }
+ (instancetype)socialDesignernewsOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf22a" size:size]; }
+ (instancetype)socialDribbbleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf22d" size:size]; }
+ (instancetype)socialDribbbleOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf22c" size:size]; }
+ (instancetype)socialDropboxIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf22f" size:size]; }
+ (instancetype)socialDropboxOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf22e" size:size]; }
+ (instancetype)socialFacebookIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf231" size:size]; }
+ (instancetype)socialFacebookOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf230" size:size]; }
+ (instancetype)socialFoursquareIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf34d" size:size]; }
+ (instancetype)socialFoursquareOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf34c" size:size]; }
+ (instancetype)socialFreebsdDevilIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2c4" size:size]; }
+ (instancetype)socialGithubIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf233" size:size]; }
+ (instancetype)socialGithubOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf232" size:size]; }
+ (instancetype)socialGoogleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf34f" size:size]; }
+ (instancetype)socialGoogleOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf34e" size:size]; }
+ (instancetype)socialGoogleplusIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf235" size:size]; }
+ (instancetype)socialGoogleplusOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf234" size:size]; }
+ (instancetype)socialHackernewsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf237" size:size]; }
+ (instancetype)socialHackernewsOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf236" size:size]; }
+ (instancetype)socialInstagramIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf351" size:size]; }
+ (instancetype)socialInstagramOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf350" size:size]; }
+ (instancetype)socialLinkedinIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf239" size:size]; }
+ (instancetype)socialLinkedinOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf238" size:size]; }
+ (instancetype)socialPinterestIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2b1" size:size]; }
+ (instancetype)socialPinterestOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2b0" size:size]; }
+ (instancetype)socialRedditIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf23b" size:size]; }
+ (instancetype)socialRedditOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf23a" size:size]; }
+ (instancetype)socialRssIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf23d" size:size]; }
+ (instancetype)socialRssOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf23c" size:size]; }
+ (instancetype)socialSkypeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf23f" size:size]; }
+ (instancetype)socialSkypeOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf23e" size:size]; }
+ (instancetype)socialTumblrIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf241" size:size]; }
+ (instancetype)socialTumblrOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf240" size:size]; }
+ (instancetype)socialTuxIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2c5" size:size]; }
+ (instancetype)socialTwitterIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf243" size:size]; }
+ (instancetype)socialTwitterOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf242" size:size]; }
+ (instancetype)socialUsdIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf353" size:size]; }
+ (instancetype)socialUsdOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf352" size:size]; }
+ (instancetype)socialVimeoIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf245" size:size]; }
+ (instancetype)socialVimeoOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf244" size:size]; }
+ (instancetype)socialWindowsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf247" size:size]; }
+ (instancetype)socialWindowsOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf246" size:size]; }
+ (instancetype)socialWordpressIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf249" size:size]; }
+ (instancetype)socialWordpressOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf248" size:size]; }
+ (instancetype)socialYahooIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf24b" size:size]; }
+ (instancetype)socialYahooOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf24a" size:size]; }
+ (instancetype)socialYoutubeIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf24d" size:size]; }
+ (instancetype)socialYoutubeOutlineIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf24c" size:size]; }
+ (instancetype)speakerphoneIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2b2" size:size]; }
+ (instancetype)speedometerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2b3" size:size]; }
+ (instancetype)spoonIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2b4" size:size]; }
+ (instancetype)starIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf24e" size:size]; }
+ (instancetype)statsBarsIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2b5" size:size]; }
+ (instancetype)steamIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf30b" size:size]; }
+ (instancetype)stopIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf24f" size:size]; }
+ (instancetype)thermometerIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2b6" size:size]; }
+ (instancetype)thumbsdownIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf250" size:size]; }
+ (instancetype)thumbsupIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf251" size:size]; }
+ (instancetype)toggleIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf355" size:size]; }
+ (instancetype)toggleFilledIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf354" size:size]; }
+ (instancetype)trashAIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf252" size:size]; }
+ (instancetype)trashBIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf253" size:size]; }
+ (instancetype)trophyIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf356" size:size]; }
+ (instancetype)umbrellaIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2b7" size:size]; }
+ (instancetype)universityIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf357" size:size]; }
+ (instancetype)unlockedIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf254" size:size]; }
+ (instancetype)uploadIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf255" size:size]; }
+ (instancetype)usbIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2b8" size:size]; }
+ (instancetype)videocameraIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf256" size:size]; }
+ (instancetype)volumeHighIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf257" size:size]; }
+ (instancetype)volumeLowIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf258" size:size]; }
+ (instancetype)volumeMediumIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf259" size:size]; }
+ (instancetype)volumeMuteIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf25a" size:size]; }
+ (instancetype)wandIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf358" size:size]; }
+ (instancetype)waterdropIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf25b" size:size]; }
+ (instancetype)wifiIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf25c" size:size]; }
+ (instancetype)wineglassIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2b9" size:size]; }
+ (instancetype)womanIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf25d" size:size]; }
+ (instancetype)wrenchIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf2ba" size:size]; }
+ (instancetype)xboxIconWithSize:(CGFloat)size { return [self iconWithCode:@"\uf30c" size:size]; }

+ (NSDictionary *)allIcons {
    return @{
             @"\uf101" : @"alert",
             @"\uf100" : @"alertCircled",
             @"\uf2c7" : @"androidAdd",
             @"\uf2c6" : @"androidAddContact",
             @"\uf2c8" : @"androidAlarm",
             @"\uf2c9" : @"androidArchive",
             @"\uf2ca" : @"androidArrowBack",
             @"\uf2cb" : @"androidArrowDownLeft",
             @"\uf2cc" : @"androidArrowDownRight",
             @"\uf30f" : @"androidArrowForward",
             @"\uf2cd" : @"androidArrowUpLeft",
             @"\uf2ce" : @"androidArrowUpRight",
             @"\uf2cf" : @"androidBattery",
             @"\uf2d0" : @"androidBook",
             @"\uf2d1" : @"androidCalendar",
             @"\uf2d2" : @"androidCall",
             @"\uf2d3" : @"androidCamera",
             @"\uf2d4" : @"androidChat",
             @"\uf2d5" : @"androidCheckmark",
             @"\uf2d6" : @"androidClock",
             @"\uf2d7" : @"androidClose",
             @"\uf2d8" : @"androidContact",
             @"\uf2d9" : @"androidContacts",
             @"\uf2da" : @"androidData",
             @"\uf2db" : @"androidDeveloper",
             @"\uf2dc" : @"androidDisplay",
             @"\uf2dd" : @"androidDownload",
             @"\uf310" : @"androidDrawer",
             @"\uf2de" : @"androidDropdown",
             @"\uf2df" : @"androidEarth",
             @"\uf2e0" : @"androidFolder",
             @"\uf2e1" : @"androidForums",
             @"\uf2e2" : @"androidFriends",
             @"\uf2e3" : @"androidHand",
             @"\uf2e4" : @"androidImage",
             @"\uf2e5" : @"androidInbox",
             @"\uf2e6" : @"androidInformation",
             @"\uf2e7" : @"androidKeypad",
             @"\uf2e8" : @"androidLightbulb",
             @"\uf2e9" : @"androidLocate",
             @"\uf2ea" : @"androidLocation",
             @"\uf2eb" : @"androidMail",
             @"\uf2ec" : @"androidMicrophone",
             @"\uf2ed" : @"androidMixer",
             @"\uf2ee" : @"androidMore",
             @"\uf2ef" : @"androidNote",
             @"\uf2f0" : @"androidPlaystore",
             @"\uf2f1" : @"androidPrinter",
             @"\uf2f2" : @"androidPromotion",
             @"\uf2f3" : @"androidReminder",
             @"\uf2f4" : @"androidRemove",
             @"\uf2f5" : @"androidSearch",
             @"\uf2f6" : @"androidSend",
             @"\uf2f7" : @"androidSettings",
             @"\uf2f8" : @"androidShare",
             @"\uf2fa" : @"androidSocial",
             @"\uf2f9" : @"androidSocialUser",
             @"\uf2fb" : @"androidSort",
             @"\uf311" : @"androidStairDrawer",
             @"\uf2fc" : @"androidStar",
             @"\uf2fd" : @"androidStopwatch",
             @"\uf2fe" : @"androidStorage",
             @"\uf2ff" : @"androidSystemBack",
             @"\uf300" : @"androidSystemHome",
             @"\uf301" : @"androidSystemWindows",
             @"\uf302" : @"androidTimer",
             @"\uf303" : @"androidTrash",
             @"\uf312" : @"androidUserMenu",
             @"\uf304" : @"androidVolume",
             @"\uf305" : @"androidWifi",
             @"\uf313" : @"aperture",
             @"\uf102" : @"archive",
             @"\uf103" : @"arrowDownA",
             @"\uf104" : @"arrowDownB",
             @"\uf105" : @"arrowDownC",
             @"\uf25e" : @"arrowExpand",
             @"\uf25f" : @"arrowGraphDownLeft",
             @"\uf260" : @"arrowGraphDownRight",
             @"\uf261" : @"arrowGraphUpLeft",
             @"\uf262" : @"arrowGraphUpRight",
             @"\uf106" : @"arrowLeftA",
             @"\uf107" : @"arrowLeftB",
             @"\uf108" : @"arrowLeftC",
             @"\uf263" : @"arrowMove",
             @"\uf264" : @"arrowResize",
             @"\uf265" : @"arrowReturnLeft",
             @"\uf266" : @"arrowReturnRight",
             @"\uf109" : @"arrowRightA",
             @"\uf10a" : @"arrowRightB",
             @"\uf10b" : @"arrowRightC",
             @"\uf267" : @"arrowShrink",
             @"\uf268" : @"arrowSwap",
             @"\uf10c" : @"arrowUpA",
             @"\uf10d" : @"arrowUpB",
             @"\uf10e" : @"arrowUpC",
             @"\uf314" : @"asterisk",
             @"\uf10f" : @"at",
             @"\uf110" : @"bag",
             @"\uf111" : @"batteryCharging",
             @"\uf112" : @"batteryEmpty",
             @"\uf113" : @"batteryFull",
             @"\uf114" : @"batteryHalf",
             @"\uf115" : @"batteryLow",
             @"\uf269" : @"beaker",
             @"\uf26a" : @"beer",
             @"\uf116" : @"bluetooth",
             @"\uf315" : @"bonfire",
             @"\uf26b" : @"bookmark",
             @"\uf26c" : @"briefcase",
             @"\uf2be" : @"bug",
             @"\uf26d" : @"calculator",
             @"\uf117" : @"calendar",
             @"\uf118" : @"camera",
             @"\uf119" : @"card",
             @"\uf316" : @"cash",
             @"\uf11b" : @"chatbox",
             @"\uf11a" : @"chatboxWorking",
             @"\uf11c" : @"chatboxes",
             @"\uf11e" : @"chatbubble",
             @"\uf11d" : @"chatbubbleWorking",
             @"\uf11f" : @"chatbubbles",
             @"\uf122" : @"checkmark",
             @"\uf120" : @"checkmarkCircled",
             @"\uf121" : @"checkmarkRound",
             @"\uf123" : @"chevronDown",
             @"\uf124" : @"chevronLeft",
             @"\uf125" : @"chevronRight",
             @"\uf126" : @"chevronUp",
             @"\uf127" : @"clipboard",
             @"\uf26e" : @"clock",
             @"\uf12a" : @"close",
             @"\uf128" : @"closeCircled",
             @"\uf129" : @"closeRound",
             @"\uf317" : @"closedCaptioning",
             @"\uf12b" : @"cloud",
             @"\uf271" : @"code",
             @"\uf26f" : @"codeDownload",
             @"\uf270" : @"codeWorking",
             @"\uf272" : @"coffee",
             @"\uf273" : @"compass",
             @"\uf12c" : @"compose",
             @"\uf274" : @"connectionBars",
             @"\uf275" : @"contrast",
             @"\uf318" : @"cube",
             @"\uf12d" : @"disc",
             @"\uf12f" : @"document",
             @"\uf12e" : @"documentText",
             @"\uf130" : @"drag",
             @"\uf276" : @"earth",
             @"\uf2bf" : @"edit",
             @"\uf277" : @"egg",
             @"\uf131" : @"eject",
             @"\uf132" : @"email",
             @"\uf133" : @"eye",
             @"\uf306" : @"eyeDisabled",
             @"\uf278" : @"female",
             @"\uf134" : @"filing",
             @"\uf135" : @"filmMarker",
             @"\uf319" : @"fireball",
             @"\uf279" : @"flag",
             @"\uf31a" : @"flame",
             @"\uf137" : @"flash",
             @"\uf136" : @"flashOff",
             @"\uf138" : @"flask",
             @"\uf139" : @"folder",
             @"\uf27a" : @"fork",
             @"\uf2c0" : @"forkRepo",
             @"\uf13a" : @"forward",
             @"\uf31b" : @"funnel",
             @"\uf13b" : @"gameControllerA",
             @"\uf13c" : @"gameControllerB",
             @"\uf13d" : @"gearA",
             @"\uf13e" : @"gearB",
             @"\uf13f" : @"grid",
             @"\uf27b" : @"hammer",
             @"\uf31c" : @"happy",
             @"\uf140" : @"headphone",
             @"\uf141" : @"heart",
             @"\uf31d" : @"heartBroken",
             @"\uf143" : @"help",
             @"\uf27c" : @"helpBuoy",
             @"\uf142" : @"helpCircled",
             @"\uf144" : @"home",
             @"\uf27d" : @"icecream",
             @"\uf146" : @"iconSocialGooglePlus",
             @"\uf145" : @"iconSocialGooglePlusOutline",
             @"\uf147" : @"image",
             @"\uf148" : @"images",
             @"\uf14a" : @"information",
             @"\uf149" : @"informationCircled",
             @"\uf14b" : @"ionic",
             @"\uf14d" : @"ios7Alarm",
             @"\uf14c" : @"ios7AlarmOutline",
             @"\uf14f" : @"ios7Albums",
             @"\uf14e" : @"ios7AlbumsOutline",
             @"\uf31f" : @"ios7Americanfootball",
             @"\uf31e" : @"ios7AmericanfootballOutline",
             @"\uf321" : @"ios7Analytics",
             @"\uf320" : @"ios7AnalyticsOutline",
             @"\uf150" : @"ios7ArrowBack",
             @"\uf151" : @"ios7ArrowDown",
             @"\uf152" : @"ios7ArrowForward",
             @"\uf153" : @"ios7ArrowLeft",
             @"\uf154" : @"ios7ArrowRight",
             @"\uf27e" : @"ios7ArrowThinDown",
             @"\uf27f" : @"ios7ArrowThinLeft",
             @"\uf280" : @"ios7ArrowThinRight",
             @"\uf281" : @"ios7ArrowThinUp",
             @"\uf155" : @"ios7ArrowUp",
             @"\uf157" : @"ios7At",
             @"\uf156" : @"ios7AtOutline",
             @"\uf323" : @"ios7Barcode",
             @"\uf322" : @"ios7BarcodeOutline",
             @"\uf325" : @"ios7Baseball",
             @"\uf324" : @"ios7BaseballOutline",
             @"\uf327" : @"ios7Basketball",
             @"\uf326" : @"ios7BasketballOutline",
             @"\uf159" : @"ios7Bell",
             @"\uf158" : @"ios7BellOutline",
             @"\uf15b" : @"ios7Bolt",
             @"\uf15a" : @"ios7BoltOutline",
             @"\uf15d" : @"ios7Bookmarks",
             @"\uf15c" : @"ios7BookmarksOutline",
             @"\uf15f" : @"ios7Box",
             @"\uf15e" : @"ios7BoxOutline",
             @"\uf283" : @"ios7Briefcase",
             @"\uf282" : @"ios7BriefcaseOutline",
             @"\uf161" : @"ios7Browsers",
             @"\uf160" : @"ios7BrowsersOutline",
             @"\uf285" : @"ios7Calculator",
             @"\uf284" : @"ios7CalculatorOutline",
             @"\uf163" : @"ios7Calendar",
             @"\uf162" : @"ios7CalendarOutline",
             @"\uf165" : @"ios7Camera",
             @"\uf164" : @"ios7CameraOutline",
             @"\uf167" : @"ios7Cart",
             @"\uf166" : @"ios7CartOutline",
             @"\uf169" : @"ios7Chatboxes",
             @"\uf168" : @"ios7ChatboxesOutline",
             @"\uf16b" : @"ios7Chatbubble",
             @"\uf16a" : @"ios7ChatbubbleOutline",
             @"\uf16e" : @"ios7Checkmark",
             @"\uf16c" : @"ios7CheckmarkEmpty",
             @"\uf16d" : @"ios7CheckmarkOutline",
             @"\uf16f" : @"ios7CircleFilled",
             @"\uf170" : @"ios7CircleOutline",
             @"\uf172" : @"ios7Clock",
             @"\uf171" : @"ios7ClockOutline",
             @"\uf2bc" : @"ios7Close",
             @"\uf2bd" : @"ios7CloseEmpty",
             @"\uf2bb" : @"ios7CloseOutline",
             @"\uf178" : @"ios7Cloud",
             @"\uf174" : @"ios7CloudDownload",
             @"\uf173" : @"ios7CloudDownloadOutline",
             @"\uf175" : @"ios7CloudOutline",
             @"\uf177" : @"ios7CloudUpload",
             @"\uf176" : @"ios7CloudUploadOutline",
             @"\uf17a" : @"ios7Cloudy",
             @"\uf308" : @"ios7CloudyNight",
             @"\uf307" : @"ios7CloudyNightOutline",
             @"\uf179" : @"ios7CloudyOutline",
             @"\uf17c" : @"ios7Cog",
             @"\uf17b" : @"ios7CogOutline",
             @"\uf17e" : @"ios7Compose",
             @"\uf17d" : @"ios7ComposeOutline",
             @"\uf180" : @"ios7Contact",
             @"\uf17f" : @"ios7ContactOutline",
             @"\uf182" : @"ios7Copy",
             @"\uf181" : @"ios7CopyOutline",
             @"\uf184" : @"ios7Download",
             @"\uf183" : @"ios7DownloadOutline",
             @"\uf185" : @"ios7Drag",
             @"\uf187" : @"ios7Email",
             @"\uf186" : @"ios7EmailOutline",
             @"\uf30d" : @"ios7Expand",
             @"\uf189" : @"ios7Eye",
             @"\uf188" : @"ios7EyeOutline",
             @"\uf18b" : @"ios7Fastforward",
             @"\uf18a" : @"ios7FastforwardOutline",
             @"\uf18d" : @"ios7Filing",
             @"\uf18c" : @"ios7FilingOutline",
             @"\uf18f" : @"ios7Film",
             @"\uf18e" : @"ios7FilmOutline",
             @"\uf191" : @"ios7Flag",
             @"\uf190" : @"ios7FlagOutline",
             @"\uf193" : @"ios7Folder",
             @"\uf192" : @"ios7FolderOutline",
             @"\uf329" : @"ios7Football",
             @"\uf328" : @"ios7FootballOutline",
             @"\uf195" : @"ios7Gear",
             @"\uf194" : @"ios7GearOutline",
             @"\uf197" : @"ios7Glasses",
             @"\uf196" : @"ios7GlassesOutline",
             @"\uf199" : @"ios7Heart",
             @"\uf198" : @"ios7HeartOutline",
             @"\uf19c" : @"ios7Help",
             @"\uf19a" : @"ios7HelpEmpty",
             @"\uf19b" : @"ios7HelpOutline",
             @"\uf32b" : @"ios7Home",
             @"\uf32a" : @"ios7HomeOutline",
             @"\uf19e" : @"ios7Infinite",
             @"\uf19d" : @"ios7InfiniteOutline",
             @"\uf1a1" : @"ios7Information",
             @"\uf19f" : @"ios7InformationEmpty",
             @"\uf1a0" : @"ios7InformationOutline",
             @"\uf1a2" : @"ios7IonicOutline",
             @"\uf1a4" : @"ios7Keypad",
             @"\uf1a3" : @"ios7KeypadOutline",
             @"\uf287" : @"ios7Lightbulb",
             @"\uf286" : @"ios7LightbulbOutline",
             @"\uf1a6" : @"ios7Location",
             @"\uf1a5" : @"ios7LocationOutline",
             @"\uf1a8" : @"ios7Locked",
             @"\uf1a7" : @"ios7LockedOutline",
             @"\uf32d" : @"ios7Loop",
             @"\uf32c" : @"ios7LoopStrong",
             @"\uf289" : @"ios7Medkit",
             @"\uf288" : @"ios7MedkitOutline",
             @"\uf1ab" : @"ios7Mic",
             @"\uf1a9" : @"ios7MicOff",
             @"\uf1aa" : @"ios7MicOutline",
             @"\uf1ae" : @"ios7Minus",
             @"\uf1ac" : @"ios7MinusEmpty",
             @"\uf1ad" : @"ios7MinusOutline",
             @"\uf1b0" : @"ios7Monitor",
             @"\uf1af" : @"ios7MonitorOutline",
             @"\uf1b2" : @"ios7Moon",
             @"\uf1b1" : @"ios7MoonOutline",
             @"\uf1b4" : @"ios7More",
             @"\uf1b3" : @"ios7MoreOutline",
             @"\uf1b5" : @"ios7MusicalNote",
             @"\uf1b6" : @"ios7MusicalNotes",
             @"\uf1b8" : @"ios7Navigate",
             @"\uf1b7" : @"ios7NavigateOutline",
             @"\uf32f" : @"ios7Paper",
             @"\uf32e" : @"ios7PaperOutline",
             @"\uf1ba" : @"ios7Paperplane",
             @"\uf1b9" : @"ios7PaperplaneOutline",
             @"\uf1bc" : @"ios7Partlysunny",
             @"\uf1bb" : @"ios7PartlysunnyOutline",
             @"\uf1be" : @"ios7Pause",
             @"\uf1bd" : @"ios7PauseOutline",
             @"\uf331" : @"ios7Paw",
             @"\uf330" : @"ios7PawOutline",
             @"\uf1c0" : @"ios7People",
             @"\uf1bf" : @"ios7PeopleOutline",
             @"\uf1c2" : @"ios7Person",
             @"\uf1c1" : @"ios7PersonOutline",
             @"\uf1c4" : @"ios7Personadd",
             @"\uf1c3" : @"ios7PersonaddOutline",
             @"\uf1c6" : @"ios7Photos",
             @"\uf1c5" : @"ios7PhotosOutline",
             @"\uf28b" : @"ios7Pie",
             @"\uf28a" : @"ios7PieOutline",
             @"\uf1c8" : @"ios7Play",
             @"\uf1c7" : @"ios7PlayOutline",
             @"\uf1cb" : @"ios7Plus",
             @"\uf1c9" : @"ios7PlusEmpty",
             @"\uf1ca" : @"ios7PlusOutline",
             @"\uf28d" : @"ios7Pricetag",
             @"\uf28c" : @"ios7PricetagOutline",
             @"\uf333" : @"ios7Pricetags",
             @"\uf332" : @"ios7PricetagsOutline",
             @"\uf1cd" : @"ios7Printer",
             @"\uf1cc" : @"ios7PrinterOutline",
             @"\uf335" : @"ios7Pulse",
             @"\uf334" : @"ios7PulseStrong",
             @"\uf1cf" : @"ios7Rainy",
             @"\uf1ce" : @"ios7RainyOutline",
             @"\uf1d1" : @"ios7Recording",
             @"\uf1d0" : @"ios7RecordingOutline",
             @"\uf1d3" : @"ios7Redo",
             @"\uf1d2" : @"ios7RedoOutline",
             @"\uf1d6" : @"ios7Refresh",
             @"\uf1d4" : @"ios7RefreshEmpty",
             @"\uf1d5" : @"ios7RefreshOutline",
             @"\uf28e" : @"ios7ReloadbeforeionIos7Reloading",
             @"\uf337" : @"ios7ReverseCamera",
             @"\uf336" : @"ios7ReverseCameraOutline",
             @"\uf1d8" : @"ios7Rewind",
             @"\uf1d7" : @"ios7RewindOutline",
             @"\uf1da" : @"ios7Search",
             @"\uf1d9" : @"ios7SearchStrong",
             @"\uf339" : @"ios7Settings",
             @"\uf338" : @"ios7SettingsStrong",
             @"\uf30e" : @"ios7Shrink",
             @"\uf1dc" : @"ios7Skipbackward",
             @"\uf1db" : @"ios7SkipbackwardOutline",
             @"\uf1de" : @"ios7Skipforward",
             @"\uf1dd" : @"ios7SkipforwardOutline",
             @"\uf309" : @"ios7Snowy",
             @"\uf290" : @"ios7Speedometer",
             @"\uf28f" : @"ios7SpeedometerOutline",
             @"\uf1e0" : @"ios7Star",
             @"\uf33a" : @"ios7StarHalf",
             @"\uf1df" : @"ios7StarOutline",
             @"\uf1e2" : @"ios7Stopwatch",
             @"\uf1e1" : @"ios7StopwatchOutline",
             @"\uf1e4" : @"ios7Sunny",
             @"\uf1e3" : @"ios7SunnyOutline",
             @"\uf1e6" : @"ios7Telephone",
             @"\uf1e5" : @"ios7TelephoneOutline",
             @"\uf33c" : @"ios7Tennisball",
             @"\uf33b" : @"ios7TennisballOutline",
             @"\uf1e8" : @"ios7Thunderstorm",
             @"\uf1e7" : @"ios7ThunderstormOutline",
             @"\uf292" : @"ios7Time",
             @"\uf291" : @"ios7TimeOutline",
             @"\uf1ea" : @"ios7Timer",
             @"\uf1e9" : @"ios7TimerOutline",
             @"\uf33e" : @"ios7Toggle",
             @"\uf33d" : @"ios7ToggleOutline",
             @"\uf1ec" : @"ios7Trash",
             @"\uf1eb" : @"ios7TrashOutline",
             @"\uf1ee" : @"ios7Undo",
             @"\uf1ed" : @"ios7UndoOutline",
             @"\uf1f0" : @"ios7Unlocked",
             @"\uf1ef" : @"ios7UnlockedOutline",
             @"\uf1f2" : @"ios7Upload",
             @"\uf1f1" : @"ios7UploadOutline",
             @"\uf1f4" : @"ios7Videocam",
             @"\uf1f3" : @"ios7VideocamOutline",
             @"\uf1f5" : @"ios7VolumeHigh",
             @"\uf1f6" : @"ios7VolumeLow",
             @"\uf294" : @"ios7Wineglass",
             @"\uf293" : @"ios7WineglassOutline",
             @"\uf1f8" : @"ios7World",
             @"\uf1f7" : @"ios7WorldOutline",
             @"\uf1f9" : @"ipad",
             @"\uf1fa" : @"iphone",
             @"\uf1fb" : @"ipod",
             @"\uf295" : @"jet",
             @"\uf296" : @"key",
             @"\uf297" : @"knife",
             @"\uf1fc" : @"laptop",
             @"\uf1fd" : @"leaf",
             @"\uf298" : @"levels",
             @"\uf299" : @"lightbulb",
             @"\uf1fe" : @"link",
             @"\uf29a" : @"loadAbeforeionLoadingA",
             @"\uf29b" : @"loadBbeforeionLoadingB",
             @"\uf29c" : @"loadCbeforeionLoadingC",
             @"\uf29d" : @"loadDbeforeionLoadingD",
             @"\uf1ff" : @"location",
             @"\uf200" : @"locked",
             @"\uf29e" : @"logIn",
             @"\uf29f" : @"logOut",
             @"\uf201" : @"loopbeforeionLooping",
             @"\uf2a0" : @"magnet",
             @"\uf2a1" : @"male",
             @"\uf202" : @"man",
             @"\uf203" : @"map",
             @"\uf2a2" : @"medkit",
             @"\uf33f" : @"merge",
             @"\uf204" : @"micA",
             @"\uf205" : @"micB",
             @"\uf206" : @"micC",
             @"\uf209" : @"minus",
             @"\uf207" : @"minusCircled",
             @"\uf208" : @"minusRound",
             @"\uf2c1" : @"modelS",
             @"\uf20a" : @"monitor",
             @"\uf20b" : @"more",
             @"\uf340" : @"mouse",
             @"\uf20c" : @"musicNote",
             @"\uf20e" : @"navicon",
             @"\uf20d" : @"naviconRound",
             @"\uf2a3" : @"navigate",
             @"\uf341" : @"network",
             @"\uf2c2" : @"noSmoking",
             @"\uf2a4" : @"nuclear",
             @"\uf342" : @"outlet",
             @"\uf2c3" : @"paperAirplane",
             @"\uf20f" : @"paperclip",
             @"\uf210" : @"pause",
             @"\uf213" : @"person",
             @"\uf211" : @"personAdd",
             @"\uf212" : @"personStalker",
             @"\uf2a5" : @"pieGraph",
             @"\uf2a6" : @"pin",
             @"\uf2a7" : @"pinpoint",
             @"\uf2a8" : @"pizza",
             @"\uf214" : @"plane",
             @"\uf343" : @"planet",
             @"\uf215" : @"play",
             @"\uf30a" : @"playstation",
             @"\uf218" : @"plus",
             @"\uf216" : @"plusCircled",
             @"\uf217" : @"plusRound",
             @"\uf344" : @"podium",
             @"\uf219" : @"pound",
             @"\uf2a9" : @"power",
             @"\uf2aa" : @"pricetag",
             @"\uf2ab" : @"pricetags",
             @"\uf21a" : @"printer",
             @"\uf345" : @"pullRequest",
             @"\uf346" : @"qrScanner",
             @"\uf347" : @"quote",
             @"\uf2ac" : @"radioWaves",
             @"\uf21b" : @"record",
             @"\uf21c" : @"refreshbeforeionRefreshing",
             @"\uf21e" : @"reply",
             @"\uf21d" : @"replyAll",
             @"\uf348" : @"ribbonA",
             @"\uf349" : @"ribbonB",
             @"\uf34a" : @"sad",
             @"\uf34b" : @"scissors",
             @"\uf21f" : @"search",
             @"\uf2ad" : @"settings",
             @"\uf220" : @"share",
             @"\uf221" : @"shuffle",
             @"\uf222" : @"skipBackward",
             @"\uf223" : @"skipForward",
             @"\uf225" : @"socialAndroid",
             @"\uf224" : @"socialAndroidOutline",
             @"\uf227" : @"socialApple",
             @"\uf226" : @"socialAppleOutline",
             @"\uf2af" : @"socialBitcoin",
             @"\uf2ae" : @"socialBitcoinOutline",
             @"\uf229" : @"socialBuffer",
             @"\uf228" : @"socialBufferOutline",
             @"\uf22b" : @"socialDesignernews",
             @"\uf22a" : @"socialDesignernewsOutline",
             @"\uf22d" : @"socialDribbble",
             @"\uf22c" : @"socialDribbbleOutline",
             @"\uf22f" : @"socialDropbox",
             @"\uf22e" : @"socialDropboxOutline",
             @"\uf231" : @"socialFacebook",
             @"\uf230" : @"socialFacebookOutline",
             @"\uf34d" : @"socialFoursquare",
             @"\uf34c" : @"socialFoursquareOutline",
             @"\uf2c4" : @"socialFreebsdDevil",
             @"\uf233" : @"socialGithub",
             @"\uf232" : @"socialGithubOutline",
             @"\uf34f" : @"socialGoogle",
             @"\uf34e" : @"socialGoogleOutline",
             @"\uf235" : @"socialGoogleplus",
             @"\uf234" : @"socialGoogleplusOutline",
             @"\uf237" : @"socialHackernews",
             @"\uf236" : @"socialHackernewsOutline",
             @"\uf351" : @"socialInstagram",
             @"\uf350" : @"socialInstagramOutline",
             @"\uf239" : @"socialLinkedin",
             @"\uf238" : @"socialLinkedinOutline",
             @"\uf2b1" : @"socialPinterest",
             @"\uf2b0" : @"socialPinterestOutline",
             @"\uf23b" : @"socialReddit",
             @"\uf23a" : @"socialRedditOutline",
             @"\uf23d" : @"socialRss",
             @"\uf23c" : @"socialRssOutline",
             @"\uf23f" : @"socialSkype",
             @"\uf23e" : @"socialSkypeOutline",
             @"\uf241" : @"socialTumblr",
             @"\uf240" : @"socialTumblrOutline",
             @"\uf2c5" : @"socialTux",
             @"\uf243" : @"socialTwitter",
             @"\uf242" : @"socialTwitterOutline",
             @"\uf353" : @"socialUsd",
             @"\uf352" : @"socialUsdOutline",
             @"\uf245" : @"socialVimeo",
             @"\uf244" : @"socialVimeoOutline",
             @"\uf247" : @"socialWindows",
             @"\uf246" : @"socialWindowsOutline",
             @"\uf249" : @"socialWordpress",
             @"\uf248" : @"socialWordpressOutline",
             @"\uf24b" : @"socialYahoo",
             @"\uf24a" : @"socialYahooOutline",
             @"\uf24d" : @"socialYoutube",
             @"\uf24c" : @"socialYoutubeOutline",
             @"\uf2b2" : @"speakerphone",
             @"\uf2b3" : @"speedometer",
             @"\uf2b4" : @"spoon",
             @"\uf24e" : @"star",
             @"\uf2b5" : @"statsBars",
             @"\uf30b" : @"steam",
             @"\uf24f" : @"stop",
             @"\uf2b6" : @"thermometer",
             @"\uf250" : @"thumbsdown",
             @"\uf251" : @"thumbsup",
             @"\uf355" : @"toggle",
             @"\uf354" : @"toggleFilled",
             @"\uf252" : @"trashA",
             @"\uf253" : @"trashB",
             @"\uf356" : @"trophy",
             @"\uf2b7" : @"umbrella",
             @"\uf357" : @"university",
             @"\uf254" : @"unlocked",
             @"\uf255" : @"upload",
             @"\uf2b8" : @"usb",
             @"\uf256" : @"videocamera",
             @"\uf257" : @"volumeHigh",
             @"\uf258" : @"volumeLow",
             @"\uf259" : @"volumeMedium",
             @"\uf25a" : @"volumeMute",
             @"\uf358" : @"wand",
             @"\uf25b" : @"waterdrop",
             @"\uf25c" : @"wifi",
             @"\uf2b9" : @"wineglass",
             @"\uf25d" : @"woman",
             @"\uf2ba" : @"wrench",
             @"\uf30c" : @"xbox",
             
             };
}

@end
