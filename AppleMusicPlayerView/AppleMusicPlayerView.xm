#import "AppleMusicPlayerView.h"

LyzzView *lyzzView;

SavedPrefs *prefs = [[SavedPrefs alloc] init];

%hook MusicNowPlayingControlsViewController
    %property (nonatomic, assign) BOOL addedView;

    - (void) viewDidAppear:(BOOL)animated {
        %orig;

        [LyzzLogging logString: @"[AppleMusicPlayerView] viewDidAppear"];

        if (![prefs isTypeEnabled: AppleMusicType] || self.addedView || !self.view.subviews[3]) {
            return;
        }

        [LyzzLogging logString: @"[AppleMusicPlayerView] Adding view"];

        if ([prefs viewStyleForType: AppleMusicType] == LyzzViewTypeBars) {
            lyzzView = [[LyzzViewBars alloc] initWithFrame: self.view.subviews[3].bounds];
        } else {
            lyzzView = [[LyzzViewJello alloc] initWithFrame: self.view.subviews[3].bounds];
        }

        [self.view.subviews[3] addSubview: lyzzView];
        [lyzzView setupWithType: AppleMusicType];

        self.addedView = true;
    }

%end

%hook MPButton

    - (void) setTintColor:(UIColor*)color {
        %orig;

        if (![prefs isTypeEnabled: AppleMusicType]) {
            return;
        }

        [lyzzView changeColorTo: color];
    }

%end
