#import <Cephei/HBPreferences.h>

typedef enum LyzzType : NSUInteger {
    LockscreenNotificationType,
    AppleMusicType,
    SpotifyType
} LyzzType;

@interface SavedPrefs : NSObject
    @property (nonatomic, strong) HBPreferences *preferences;

    - (instancetype) init;

    - (BOOL) isEnabled;
    - (BOOL) isTypeEnabled:(LyzzType)type;
    - (BOOL) isColorFlowEnabledForType:(LyzzType)type;
    
    - (UIColor*) customColorForType:(LyzzType)type;
@end
