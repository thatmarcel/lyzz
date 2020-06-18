#import "SpotifyPlayerView.h"

BOOL addedView = false;
LyzzView *lyzzView;

SavedPrefs *prefs = [[SavedPrefs alloc] init];

%hook SPTNowPlayingBackgroundViewController

- (void) viewDidAppear:(BOOL)animated {
    %orig;

    if (![prefs isTypeEnabled: SpotifyType] || addedView) {
        return;
    }

    [LyzzLogging logString: @"[SpotifyPlayerView] Adding view"];

    CGRect rect = CGRectMake(16, 0, [UIScreen mainScreen].bounds.size.width - 32, [UIScreen mainScreen].bounds.size.height);

    lyzzView = [[LyzzViewBars alloc] initWithFrame: rect];
    [self.view addSubview: lyzzView];
    [lyzzView setupWithType: SpotifyType];

    // ColorFlow
    if ([%c(CFWSpotifyStateManager) class]) {
        [lyzzView changeColorTo: ((CFWSpotifyStateManager*) [%c(CFWSpotifyStateManager) sharedManager]).mainColorInfo.primaryColor];
    }

    addedView = true;
}

%end

// Support ColorFlow etc.
//
// Note that this method doesn't get called after
// viewDidAppear, that's why the color
// is grabbed from ColorFlow directly there
%hook SPTNowPlayingPlayButtonV2

- (void) setFillColor:(UIColor*) color {
    %orig;

    if (![prefs isTypeEnabled: SpotifyType] || !lyzzView || !color) {
        return;
    }

    [lyzzView changeColorTo: color];
}

%end
