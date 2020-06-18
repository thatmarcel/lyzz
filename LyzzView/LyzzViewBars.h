#import "LyzzView.h"
#import "../Logging/LyzzLogging.h"

@interface LyzzViewBars : LyzzView
    - (void) setupView;
    - (void) updateViewWithValues:(NSArray*)values;
    - (void) _changeColorTo:(UIColor*)color;
@end
