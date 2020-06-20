// Jello logic was taken and adapted from https://github.com/cbyrne/libmitsuhaforever

#import "LyzzJelloLayer.h"
#import "LyzzView.h"

@interface LyzzViewJello : LyzzView

    @property(nonatomic, strong) LyzzJelloLayer *waveLayer;
    @property(nonatomic, strong) LyzzJelloLayer *subwaveLayer;

    - (void) setupView;
    - (void) updateViewWithValues:(NSArray*)values;
    - (void) _changeColorTo:(UIColor*)color;

    - (CGPathRef) createPathWithValues:(NSArray *)values;

@end
