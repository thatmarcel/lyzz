#import "../LyzzView/LyzzViewBars.h"
#import "../LyzzView/LyzzViewJello.h"
#import "../Logging/LyzzLogging.h"
#import "../SavedPrefs.h"

@interface SPTNowPlayingBackgroundViewController : UIViewController
@end

@interface CFWColorInfo : NSObject
    @property(nonatomic, getter=isBackgroundDark) BOOL backgroundDark;
    @property(retain, nonatomic) UIColor *secondaryColor;
    @property(retain, nonatomic) UIColor *primaryColor;
    @property(retain, nonatomic) UIColor *backgroundColor;
@end

@interface CFWSpotifyStateManager : NSObject
    + (instancetype) sharedManager;

    @property(readonly, retain, nonatomic) CFWColorInfo *mainColorInfo;
@end
