#import "LockscreenNowPlayingView.h"

BOOL addedView = false;
LyzzViewBars *lyzzView;

UIColor *nextColor;

SavedPrefs *prefs = [[SavedPrefs alloc] init];

%hook CSMediaControlsViewController

- (void) viewDidAppear:(BOOL)animated {
    %orig;

    if (![prefs isTypeEnabled: LockscreenNotificationType] || addedView) {
        if (lyzzView && nextColor) {
            [lyzzView changeColorTo: nextColor];
            nextColor = NULL;
        }

        return;
    }

    [LyzzLogging logString: @"[LockscreenNowPlayingView] CSMediaControlsViewController.loadView"];

    if (![self valueForKey:@"_platterViewController"]) {
        [LyzzLogging logString: @"[LockscreenNowPlayingView] CSMediaControlsViewController._platterViewController is not defined"];
        return;
    }

    MRPlatterViewController *platterViewController = (MRPlatterViewController*) [self valueForKey:@"_platterViewController"];
    UIView *nowPlayingView = [platterViewController view];

    lyzzView = [[LyzzViewBars alloc] initWithFrame: nowPlayingView.bounds];
    [nowPlayingView addSubview: lyzzView];
    [nowPlayingView sendSubviewToBack: lyzzView];
    [lyzzView setupWithType: LockscreenNotificationType];

    addedView = true;
}

%end

%hook MediaControlsTransportButton

- (void) tintColorDidChange {
    %orig;

    if (![prefs isTypeEnabled: LockscreenNotificationType]) {
        return;
    }

    [lyzzView changeColorTo: self.tintColor];
}

- (void) cfw_colorize:(id)arg1 {
    %orig;

    if (![prefs isTypeEnabled: LockscreenNotificationType]) {
        return;
    }

    [lyzzView changeColorTo: self.tintColor];
}

%end
