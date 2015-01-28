#import "FAKIonIcons.h"

@implementation FAKIonIcons

+ (UIFont *)iconFontWithSize:(CGFloat)size
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self registerIconFontWithURL: [[NSBundle mainBundle] URLForResource:@"ionicons" withExtension:@"ttf"]];
    });
    
    UIFont *font = [UIFont fontWithName:@"Ionicons" size:size];
    NSAssert(font, @"UIFont object should not be nil, check if the font file is added to the application bundle and you're using the correct font name.");
    return font;
}

// Generated Code
+ (instancetype)socialYoutubeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue600" size:size];
}

+ (instancetype)socialYoutubeOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue601" size:size];
}

+ (instancetype)socialYahooIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue602" size:size];
}

+ (instancetype)socialYahooOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue603" size:size];
}

+ (instancetype)socialWordpressIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue604" size:size];
}

+ (instancetype)socialWordpressOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue605" size:size];
}

+ (instancetype)socialWindowsIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue606" size:size];
}

+ (instancetype)socialWindowsOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue607" size:size];
}

+ (instancetype)socialVimeoIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue608" size:size];
}

+ (instancetype)socialVimeoOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue609" size:size];
}

+ (instancetype)socialTwitterIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue60a" size:size];
}

+ (instancetype)socialTwitterOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue60b" size:size];
}

+ (instancetype)socialTumblrIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue60c" size:size];
}

+ (instancetype)socialTumblrOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue60d" size:size];
}

+ (instancetype)socialSkypeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue60e" size:size];
}

+ (instancetype)socialSkypeOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue60f" size:size];
}

+ (instancetype)socialRssIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue610" size:size];
}

+ (instancetype)socialRssOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue611" size:size];
}

+ (instancetype)socialRedditIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue612" size:size];
}

+ (instancetype)socialRedditOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue613" size:size];
}

+ (instancetype)socialPinterestIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue614" size:size];
}

+ (instancetype)socialPinterestOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue615" size:size];
}

+ (instancetype)socialLinkedinIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue616" size:size];
}

+ (instancetype)socialLinkedinOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue617" size:size];
}

+ (instancetype)socialHackernewsIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue618" size:size];
}

+ (instancetype)socialHackernewsOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue619" size:size];
}

+ (instancetype)socialGoogleplusIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue61a" size:size];
}

+ (instancetype)socialGoogleplusOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue61b" size:size];
}

+ (instancetype)socialGithubIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue61c" size:size];
}

+ (instancetype)socialGithubOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue61d" size:size];
}

+ (instancetype)socialFacebookIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue61e" size:size];
}

+ (instancetype)socialFacebookOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue61f" size:size];
}

+ (instancetype)socialDropboxIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue620" size:size];
}

+ (instancetype)socialDropboxOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue621" size:size];
}

+ (instancetype)socialDribbbleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue622" size:size];
}

+ (instancetype)socialDribbbleOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue623" size:size];
}

+ (instancetype)socialDesignernewsIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue624" size:size];
}

+ (instancetype)socialDesignernewsOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue625" size:size];
}

+ (instancetype)socialBufferIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue626" size:size];
}

+ (instancetype)socialBufferOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue627" size:size];
}

+ (instancetype)socialBitcoinIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue628" size:size];
}

+ (instancetype)socialBitcoinOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue629" size:size];
}

+ (instancetype)socialAppleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue62a" size:size];
}

+ (instancetype)socialAppleOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue62b" size:size];
}

+ (instancetype)socialAndroidIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue62c" size:size];
}

+ (instancetype)socialAndroidOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue62d" size:size];
}

+ (instancetype)ios7WorldIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue62e" size:size];
}

+ (instancetype)ios7WorldOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue62f" size:size];
}

+ (instancetype)ios7WineglassIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue630" size:size];
}

+ (instancetype)ios7WineglassOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue631" size:size];
}

+ (instancetype)ios7VolumeLowIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue632" size:size];
}

+ (instancetype)ios7VolumeHighIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue633" size:size];
}

+ (instancetype)ios7VideocamIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue634" size:size];
}

+ (instancetype)ios7VideocamOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue635" size:size];
}

+ (instancetype)ios7UploadIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue636" size:size];
}

+ (instancetype)ios7UploadOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue637" size:size];
}

+ (instancetype)ios7UnlockedIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue638" size:size];
}

+ (instancetype)ios7UnlockedOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue639" size:size];
}

+ (instancetype)ios7UndoIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue63a" size:size];
}

+ (instancetype)ios7UndoOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue63b" size:size];
}

+ (instancetype)ios7TrashIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue63c" size:size];
}

+ (instancetype)ios7TrashOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue63d" size:size];
}

+ (instancetype)ios7TimerIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue63e" size:size];
}

+ (instancetype)ios7TimerOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue63f" size:size];
}

+ (instancetype)ios7TimeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue640" size:size];
}

+ (instancetype)ios7TimeOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue641" size:size];
}

+ (instancetype)ios7ThunderstormIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue642" size:size];
}

+ (instancetype)ios7ThunderstormOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue643" size:size];
}

+ (instancetype)ios7TelephoneIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue644" size:size];
}

+ (instancetype)ios7TelephoneOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue645" size:size];
}

+ (instancetype)ios7SunnyIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue646" size:size];
}

+ (instancetype)ios7SunnyOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue647" size:size];
}

+ (instancetype)ios7StopwatchIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue648" size:size];
}

+ (instancetype)ios7StopwatchOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue649" size:size];
}

+ (instancetype)ios7StarIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue64a" size:size];
}

+ (instancetype)ios7StarOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue64b" size:size];
}

+ (instancetype)ios7SpeedometerIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue64c" size:size];
}

+ (instancetype)ios7SpeedometerOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue64d" size:size];
}

+ (instancetype)ios7SkipforwardIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue64e" size:size];
}

+ (instancetype)ios7SkipforwardOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue64f" size:size];
}

+ (instancetype)ios7SkipbackwardIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue650" size:size];
}

+ (instancetype)ios7SkipbackwardOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue651" size:size];
}

+ (instancetype)ios7SearchIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue652" size:size];
}

+ (instancetype)ios7SearchStrongIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue653" size:size];
}

+ (instancetype)ios7RewindIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue654" size:size];
}

+ (instancetype)ios7RewindOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue655" size:size];
}

