// Jello logic was taken and adapted from https://github.com/cbyrne/libmitsuhaforever

#import "LyzzViewJello.h"

static CGPoint midPointForPoints(CGPoint p1, CGPoint p2) {
    return CGPointMake((p1.x + p2.x) / 2, (p1.y + p2.y) / 2);
}

static CGPoint controlPointForPoints(CGPoint p1, CGPoint p2) {
    CGPoint controlPoint = midPointForPoints(p1, p2);
    CGFloat diffY = fabs(p2.y - controlPoint.y);

    if (p1.y < p2.y) {
        controlPoint.y += diffY;
    } else if (p1.y > p2.y) {
        controlPoint.y -= diffY;
    }

    return controlPoint;
}

@implementation LyzzViewJello

    - (void) _changeColorTo:(UIColor*)color {
        self.waveLayer.fillColor = color.CGColor;
        self.subwaveLayer.fillColor = color.CGColor;
    }

    - (void) setupView {
        self.waveLayer = [LyzzJelloLayer layer];
        self.subwaveLayer = [LyzzJelloLayer layer];

        self.waveLayer.frame = self.bounds;
        self.subwaveLayer.frame = self.bounds;

        self.layer.sublayers = @[];

        [self.layer addSublayer: self.waveLayer];
        [self.layer addSublayer: self.subwaveLayer];

        self.waveLayer.zPosition = 0;
        self.subwaveLayer.zPosition = -1;

        self.waveLayer.opacity = 0.7;
        self.subwaveLayer.opacity = 0.2;
    }

    - (void) updateViewWithValues:(NSArray*)values {
        NSRange range;
        range.location = 0;
        range.length = [values count] / 2;

        NSArray *newValues = [values subarrayWithRange: range];

        CGPathRef path = [self createPathWithValues: newValues];
        self.waveLayer.path = path;

        [NSTimer scheduledTimerWithTimeInterval: 0.2 repeats:false block: ^ (NSTimer* timer) {
            self.subwaveLayer.path = path;
            CGPathRelease(path);
        }];
    }

    - (CGPathRef) createPathWithValues:(NSArray *)values {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint: CGPointMake(0, self.bounds.size.height)];

        int numberOfPoints = sizeof values;
        CGFloat widthPerPoint = self.bounds.size.width / numberOfPoints;

        CGPoint p1 = CGPointMake(0, self.bounds.size.height - (self.bounds.size.height * [(NSNumber*) values[0] doubleValue]));
        [path addLineToPoint: p1];

        int i = 0;
        for (NSNumber *number in values) {
            CGPoint p2 = CGPointMake(widthPerPoint * i, self.bounds.size.height - (self.bounds.size.height * [number doubleValue]));
            CGPoint midPoint = midPointForPoints(p1, p2);

            [path addQuadCurveToPoint: midPoint controlPoint: controlPointForPoints(midPoint, p1)];
            [path addQuadCurveToPoint: p2 controlPoint: controlPointForPoints(midPoint, p2)];

            p1 = p2;
            i++;
        }

        [path addLineToPoint: CGPointMake(self.bounds.size.width, self.bounds.size.height)];
        [path addLineToPoint: CGPointMake(0, self.bounds.size.height)];

        return CGPathCreateCopy(path.CGPath);
    }

@end
