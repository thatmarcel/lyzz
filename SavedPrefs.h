#import <Cephei/HBPreferences.h>

typedef enum LyzzType : NSUInteger {
    LockscreenNotificationType,
    AppleMusicType,
    SpotifyType
} LyzzType;

typedef enum LyzzViewType : NSUInteger {
    LyzzViewTypeBars,
    LyzzViewTypeWaves
} LyzzViewType;

@interface SavedPrefs : NSObject
    @property (nonatomic, strong) HBPreferences *preferences;

    - (instancetype) init;

    - (BOOL) isEnabled;
    - (BOOL) isTypeEnabled:(LyzzType)type;
    - (BOOL) isColorFlowEnabledForType:(LyzzType)type;

    - (UIColor*) customColorForType:(LyzzType)type;

    - (LyzzViewType) viewStyleForType:(LyzzType)type;
@end
