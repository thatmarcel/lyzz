#import "LyzzView.h"

@implementation LyzzView
    @synthesize color;
    @synthesize prefs;

    - (void) setupWithType:(LyzzType)type {
        [LyzzLogging logString: @"[LyzzView] Setup"];

        self.type = type;
        self.prefs = [[SavedPrefs alloc] init];

        self.userInteractionEnabled = false;
        [self setupView];

        [[NSDistributedNotificationCenter defaultCenter] addObserverForName: @"com.thatmarcel.tweaks.lyzz/updateValues"
            object: nil
            queue: [NSOperationQueue mainQueue]
            usingBlock: ^(NSNotification *notification)
        {
            NSArray *values = [notification.userInfo objectForKey: @"values"];
            [self updateViewWithValues: values];
        }];
    }

    - (void) setupView {
        // Implementation up to the individual subclasses
    }

    - (void) updateViewWithValues:(NSArray*)values {
        // Implementation up to the individual subclasses
    }

    - (void) changeColorTo:(UIColor*)_color {
        if ([self.prefs isColorFlowEnabledForType: self.type]) {
            [self _changeColorTo: _color];
        }
    }

    - (void) _changeColorTo:(UIColor*)_color {
        // Implementation up to the individual subclasses
    }

@end