+ (instancetype)ios7ReloadIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue656" size:size];
}

+ (instancetype)ios7RefreshIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue657" size:size];
}

+ (instancetype)ios7RefreshOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue658" size:size];
}

+ (instancetype)ios7RefreshEmptyIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue659" size:size];
}

+ (instancetype)ios7RedoIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue65a" size:size];
}

+ (instancetype)ios7RedoOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue65b" size:size];
}

+ (instancetype)ios7RecordingIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue65c" size:size];
}

+ (instancetype)ios7RecordingOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue65d" size:size];
}

+ (instancetype)ios7RainyIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue65e" size:size];
}

+ (instancetype)ios7RainyOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue65f" size:size];
}

+ (instancetype)ios7PrinterIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue660" size:size];
}

+ (instancetype)ios7PrinterOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue661" size:size];
}

+ (instancetype)ios7PricetagIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue662" size:size];
}

+ (instancetype)ios7PricetagOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue663" size:size];
}

+ (instancetype)ios7PlusIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue664" size:size];
}

+ (instancetype)ios7PlusOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue665" size:size];
}

+ (instancetype)ios7PlusEmptyIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue666" size:size];
}

+ (instancetype)ios7PlayIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue667" size:size];
}

+ (instancetype)ios7PlayOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue668" size:size];
}

+ (instancetype)ios7PieIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue669" size:size];
}

+ (instancetype)ios7PieOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue66a" size:size];
}

+ (instancetype)ios7PhotosIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue66b" size:size];
}

+ (instancetype)ios7PhotosOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue66c" size:size];
}

+ (instancetype)ios7PersonaddIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue66d" size:size];
}

+ (instancetype)ios7PersonaddOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue66e" size:size];
}

+ (instancetype)ios7PersonIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue66f" size:size];
}

+ (instancetype)ios7PersonOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue670" size:size];
}

+ (instancetype)ios7PeopleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue671" size:size];
}

+ (instancetype)ios7PeopleOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue672" size:size];
}

+ (instancetype)ios7PauseIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue673" size:size];
}

+ (instancetype)ios7PauseOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue674" size:size];
}

+ (instancetype)ios7PartlysunnyIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue675" size:size];
}

+ (instancetype)ios7PartlysunnyOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue676" size:size];
}

+ (instancetype)ios7PaperplaneIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue677" size:size];
}

+ (instancetype)ios7PaperplaneOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue678" size:size];
}

+ (instancetype)ios7NavigateIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue679" size:size];
}

+ (instancetype)ios7NavigateOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue67a" size:size];
}

+ (instancetype)ios7MusicalNotesIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue67b" size:size];
}

+ (instancetype)ios7MusicalNoteIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue67c" size:size];
}

+ (instancetype)ios7MoreIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue67d" size:size];
}

+ (instancetype)ios7MoreOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue67e" size:size];
}

+ (instancetype)ios7MoonIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue67f" size:size];
}

+ (instancetype)ios7MoonOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue680" size:size];
}

+ (instancetype)ios7MonitorIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue681" size:size];
}

+ (instancetype)ios7MonitorOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue682" size:size];
}

+ (instancetype)ios7MinusIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue683" size:size];
}

+ (instancetype)ios7MinusOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue684" size:size];
}

+ (instancetype)ios7MinusEmptyIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue685" size:size];
}

+ (instancetype)ios7MicIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue686" size:size];
}

+ (instancetype)ios7MicOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue687" size:size];
}

+ (instancetype)ios7MicOffIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue688" size:size];
}

+ (instancetype)ios7MedkitIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue689" size:size];
}

+ (instancetype)ios7MedkitOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue68a" size:size];
}

+ (instancetype)ios7LockedIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue68b" size:size];
}

+ (instancetype)ios7LockedOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue68c" size:size];
}

+ (instancetype)ios7LocationIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue68d" size:size];
}

+ (instancetype)ios7LocationOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue68e" size:size];
}

+ (instancetype)ios7LightbulbIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue68f" size:size];
}

+ (instancetype)ios7LightbulbOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue690" size:size];
}

+ (instancetype)ios7KeypadIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue691" size:size];
}

+ (instancetype)ios7KeypadOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue692" size:size];
}

+ (instancetype)ios7IonicOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue693" size:size];
}

+ (instancetype)ios7InformationIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue694" size:size];
}

+ (instancetype)ios7InformationOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue695" size:size];
}

+ (instancetype)ios7InformationEmptyIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue696" size:size];
}

+ (instancetype)ios7InfiniteIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue697" size:size];
}

+ (instancetype)ios7InfiniteOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue698" size:size];
}

+ (instancetype)ios7HelpIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue699" size:size];
}

+ (instancetype)ios7HelpOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue69a" size:size];
}

+ (instancetype)ios7HelpEmptyIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue69b" size:size];
}

+ (instancetype)ios7HeartIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue69c" size:size];
}

+ (instancetype)ios7HeartOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue69d" size:size];
}

+ (instancetype)ios7GlassesIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue69e" size:size];
}

+ (instancetype)ios7GlassesOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue69f" size:size];
}

+ (instancetype)ios7GearIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6a0" size:size];
}

+ (instancetype)ios7GearOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6a1" size:size];
}

+ (instancetype)ios7FolderIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6a2" size:size];
}

+ (instancetype)ios7FolderOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6a3" size:size];
}

+ (instancetype)ios7FlagIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6a4" size:size];
}

+ (instancetype)ios7FlagOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6a5" size:size];
}

+ (instancetype)ios7FilmIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6a6" size:size];
}

+ (instancetype)ios7FilmOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6a7" size:size];
}

+ (instancetype)ios7FilingIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6a8" size:size];
}

+ (instancetype)ios7FilingOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6a9" size:size];
}

+ (instancetype)ios7FastforwardIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6aa" size:size];
}

+ (instancetype)ios7FastforwardOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6ab" size:size];
}

+ (instancetype)ios7EyeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6ac" size:size];
}

+ (instancetype)ios7EyeOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6ad" size:size];
}

+ (instancetype)ios7EmailIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6ae" size:size];
}

+ (instancetype)ios7EmailOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6af" size:size];
}

+ (instancetype)ios7DragIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6b0" size:size];
}

+ (instancetype)ios7DownloadIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6b1" size:size];
}

+ (instancetype)ios7DownloadOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6b2" size:size];
}

