#import "LyzzPrefsController.h"

@implementation LyzzPrefsController

    + (nullable NSString *) hb_specifierPlist {
	    return @"Root";
    }

    - (instancetype)init {
        self = [super init];

        if (self) {
            LyzzHBAppearanceSettings *appearanceSettings = [[LyzzHBAppearanceSettings alloc] init];
            appearanceSettings.tintColor = [UIColor colorWithRed: 0.969 green: 0.0588 blue: 1.0 alpha: 1.0];
            self.hb_appearanceSettings = appearanceSettings;
        }

        return self;
    }

    - (void) respring {
        pid_t pid;
    	const char *args[] = { "sbreload", NULL };
    	posix_spawn(&pid, "/usr/bin/sbreload", NULL, NULL, (char *const *) args, NULL);
    }

@end
