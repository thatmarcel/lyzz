// Jello logic was taken and adapted from https://github.com/cbyrne/libmitsuhaforever

#import "LyzzJelloLayer.h"

@implementation LyzzJelloLayer

    - (id<CAAction>) actionForKey:(NSString *)event {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: event];
        animation.duration = 0.2f;
        return animation;
    }

@end