+ (instancetype)ios7CopyIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6b3" size:size];
}

+ (instancetype)ios7CopyOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6b4" size:size];
}

+ (instancetype)ios7ContactIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6b5" size:size];
}

+ (instancetype)ios7ContactOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6b6" size:size];
}

+ (instancetype)ios7ComposeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6b7" size:size];
}

+ (instancetype)ios7ComposeOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6b8" size:size];
}

+ (instancetype)ios7CogIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6b9" size:size];
}

+ (instancetype)ios7CogOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6ba" size:size];
}

+ (instancetype)ios7CloudyIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6bb" size:size];
}

+ (instancetype)ios7CloudyOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6bc" size:size];
}

+ (instancetype)ios7CloudIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6bd" size:size];
}

+ (instancetype)ios7CloudUploadIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6be" size:size];
}

+ (instancetype)ios7CloudUploadOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6bf" size:size];
}

+ (instancetype)ios7CloudOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6c0" size:size];
}

+ (instancetype)ios7CloudDownloadIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6c1" size:size];
}

+ (instancetype)ios7CloudDownloadOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6c2" size:size];
}

+ (instancetype)ios7ClockIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6c3" size:size];
}

+ (instancetype)ios7ClockOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6c4" size:size];
}

+ (instancetype)ios7CircleOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6c5" size:size];
}

+ (instancetype)ios7CircleFilledIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6c6" size:size];
}

+ (instancetype)ios7CheckmarkIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6c7" size:size];
}

+ (instancetype)ios7CheckmarkOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6c8" size:size];
}

+ (instancetype)ios7CheckmarkEmptyIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6c9" size:size];
}

+ (instancetype)ios7ChatbubbleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6ca" size:size];
}

+ (instancetype)ios7ChatbubbleOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6cb" size:size];
}

+ (instancetype)ios7ChatboxesIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6cc" size:size];
}

+ (instancetype)ios7ChatboxesOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6cd" size:size];
}

+ (instancetype)ios7CartIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6ce" size:size];
}

+ (instancetype)ios7CartOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6cf" size:size];
}

+ (instancetype)ios7CameraIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6d0" size:size];
}

+ (instancetype)ios7CameraOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6d1" size:size];
}

+ (instancetype)ios7CalendarIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6d2" size:size];
}

+ (instancetype)ios7CalendarOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6d3" size:size];
}

+ (instancetype)ios7CalculatorIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6d4" size:size];
}

+ (instancetype)ios7CalculatorOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6d5" size:size];
}

+ (instancetype)ios7BrowsersIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6d6" size:size];
}

+ (instancetype)ios7BrowsersOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6d7" size:size];
}

+ (instancetype)ios7BriefcaseIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6d8" size:size];
}

+ (instancetype)ios7BriefcaseOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6d9" size:size];
}

+ (instancetype)ios7BoxIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6da" size:size];
}

+ (instancetype)ios7BoxOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6db" size:size];
}

+ (instancetype)ios7BookmarksIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6dc" size:size];
}

+ (instancetype)ios7BookmarksOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6dd" size:size];
}

+ (instancetype)ios7BoltIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6de" size:size];
}

+ (instancetype)ios7BoltOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6df" size:size];
}

+ (instancetype)ios7BellIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6e0" size:size];
}

+ (instancetype)ios7BellOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6e1" size:size];
}

+ (instancetype)ios7AtIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6e2" size:size];
}

+ (instancetype)ios7AtOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6e3" size:size];
}

+ (instancetype)ios7ArrowUpIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6e4" size:size];
}

+ (instancetype)ios7ArrowThinUpIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6e5" size:size];
}

+ (instancetype)ios7ArrowThinRightIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6e6" size:size];
}

+ (instancetype)ios7ArrowThinLeftIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6e7" size:size];
}

+ (instancetype)ios7ArrowThinDownIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6e8" size:size];
}

+ (instancetype)ios7ArrowRightIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6e9" size:size];
}

+ (instancetype)ios7ArrowLeftIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6ea" size:size];
}

+ (instancetype)ios7ArrowForwardIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6eb" size:size];
}

+ (instancetype)ios7ArrowDownIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6ec" size:size];
}

+ (instancetype)ios7ArrowBackIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6ed" size:size];
}

+ (instancetype)ios7AlbumsIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6ee" size:size];
}

+ (instancetype)ios7AlbumsOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6ef" size:size];
}

+ (instancetype)ios7AlarmIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6f0" size:size];
}

+ (instancetype)ios7AlarmOutlineIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6f1" size:size];
}

+ (instancetype)wrenchIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6f2" size:size];
}

+ (instancetype)womanIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6f3" size:size];
}

+ (instancetype)wineglassIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6f4" size:size];
}

+ (instancetype)wifiIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6f5" size:size];
}

+ (instancetype)waterdropIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6f6" size:size];
}

+ (instancetype)volumeMuteIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6f7" size:size];
}

+ (instancetype)volumeMediumIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6f8" size:size];
}

+ (instancetype)volumeLowIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6f9" size:size];
}

+ (instancetype)volumeHighIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6fa" size:size];
}

+ (instancetype)videocameraIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6fb" size:size];
}

+ (instancetype)usbIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6fc" size:size];
}

+ (instancetype)uploadIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6fd" size:size];
}

+ (instancetype)unlockedIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6fe" size:size];
}

+ (instancetype)umbrellaIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue6ff" size:size];
}

+ (instancetype)trashBIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue700" size:size];
}

+ (instancetype)trashAIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue701" size:size];
}

+ (instancetype)thumbsupIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue702" size:size];
}

+ (instancetype)thumbsdownIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue703" size:size];
}

+ (instancetype)thermometerIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue704" size:size];
}

+ (instancetype)stopIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue705" size:size];
}

+ (instancetype)statsBarsIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue706" size:size];
}

+ (instancetype)starIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue707" size:size];
}

+ (instancetype)spoonIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue708" size:size];
}

+ (instancetype)speedometerIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue709" size:size];
}

+ (instancetype)speakerphoneIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue70a" size:size];
}

+ (instancetype)skipForwardIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue70b" size:size];
}

+ (instancetype)skipBackwardIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue70c" size:size];
}

+ (instancetype)shuffleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue70d" size:size];
}

+ (instancetype)shareIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue70e" size:size];
}

+ (instancetype)settingsIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue70f" size:size];
}

+ (instancetype)searchIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue710" size:size];
}

+ (instancetype)replyIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue711" size:size];
}

