#import "AudioExt.h"

AudioExt *AudioExtInstance;

%hookf(OSStatus, AudioUnitRender, AudioUnit unit, AudioUnitRenderActionFlags *ioActionFlags, const AudioTimeStamp *inTimeStamp, UInt32 inOutputBusNumber, UInt32 inNumberFrames, AudioBufferList *ioData) {
    AudioComponentDescription unitDescription = {0};
    AudioComponentGetDescription(AudioComponentInstanceGetComponent(unit), &unitDescription);

    OSType type = unitDescription.componentSubType;

    unichar c[4];
    c[0] = (type >> 24) & 0xFF;
    c[1] = (type >> 16) & 0xFF;
    c[2] = (type >> 8) & 0xFF;
    c[3] = (type >> 0) & 0xFF;
    NSString *subType = [NSString stringWithCharacters:c length:4];

    if ([@"mcmx" isEqualToString: subType]) {
        AudioExtInstance.bufferList = ((unsigned long) inNumberFrames > 0) ? ioData : NULL;
    }

    return %orig;
}

@implementation AudioExt
    @synthesize timer;
    @synthesize bufferList;

    @synthesize numberOfFrames;
    @synthesize numberOfFramesOver2;
    @synthesize fftNormFactor;
    @synthesize outReal;
    @synthesize outImaginary;
    @synthesize out;
    @synthesize output;
    @synthesize bufferLog2;
    @synthesize fftSetup;
    @synthesize window;
    @synthesize accelerateIsReady;

    - (void) setup {
        if (![[[SavedPrefs alloc] init] isEnabled]) {
            return;
        }
        
        self.accelerateIsReady = false;

        [LyzzLogging logString: @"[AudioExt] Starting timers"];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.timer = [NSTimer scheduledTimerWithTimeInterval: 0.2
                target:   self
                selector: @selector(timerFired)
                userInfo: nil
                repeats:  true];

            self.heartbeatTimer = [NSTimer scheduledTimerWithTimeInterval: 1
                target:   self
                selector: @selector(sendHeartbeat)
                userInfo: nil
                repeats:  true];
        });
    }

    - (void) sendHeartbeat {
        [[NSDistributedNotificationCenter defaultCenter] postNotificationName: @"com.thatmarcel.tweaks.lyzz/heartbeat" object: nil userInfo: nil];
    }

    // Switch back to global queue
    - (void) timerFired {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self fire];
        });
    }

    - (void) fire {
        if (self.bufferList == NULL) {
            return;
        }

        UInt32 len = (*self.bufferList).mBuffers[0].mDataByteSize;
        float *data = (float *) (*bufferList).mBuffers[0].mData;

        if (!self.accelerateIsReady) {
            [self setupAccelerateWithLength: len];
        }

        if (len != self.numberOfFrames) {
            return;
        }

        float *processed = [self process: data withLength: len];

        int oneTwelfth = len / 24;

        NSArray *values = @[
            [NSNumber numberWithFloat: -processed[0]],
            [NSNumber numberWithFloat: -processed[oneTwelfth] * 5],
            [NSNumber numberWithFloat: -processed[oneTwelfth * 2] * 5],
            [NSNumber numberWithFloat: -processed[oneTwelfth * 3] * 5],
            [NSNumber numberWithFloat: -processed[oneTwelfth * 4] * 5],
            [NSNumber numberWithFloat: -processed[oneTwelfth * 5] * 5],
            [NSNumber numberWithFloat: -processed[oneTwelfth * 6] * 5],
            [NSNumber numberWithFloat: -processed[oneTwelfth * 7] * 5],
            [NSNumber numberWithFloat: -processed[oneTwelfth * 8] * 5],
            [NSNumber numberWithFloat: -processed[oneTwelfth * 9] * 5],
            [NSNumber numberWithFloat: -processed[oneTwelfth * 10] * 5],
            [NSNumber numberWithFloat: -processed[oneTwelfth * 11] * 5]
        ];

        NSMutableDictionary *userInfo = [NSMutableDictionary new];
        [userInfo setObject: values forKey: @"values"];
        [[NSDistributedNotificationCenter defaultCenter] postNotificationName: @"com.thatmarcel.tweaks.lyzz/updateValues" object: nil userInfo: userInfo];

        self.bufferList = NULL;
    }

    - (float*) process:(float *)data withLength:(int)length {
        vDSP_vmul(data, 1, window, 1, data, 1, length);
        vDSP_ctoz((COMPLEX *)data, 2, &output, 1, numberOfFramesOver2);
        vDSP_fft_zrip(fftSetup, &output, 1, bufferLog2, FFT_FORWARD);
        vDSP_zvabs(&output, 1, out, 1, numberOfFramesOver2);
        vDSP_vsmul(out, 1, &fftNormFactor, out, 1, numberOfFramesOver2);

        return out;
    }

    - (void) setupAccelerateWithLength:(int)length {
        [LyzzLogging logString: @"[AudioExt] Initializing Accelerate"];

        self.numberOfFrames = length;
        self.numberOfFramesOver2 = self.numberOfFrames / 2;
        self.fftNormFactor = -1.0 / 256.0;

        self.outReal = (float *) malloc(sizeof(float) * self.numberOfFramesOver2);
        self.outImaginary = (float *) malloc(sizeof(float) * self.numberOfFramesOver2);
        self.out = (float *) malloc(sizeof(float) * self.numberOfFramesOver2);

        COMPLEX_SPLIT _output;
        _output.realp = self.outReal;
        _output.imagp = self.outImaginary;
        self.output = _output;

        self.bufferLog2 = round(log2(self.numberOfFrames));
        self.fftSetup = vDSP_create_fftsetup(self.bufferLog2, kFFTRadix2);
        self.window = (float *) malloc(sizeof(float) * self.numberOfFrames);

        vDSP_hann_window(self.window, self.numberOfFrames, vDSP_HANN_NORM);

        self.accelerateIsReady = true;
    }
@end

%ctor {
    NSString *identifier = [[NSProcessInfo processInfo] processName];
    if (
        [identifier isEqualToString:@"FaceTime"]           ||
        [identifier isEqualToString:@"com.apple.facetime"] ||
        [identifier isEqualToString:@"com.apple.camera"]   ||
        [identifier isEqualToString:@"Camera"]
    ) {
        NSLog(@"[AudioExt] Detected FaceTime or Camera => Not starting");
        return;
    }

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AudioExtInstance = [[AudioExt alloc] init];
        [AudioExtInstance setup];
    });

    %init;
}
