#import <Foundation/Foundation.h>
#import "../NSDistributedNotificationCenter.h"
#import "../Logging/LyzzLogging.h"
#import "../SavedPrefs.h"

@interface LyzzView : UIView
    @property (nonatomic, strong) SavedPrefs *prefs;
    @property (nonatomic, assign) LyzzType type;

    - (void) setupWithType:(LyzzType)type;
    - (void) setupView;
    - (void) updateViewWithValues:(NSArray*)values;
    - (void) changeColorTo:(UIColor*)color;
    - (void) _changeColorTo:(UIColor*)color; // Only gets called when ColorFlow is enabled

    @property (nonatomic, assign) UIColor *color;
@end
