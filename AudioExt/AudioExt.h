#import <AudioToolbox/AudioToolbox.h>
#import <Accelerate/Accelerate.h>
#import <Foundation/Foundation.h>
#import "../NSDistributedNotificationCenter.h"
#import "../Logging/LyzzLogging.h"
#import "../SavedPrefs.h"

@interface AudioExt: NSObject
    @property (retain) NSTimer *timer;
    @property (retain) NSTimer *heartbeatTimer;

    @property (nonatomic, assign) AudioBufferList *bufferList;

    @property (nonatomic, assign) UInt32 numberOfFrames;
    @property (nonatomic, assign) int numberOfFramesOver2;
    @property (nonatomic, assign) float fftNormFactor;

    @property (nonatomic, assign) float *outReal;
    @property (nonatomic, assign) float *outImaginary;
    @property (nonatomic, assign) float *out;

    @property (nonatomic, assign) COMPLEX_SPLIT output;

    @property (nonatomic, assign) int bufferLog2;
    @property (nonatomic, assign) FFTSetup fftSetup;
    @property (nonatomic, assign) float *window;

    @property (nonatomic, assign) BOOL accelerateIsReady;

    - (void) setup;
    - (void) sendHeartbeat;
    - (void) timerFired;
    - (void) fire;
    - (float*) process:(float *)data withLength:(int)length;
    - (void) setupAccelerateWithLength:(int)length;
@end
