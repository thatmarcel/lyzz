#import "SavedPrefs.h"

@implementation SavedPrefs
    @synthesize preferences;

    - (instancetype) init {
        self = [super init];

        if (self) {
            self.preferences = [[HBPreferences alloc] initWithIdentifier: @"com.thatmarcel.tweaks.lyzz.prefs.defaults"];
            [preferences registerDefaults: @{
                @"tweak-enabled": @true,

                @"lockscreen-notification-enabled": @true,
                @"lockscreen-notification-color-style": @0,
                @"lockscreen-notification-custom-color": @"#ffffff",

                @"apple-music-enabled": @true,
                @"apple-music-color-style": @0,
                @"apple-music-custom-color": @"#ffffff",

                @"spotify-enabled": @true,
                @"spotify-color-style": @0,
                @"spotify-custom-color": @"#ffffff"
            }];
        }

        return self;
    }

    - (BOOL) isEnabled {
        return [preferences boolForKey:@"tweak-enabled"];
    }

    - (BOOL) isTypeEnabled:(LyzzType)type {

        if (![self isEnabled]) {
            return false;
        }

        NSString *key;

        switch (type) {
            case LockscreenNotificationType:
                key = @"lockscreen-notification-enabled";
                break;
            case AppleMusicType:
                key = @"apple-music-enabled";
                break;
            case SpotifyType:
                key = @"spotify-enabled";
                break;
            default:
                return false;
        }

        return [preferences boolForKey: key];
    }

    - (BOOL) isColorFlowEnabledForType:(LyzzType)type {
        NSString *key;

        switch (type) {
            case LockscreenNotificationType:
                key = @"lockscreen-notification-color-style";
                break;
            case AppleMusicType:
                key = @"apple-music-color-style";
                break;
            case SpotifyType:
                key = @"spotify-color-style";
                break;
            default:
                return false;
        }

        return [preferences integerForKey: key] == 0;
    }

    - (UIColor*) customColorForType:(LyzzType)type {
        NSString *key;

        switch (type) {
            case LockscreenNotificationType:
                key = @"lockscreen-notification-custom-color";
                break;
            case AppleMusicType:
                key = @"apple-music-custom-color";
                break;
            case SpotifyType:
                key = @"spotify-custom-color";
                break;
            default:
                return [UIColor whiteColor];
        }

        unsigned int hexInt = 0;

        NSScanner *scanner = [NSScanner scannerWithString: (NSString*) [preferences objectForKey: key]];

        // Tell scanner to skip the # character
        [scanner setCharactersToBeSkipped: [NSCharacterSet characterSetWithCharactersInString: @"#"]];
        [scanner scanHexInt: &hexInt];

        UIColor *color = [UIColor colorWithRed: ((CGFloat) ((hexInt & 0xFF0000) >> 16)) / 255
                            green: ((CGFloat) ((hexInt & 0xFF00) >> 8)) / 255
                            blue: ((CGFloat) (hexInt & 0xFF)) / 255
                            alpha: 1.0];

        return color;
    }
@end