+ (instancetype)replyAllIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue712" size:size];
}

+ (instancetype)refreshIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue713" size:size];
}

+ (instancetype)recordIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue714" size:size];
}

+ (instancetype)radioWavesIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue715" size:size];
}

+ (instancetype)printerIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue716" size:size];
}

+ (instancetype)pricetagsIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue717" size:size];
}

+ (instancetype)pricetagIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue718" size:size];
}

+ (instancetype)powerIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue719" size:size];
}

+ (instancetype)poundIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue71a" size:size];
}

+ (instancetype)plusIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue71b" size:size];
}

+ (instancetype)plusRoundIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue71c" size:size];
}

+ (instancetype)plusCircledIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue71d" size:size];
}

+ (instancetype)playIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue71e" size:size];
}

+ (instancetype)planeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue71f" size:size];
}

+ (instancetype)pizzaIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue720" size:size];
}

+ (instancetype)pinpointIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue721" size:size];
}

+ (instancetype)pinIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue722" size:size];
}

+ (instancetype)pieGraphIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue723" size:size];
}

+ (instancetype)personIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue724" size:size];
}

+ (instancetype)personStalkerIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue725" size:size];
}

+ (instancetype)personAddIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue726" size:size];
}

+ (instancetype)pauseIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue727" size:size];
}

+ (instancetype)paperclipIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue728" size:size];
}

+ (instancetype)nuclearIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue729" size:size];
}

+ (instancetype)navigateIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue72a" size:size];
}

+ (instancetype)naviconIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue72b" size:size];
}

+ (instancetype)naviconRoundIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue72c" size:size];
}

+ (instancetype)musicNoteIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue72d" size:size];
}

+ (instancetype)moreIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue72e" size:size];
}

+ (instancetype)monitorIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue72f" size:size];
}

+ (instancetype)minusIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue730" size:size];
}

+ (instancetype)minusRoundIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue731" size:size];
}

+ (instancetype)minusCircledIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue732" size:size];
}

+ (instancetype)micCIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue733" size:size];
}

+ (instancetype)micBIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue734" size:size];
}

+ (instancetype)micAIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue735" size:size];
}

+ (instancetype)medkitIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue736" size:size];
}

+ (instancetype)mapIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue737" size:size];
}

+ (instancetype)manIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue738" size:size];
}

+ (instancetype)maleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue739" size:size];
}

+ (instancetype)magnetIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue73a" size:size];
}

+ (instancetype)loopIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue73b" size:size];
}

+ (instancetype)logOutIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue73c" size:size];
}

+ (instancetype)logInIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue73d" size:size];
}

+ (instancetype)lockedIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue73e" size:size];
}

+ (instancetype)locationIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue73f" size:size];
}

+ (instancetype)loadDIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue740" size:size];
}

+ (instancetype)loadCIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue741" size:size];
}

+ (instancetype)loadBIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue742" size:size];
}

+ (instancetype)loadAIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue743" size:size];
}

+ (instancetype)linkIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue744" size:size];
}

+ (instancetype)lightbulbIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue745" size:size];
}

+ (instancetype)levelsIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue746" size:size];
}

+ (instancetype)leafIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue747" size:size];
}

+ (instancetype)laptopIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue748" size:size];
}

+ (instancetype)knifeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue749" size:size];
}

+ (instancetype)keyIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue74a" size:size];
}

+ (instancetype)jetIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue74b" size:size];
}

+ (instancetype)ipodIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue74c" size:size];
}

+ (instancetype)iphoneIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue74d" size:size];
}

+ (instancetype)ipadIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue74e" size:size];
}

+ (instancetype)ionicIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue74f" size:size];
}

+ (instancetype)informationIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue750" size:size];
}

+ (instancetype)informationCircledIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue751" size:size];
}

+ (instancetype)imagesIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue752" size:size];
}

+ (instancetype)imageIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue753" size:size];
}

+ (instancetype)icecreamIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue754" size:size];
}

+ (instancetype)homeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue755" size:size];
}

+ (instancetype)helpIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue756" size:size];
}

+ (instancetype)helpCircledIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue757" size:size];
}

+ (instancetype)helpBuoyIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue758" size:size];
}

+ (instancetype)heartIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue759" size:size];
}

+ (instancetype)headphoneIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue75a" size:size];
}

+ (instancetype)hammerIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue75b" size:size];
}

+ (instancetype)gridIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue75c" size:size];
}

+ (instancetype)gearBIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue75d" size:size];
}

+ (instancetype)gearAIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue75e" size:size];
}

+ (instancetype)gameControllerBIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue75f" size:size];
}

+ (instancetype)gameControllerAIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue760" size:size];
}

+ (instancetype)forwardIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue761" size:size];
}

+ (instancetype)forkIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue762" size:size];
}

+ (instancetype)folderIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue763" size:size];
}

+ (instancetype)flaskIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue764" size:size];
}

+ (instancetype)flashIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue765" size:size];
}

+ (instancetype)flashOffIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue766" size:size];
}

+ (instancetype)flagIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue767" size:size];
}

+ (instancetype)filmMarkerIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue768" size:size];
}

+ (instancetype)filingIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue769" size:size];
}

+ (instancetype)femaleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue76a" size:size];
}

+ (instancetype)eyeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue76b" size:size];
}

+ (instancetype)emailIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue76c" size:size];
}

+ (instancetype)ejectIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue76d" size:size];
}

+ (instancetype)eggIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue76e" size:size];
}

+ (instancetype)earthIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue76f" size:size];
}

+ (instancetype)dragIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue770" size:size];
}

+ (instancetype)documentIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue771" size:size];
}

+ (instancetype)documentTextIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue772" size:size];
}

+ (instancetype)discIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue773" size:size];
}

+ (instancetype)contrastIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue774" size:size];
}

+ (instancetype)connectionBarsIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue775" size:size];
}

+ (instancetype)composeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue776" size:size];
}

+ (instancetype)compassIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue777" size:size];
}

+ (instancetype)coffeeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue778" size:size];
}

+ (instancetype)codeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue779" size:size];
}

+ (instancetype)codeWorkingIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue77a" size:size];
}

+ (instancetype)codeDownloadIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue77b" size:size];
}

+ (instancetype)cloudIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue77c" size:size];
}

