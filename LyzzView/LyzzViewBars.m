#import "LyzzViewBars.h"

@implementation LyzzViewBars

    - (void) setupView {
        [LyzzLogging logString: @"[LyzzViewBars] SetupView"];

        self.layer.sublayers = @[];

        CGFloat spacing = 8;
        CGFloat numberOfBars = 10;
        CGFloat barCornerRadius = 4;
        CGFloat barWidth = (self.frame.size.width - 32.0) / 12.0;

        for (int i = 0; i < numberOfBars; i++) {
            CALayer *layer = [[CALayer alloc] init];
            layer.cornerRadius = barCornerRadius;
            CGFloat x = (i * (barWidth + spacing));
            if (i == 0) {
                x += 16;
            }
            layer.frame = CGRectMake(x, self.frame.size.height, barWidth, 0);
            layer.opacity = 0.7;
            if ([self.prefs isColorFlowEnabledForType: self.type]) {
                layer.backgroundColor = self.color != NULL ? self.color.CGColor : [UIColor whiteColor].CGColor;
            } else {
                layer.backgroundColor = [self.prefs customColorForType: self.type].CGColor;
            }
            [self.layer addSublayer: layer];
        }
    }

    - (void) updateViewWithValues:(NSArray*)values {
        CGFloat spacing = 8;
        CGFloat barWidth = 26;

        int i = 0;
        for (CALayer *layer in [self.layer sublayers]) {
            CGFloat barHeight = self.frame.size.height * [(NSNumber*) values[i] doubleValue];
            CGFloat y = self.frame.size.height - barHeight;

            layer.frame = CGRectMake(i * (barWidth + spacing), y, barWidth, barHeight + 8);

            i++;
        }
    }

    - (void) _changeColorTo:(UIColor*)color {
        if (color == self.color) {
            return;
        }

        for (CALayer *layer in [self.layer sublayers]) {
            layer.backgroundColor = color.CGColor;
        }

        self.color = color;
    }

@end