+ (instancetype)closeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue77d" size:size];
}

+ (instancetype)closeRoundIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue77e" size:size];
}

+ (instancetype)closeCircledIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue77f" size:size];
}

+ (instancetype)clockIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue780" size:size];
}

+ (instancetype)clipboardIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue781" size:size];
}

+ (instancetype)chevronUpIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue782" size:size];
}

+ (instancetype)chevronRightIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue0fc" size:size];
}

+ (instancetype)chevronLeftIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue784" size:size];
}

+ (instancetype)chevronDownIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue785" size:size];
}

+ (instancetype)checkmarkIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue786" size:size];
}

+ (instancetype)checkmarkRoundIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue787" size:size];
}

+ (instancetype)checkmarkCircledIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue788" size:size];
}

+ (instancetype)chatbubblesIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue789" size:size];
}

+ (instancetype)chatbubbleIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue78a" size:size];
}

+ (instancetype)chatbubbleWorkingIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue78b" size:size];
}

+ (instancetype)chatboxesIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue78c" size:size];
}

+ (instancetype)chatboxIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue78d" size:size];
}

+ (instancetype)chatboxWorkingIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue78e" size:size];
}

+ (instancetype)cardIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue78f" size:size];
}

+ (instancetype)cameraIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue790" size:size];
}

+ (instancetype)calendarIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue791" size:size];
}

+ (instancetype)calculatorIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue792" size:size];
}

+ (instancetype)briefcaseIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue793" size:size];
}

+ (instancetype)bookmarkIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue794" size:size];
}

+ (instancetype)bluetoothIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue795" size:size];
}

+ (instancetype)beakerIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue796" size:size];
}

+ (instancetype)batteryLowIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue797" size:size];
}

+ (instancetype)batteryHalfIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue798" size:size];
}

+ (instancetype)batteryFullIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue799" size:size];
}

+ (instancetype)batteryEmptyIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue79a" size:size];
}

+ (instancetype)batteryChargingIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue79b" size:size];
}

+ (instancetype)bagIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue79c" size:size];
}

+ (instancetype)atIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue79d" size:size];
}

+ (instancetype)arrowUpCIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue79e" size:size];
}

+ (instancetype)arrowUpBIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue79f" size:size];
}

+ (instancetype)arrowUpAIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7a0" size:size];
}

+ (instancetype)arrowSwapIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7a1" size:size];
}

+ (instancetype)arrowShrinkIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7a2" size:size];
}

+ (instancetype)arrowRightCIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7a3" size:size];
}

+ (instancetype)arrowRightBIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7a4" size:size];
}

+ (instancetype)arrowRightAIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7a5" size:size];
}

+ (instancetype)arrowReturnRightIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7a6" size:size];
}

+ (instancetype)arrowReturnLeftIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7a7" size:size];
}

+ (instancetype)arrowResizeIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7a8" size:size];
}

+ (instancetype)arrowMoveIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7a9" size:size];
}

+ (instancetype)arrowLeftCIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7aa" size:size];
}

+ (instancetype)arrowLeftBIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7ab" size:size];
}

+ (instancetype)arrowLeftAIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7ac" size:size];
}

+ (instancetype)arrowGraphUpRightIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7ad" size:size];
}

+ (instancetype)arrowGraphUpLeftIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7ae" size:size];
}

+ (instancetype)arrowGraphDownRightIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7af" size:size];
}

+ (instancetype)arrowGraphDownLeftIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7b0" size:size];
}

+ (instancetype)arrowExpandIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7b1" size:size];
}

+ (instancetype)arrowDownCIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7b2" size:size];
}

+ (instancetype)arrowDownBIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7b3" size:size];
}

+ (instancetype)arrowDownAIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7b4" size:size];
}

+ (instancetype)archiveIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7b5" size:size];
}

+ (instancetype)alertIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7b6" size:size];
}

+ (instancetype)alertCircledIconWithSize:(CGFloat)size
{
    return [self iconWithCode:@"\ue7b7" size:size];
}


+ (NSDictionary *)allIcons
{
    return @{
             @"\ue600" : @"socialYoutube",
             @"\ue601" : @"socialYoutubeOutline",
             @"\ue602" : @"socialYahoo",
             @"\ue603" : @"socialYahooOutline",
             @"\ue604" : @"socialWordpress",
             @"\ue605" : @"socialWordpressOutline",
             @"\ue606" : @"socialWindows",
             @"\ue607" : @"socialWindowsOutline",
             @"\ue608" : @"socialVimeo",
             @"\ue609" : @"socialVimeoOutline",
             @"\ue60a" : @"socialTwitter",
             @"\ue60b" : @"socialTwitterOutline",
             @"\ue60c" : @"socialTumblr",
             @"\ue60d" : @"socialTumblrOutline",
             @"\ue60e" : @"socialSkype",
             @"\ue60f" : @"socialSkypeOutline",
             @"\ue610" : @"socialRss",
             @"\ue611" : @"socialRssOutline",
             @"\ue612" : @"socialReddit",
             @"\ue613" : @"socialRedditOutline",
             @"\ue614" : @"socialPinterest",
             @"\ue615" : @"socialPinterestOutline",
             @"\ue616" : @"socialLinkedin",
             @"\ue617" : @"socialLinkedinOutline",
             @"\ue618" : @"socialHackernews",
             @"\ue619" : @"socialHackernewsOutline",
             @"\ue61a" : @"socialGoogleplus",
             @"\ue61b" : @"socialGoogleplusOutline",
             @"\ue61c" : @"socialGithub",
             @"\ue61d" : @"socialGithubOutline",
             @"\ue61e" : @"socialFacebook",
             @"\ue61f" : @"socialFacebookOutline",
             @"\ue620" : @"socialDropbox",
             @"\ue621" : @"socialDropboxOutline",
             @"\ue622" : @"socialDribbble",
             @"\ue623" : @"socialDribbbleOutline",
             @"\ue624" : @"socialDesignernews",
             @"\ue625" : @"socialDesignernewsOutline",
             @"\ue626" : @"socialBuffer",
             @"\ue627" : @"socialBufferOutline",
             @"\ue628" : @"socialBitcoin",
             @"\ue629" : @"socialBitcoinOutline",
             @"\ue62a" : @"socialApple",
             @"\ue62b" : @"socialAppleOutline",
             @"\ue62c" : @"socialAndroid",
             @"\ue62d" : @"socialAndroidOutline",
             @"\ue62e" : @"ios7World",
             @"\ue62f" : @"ios7WorldOutline",
             @"\ue630" : @"ios7Wineglass",
             @"\ue631" : @"ios7WineglassOutline",
             @"\ue632" : @"ios7VolumeLow",
             @"\ue633" : @"ios7VolumeHigh",
             @"\ue634" : @"ios7Videocam",
             @"\ue635" : @"ios7VideocamOutline",
             @"\ue636" : @"ios7Upload",
             @"\ue637" : @"ios7UploadOutline",
             @"\ue638" : @"ios7Unlocked",
             @"\ue639" : @"ios7UnlockedOutline",
             @"\ue63a" : @"ios7Undo",
             @"\ue63b" : @"ios7UndoOutline",
             @"\ue63c" : @"ios7Trash",
             @"\ue63d" : @"ios7TrashOutline",
             @"\ue63e" : @"ios7Timer",
             @"\ue63f" : @"ios7TimerOutline",
             @"\ue640" : @"ios7Time",
             @"\ue641" : @"ios7TimeOutline",
             @"\ue642" : @"ios7Thunderstorm",
             @"\ue643" : @"ios7ThunderstormOutline",
             @"\ue644" : @"ios7Telephone",
             @"\ue645" : @"ios7TelephoneOutline",
             @"\ue646" : @"ios7Sunny",
             @"\ue647" : @"ios7SunnyOutline",
             @"\ue648" : @"ios7Stopwatch",
             @"\ue649" : @"ios7StopwatchOutline",
             @"\ue64a" : @"ios7Star",
             @"\ue64b" : @"ios7StarOutline",
             @"\ue64c" : @"ios7Speedometer",
             @"\ue64d" : @"ios7SpeedometerOutline",
             @"\ue64e" : @"ios7Skipforward",
             @"\ue64f" : @"ios7SkipforwardOutline",
             @"\ue650" : @"ios7Skipbackward",
             @"\ue651" : @"ios7SkipbackwardOutline",
             @"\ue652" : @"ios7Search",
             @"\ue653" : @"ios7SearchStrong",
             @"\ue654" : @"ios7Rewind",
             @"\ue655" : @"ios7RewindOutline",
             @"\ue656" : @"ios7Reload",
             @"\ue657" : @"ios7Refresh",
             @"\ue658" : @"ios7RefreshOutline",
             @"\ue659" : @"ios7RefreshEmpty",
             @"\ue65a" : @"ios7Redo",
             @"\ue65b" : @"ios7RedoOutline",
             @"\ue65c" : @"ios7Recording",
             @"\ue65d" : @"ios7RecordingOutline",
             @"\ue65e" : @"ios7Rainy",
             @"\ue65f" : @"ios7RainyOutline",
             @"\ue660" : @"ios7Printer",
             @"\ue661" : @"ios7PrinterOutline",
             @"\ue662" : @"ios7Pricetag",
             @"\ue663" : @"ios7PricetagOutline",
             @"\ue664" : @"ios7Plus",
             @"\ue665" : @"ios7PlusOutline",
             @"\ue666" : @"ios7PlusEmpty",
             @"\ue667" : @"ios7Play",
             @"\ue668" : @"ios7PlayOutline",
             @"\ue669" : @"ios7Pie",
             @"\ue66a" : @"ios7PieOutline",
             @"\ue66b" : @"ios7Photos",
             @"\ue66c" : @"ios7PhotosOutline",
             @"\ue66d" : @"ios7Personadd",
             @"\ue66e" : @"ios7PersonaddOutline",
             @"\ue66f" : @"ios7Person",
             @"\ue670" : @"ios7PersonOutline",
             @"\ue671" : @"ios7People",
             @"\ue672" : @"ios7PeopleOutline",
             @"\ue673" : @"ios7Pause",
             @"\ue674" : @"ios7PauseOutline",
             @"\ue675" : @"ios7Partlysunny",
             @"\ue676" : @"ios7PartlysunnyOutline",
             @"\ue677" : @"ios7Paperplane",
             @"\ue678" : @"ios7PaperplaneOutline",
             @"\ue679" : @"ios7Navigate",
             @"\ue67a" : @"ios7NavigateOutline",
             @"\ue67b" : @"ios7MusicalNotes",
             @"\ue67c" : @"ios7MusicalNote",
             @"\ue67d" : @"ios7More",
             @"\ue67e" : @"ios7MoreOutline",
             @"\ue67f" : @"ios7Moon",
             @"\ue680" : @"ios7MoonOutline",
             @"\ue681" : @"ios7Monitor",
             @"\ue682" : @"ios7MonitorOutline",
             @"\ue683" : @"ios7Minus",
             @"\ue684" : @"ios7MinusOutline",
             @"\ue685" : @"ios7MinusEmpty",
             @"\ue686" : @"ios7Mic",
             @"\ue687" : @"ios7MicOutline",
             @"\ue688" : @"ios7MicOff",
             @"\ue689" : @"ios7Medkit",
             @"\ue68a" : @"ios7MedkitOutline",
             @"\ue68b" : @"ios7Locked",
             @"\ue68c" : @"ios7LockedOutline",
             @"\ue68d" : @"ios7Location",
             @"\ue68e" : @"ios7LocationOutline",
             @"\ue68f" : @"ios7Lightbulb",
             @"\ue690" : @"ios7LightbulbOutline",
             @"\ue691" : @"ios7Keypad",
             @"\ue692" : @"ios7KeypadOutline",
             @"\ue693" : @"ios7IonicOutline",
             @"\ue694" : @"ios7Information",
             @"\ue695" : @"ios7InformationOutline",
             @"\ue696" : @"ios7InformationEmpty",
             @"\ue697" : @"ios7Infinite",
             @"\ue698" : @"ios7InfiniteOutline",
             @"\ue699" : @"ios7Help",
             @"\ue69a" : @"ios7HelpOutline",
             @"\ue69b" : @"ios7HelpEmpty",
             @"\ue69c" : @"ios7Heart",
             @"\ue69d" : @"ios7HeartOutline",
             @"\ue69e" : @"ios7Glasses",
             @"\ue69f" : @"ios7GlassesOutline",
             @"\ue6a0" : @"ios7Gear",
             @"\ue6a1" : @"ios7GearOutline",
             @"\ue6a2" : @"ios7Folder",
             @"\ue6a3" : @"ios7FolderOutline",
             @"\ue6a4" : @"ios7Flag",
             @"\ue6a5" : @"ios7FlagOutline",
             @"\ue6a6" : @"ios7Film",
             @"\ue6a7" : @"ios7FilmOutline",
             @"\ue6a8" : @"ios7Filing",
             @"\ue6a9" : @"ios7FilingOutline",
             @"\ue6aa" : @"ios7Fastforward",
             @"\ue6ab" : @"ios7FastforwardOutline",
             @"\ue6ac" : @"ios7Eye",
             @"\ue6ad" : @"ios7EyeOutline",
             @"\ue6ae" : @"ios7Email",
             @"\ue6af" : @"ios7EmailOutline",
             @"\ue6b0" : @"ios7Drag",
             @"\ue6b1" : @"ios7Download",
             @"\ue6b2" : @"ios7DownloadOutline",
             @"\ue6b3" : @"ios7Copy",
             @"\ue6b4" : @"ios7CopyOutline",
             @"\ue6b5" : @"ios7Contact",
             @"\ue6b6" : @"ios7ContactOutline",
             @"\ue6b7" : @"ios7Compose",
             @"\ue6b8" : @"ios7ComposeOutline",
             @"\ue6b9" : @"ios7Cog",
             @"\ue6ba" : @"ios7CogOutline",
             @"\ue6bb" : @"ios7Cloudy",
             @"\ue6bc" : @"ios7CloudyOutline",
             @"\ue6bd" : @"ios7Cloud",
             @"\ue6be" : @"ios7CloudUpload",
             @"\ue6bf" : @"ios7CloudUploadOutline",
             @"\ue6c0" : @"ios7CloudOutline",
             @"\ue6c1" : @"ios7CloudDownload",
             @"\ue6c2" : @"ios7CloudDownloadOutline",
             @"\ue6c3" : @"ios7Clock",
             @"\ue6c4" : @"ios7ClockOutline",
             @"\ue6c5" : @"ios7CircleOutline",
             @"\ue6c6" : @"ios7CircleFilled",
             @"\ue6c7" : @"ios7Checkmark",
             @"\ue6c8" : @"ios7CheckmarkOutline",
             @"\ue6c9" : @"ios7CheckmarkEmpty",
             @"\ue6ca" : @"ios7Chatbubble",
             @"\ue6cb" : @"ios7ChatbubbleOutline",
             @"\ue6cc" : @"ios7Chatboxes",
             @"\ue6cd" : @"ios7ChatboxesOutline",
             @"\ue6ce" : @"ios7Cart",
             @"\ue6cf" : @"ios7CartOutline",
             @"\ue6d0" : @"ios7Camera",
             @"\ue6d1" : @"ios7CameraOutline",
             @"\ue6d2" : @"ios7Calendar",
             @"\ue6d3" : @"ios7CalendarOutline",
             @"\ue6d4" : @"ios7Calculator",
             @"\ue6d5" : @"ios7CalculatorOutline",
             @"\ue6d6" : @"ios7Browsers",
             @"\ue6d7" : @"ios7BrowsersOutline",
             @"\ue6d8" : @"ios7Briefcase",
             @"\ue6d9" : @"ios7BriefcaseOutline",
             @"\ue6da" : @"ios7Box",
             @"\ue6db" : @"ios7BoxOutline",
             @"\ue6dc" : @"ios7Bookmarks",
             @"\ue6dd" : @"ios7BookmarksOutline",
             @"\ue6de" : @"ios7Bolt",
             @"\ue6df" : @"ios7BoltOutline",
             @"\ue6e0" : @"ios7Bell",
             @"\ue6e1" : @"ios7BellOutline",
             @"\ue6e2" : @"ios7At",
             @"\ue6e3" : @"ios7AtOutline",
             @"\ue6e4" : @"ios7ArrowUp",
             @"\ue6e5" : @"ios7ArrowThinUp",
             @"\ue6e6" : @"ios7ArrowThinRight",
             @"\ue6e7" : @"ios7ArrowThinLeft",
             @"\ue6e8" : @"ios7ArrowThinDown",
             @"\ue6e9" : @"ios7ArrowRight",
             @"\ue6ea" : @"ios7ArrowLeft",
             @"\ue6eb" : @"ios7ArrowForward",
             @"\ue6ec" : @"ios7ArrowDown",
             @"\ue6ed" : @"ios7ArrowBack",
             @"\ue6ee" : @"ios7Albums",
             @"\ue6ef" : @"ios7AlbumsOutline",
             @"\ue6f0" : @"ios7Alarm",
             @"\ue6f1" : @"ios7AlarmOutline",
             @"\ue6f2" : @"wrench",
             @"\ue6f3" : @"woman",
             @"\ue6f4" : @"wineglass",
             @"\ue6f5" : @"wifi",
             @"\ue6f6" : @"waterdrop",
             @"\ue6f7" : @"volumeMute",
             @"\ue6f8" : @"volumeMedium",
             @"\ue6f9" : @"volumeLow",
             @"\ue6fa" : @"volumeHigh",
             @"\ue6fb" : @"videocamera",
             @"\ue6fc" : @"usb",
             @"\ue6fd" : @"upload",
             @"\ue6fe" : @"unlocked",
             @"\ue6ff" : @"umbrella",
             @"\ue700" : @"trashB",
             @"\ue701" : @"trashA",
             @"\ue702" : @"thumbsup",
             @"\ue703" : @"thumbsdown",
             @"\ue704" : @"thermometer",
             @"\ue705" : @"stop",
             @"\ue706" : @"statsBars",
             @"\ue707" : @"star",
             @"\ue708" : @"spoon",
             @"\ue709" : @"speedometer",
             @"\ue70a" : @"speakerphone",
             @"\ue70b" : @"skipForward",
             @"\ue70c" : @"skipBackward",
             @"\ue70d" : @"shuffle",
             @"\ue70e" : @"share",
             @"\ue70f" : @"settings",
             @"\ue710" : @"search",
             @"\ue711" : @"reply",
             @"\ue712" : @"replyAll",
             @"\ue713" : @"refresh",
             @"\ue714" : @"record",
             @"\ue715" : @"radioWaves",
             @"\ue716" : @"printer",
             @"\ue717" : @"pricetags",
             @"\ue718" : @"pricetag",
             @"\ue719" : @"power",
             @"\ue71a" : @"pound",
             @"\ue71b" : @"plus",
             @"\ue71c" : @"plusRound",
             @"\ue71d" : @"plusCircled",
             @"\ue71e" : @"play",
             @"\ue71f" : @"plane",
             @"\ue720" : @"pizza",
             @"\ue721" : @"pinpoint",
             @"\ue722" : @"pin",
             @"\ue723" : @"pieGraph",
             @"\ue724" : @"person",
             @"\ue725" : @"personStalker",
             @"\ue726" : @"personAdd",
             @"\ue727" : @"pause",
             @"\ue728" : @"paperclip",
             @"\ue729" : @"nuclear",
             @"\ue72a" : @"navigate",
             @"\ue72b" : @"navicon",
             @"\ue72c" : @"naviconRound",
             @"\ue72d" : @"musicNote",
             @"\ue72e" : @"more",
             @"\ue72f" : @"monitor",
             @"\ue730" : @"minus",
             @"\ue731" : @"minusRound",
             @"\ue732" : @"minusCircled",
             @"\ue733" : @"micC",
             @"\ue734" : @"micB",
             @"\ue735" : @"micA",
             @"\ue736" : @"medkit",
             @"\ue737" : @"map",
             @"\ue738" : @"man",
             @"\ue739" : @"male",
             @"\ue73a" : @"magnet",
             @"\ue73b" : @"loop",
             @"\ue73c" : @"logOut",
             @"\ue73d" : @"logIn",
             @"\ue73e" : @"locked",
             @"\ue73f" : @"location",
             @"\ue740" : @"loadD",
             @"\ue741" : @"loadC",
             @"\ue742" : @"loadB",
             @"\ue743" : @"loadA",
             @"\ue744" : @"link",
             @"\ue745" : @"lightbulb",
             @"\ue746" : @"levels",
             @"\ue747" : @"leaf",
             @"\ue748" : @"laptop",
             @"\ue749" : @"knife",
             @"\ue74a" : @"key",
             @"\ue74b" : @"jet",
             @"\ue74c" : @"ipod",
             @"\ue74d" : @"iphone",
             @"\ue74e" : @"ipad",
             @"\ue74f" : @"ionic",
             @"\ue750" : @"information",
             @"\ue751" : @"informationCircled",
             @"\ue752" : @"images",
             @"\ue753" : @"image",
             @"\ue754" : @"icecream",
             @"\ue755" : @"home",
             @"\ue756" : @"help",
             @"\ue757" : @"helpCircled",
             @"\ue758" : @"helpBuoy",
             @"\ue759" : @"heart",
             @"\ue75a" : @"headphone",
             @"\ue75b" : @"hammer",
             @"\ue75c" : @"grid",
             @"\ue75d" : @"gearB",
             @"\ue75e" : @"gearA",
             @"\ue75f" : @"gameControllerB",
             @"\ue760" : @"gameControllerA",
             @"\ue761" : @"forward",
             @"\ue762" : @"fork",
             @"\ue763" : @"folder",
             @"\ue764" : @"flask",
             @"\ue765" : @"flash",
             @"\ue766" : @"flashOff",
             @"\ue767" : @"flag",
             @"\ue768" : @"filmMarker",
             @"\ue769" : @"filing",
             @"\ue76a" : @"female",
             @"\ue76b" : @"eye",
             @"\ue76c" : @"email",
             @"\ue76d" : @"eject",
             @"\ue76e" : @"egg",
             @"\ue76f" : @"earth",
             @"\ue770" : @"drag",
             @"\ue771" : @"document",
             @"\ue772" : @"documentText",
             @"\ue773" : @"disc",
             @"\ue774" : @"contrast",
             @"\ue775" : @"connectionBars",
             @"\ue776" : @"compose",
             @"\ue777" : @"compass",
             @"\ue778" : @"coffee",
             @"\ue779" : @"code",
             @"\ue77a" : @"codeWorking",
             @"\ue77b" : @"codeDownload",
             @"\ue77c" : @"cloud",
             @"\ue77d" : @"close",
             @"\ue77e" : @"closeRound",
             @"\ue77f" : @"closeCircled",
             @"\ue780" : @"clock",
             @"\ue781" : @"clipboard",
             @"\ue782" : @"chevronUp",
             @"\ue0fc" : @"chevronRight",
             @"\ue784" : @"chevronLeft",
             @"\ue785" : @"chevronDown",
             @"\ue786" : @"checkmark",
             @"\ue787" : @"checkmarkRound",
             @"\ue788" : @"checkmarkCircled",
             @"\ue789" : @"chatbubbles",
             @"\ue78a" : @"chatbubble",
             @"\ue78b" : @"chatbubbleWorking",
             @"\ue78c" : @"chatboxes",
             @"\ue78d" : @"chatbox",
             @"\ue78e" : @"chatboxWorking",
             @"\ue78f" : @"card",
             @"\ue790" : @"camera",
             @"\ue791" : @"calendar",
             @"\ue792" : @"calculator",
             @"\ue793" : @"briefcase",
             @"\ue794" : @"bookmark",
             @"\ue795" : @"bluetooth",
             @"\ue796" : @"beaker",
             @"\ue797" : @"batteryLow",
             @"\ue798" : @"batteryHalf",
             @"\ue799" : @"batteryFull",
             @"\ue79a" : @"batteryEmpty",
             @"\ue79b" : @"batteryCharging",
             @"\ue79c" : @"bag",
             @"\ue79d" : @"at",
             @"\ue79e" : @"arrowUpC",
             @"\ue79f" : @"arrowUpB",
             @"\ue7a0" : @"arrowUpA",
             @"\ue7a1" : @"arrowSwap",
             @"\ue7a2" : @"arrowShrink",
             @"\ue7a3" : @"arrowRightC",
             @"\ue7a4" : @"arrowRightB",
             @"\ue7a5" : @"arrowRightA",
             @"\ue7a6" : @"arrowReturnRight",
             @"\ue7a7" : @"arrowReturnLeft",
             @"\ue7a8" : @"arrowResize",
             @"\ue7a9" : @"arrowMove",
             @"\ue7aa" : @"arrowLeftC",
             @"\ue7ab" : @"arrowLeftB",
             @"\ue7ac" : @"arrowLeftA",
             @"\ue7ad" : @"arrowGraphUpRight",
             @"\ue7ae" : @"arrowGraphUpLeft",
             @"\ue7af" : @"arrowGraphDownRight",
             @"\ue7b0" : @"arrowGraphDownLeft",
             @"\ue7b1" : @"arrowExpand",
             @"\ue7b2" : @"arrowDownC",
             @"\ue7b3" : @"arrowDownB",
             @"\ue7b4" : @"arrowDownA",
             @"\ue7b5" : @"archive",
             @"\ue7b6" : @"alert",
             @"\ue7b7" : @"alertCircled",
             
             };
}

@end
