#import <spawn.h>
#import <signal.h>
#import "../NSDistributedNotificationCenter.h"
#import "../Logging/LyzzLogging.h"
#import "../SavedPrefs.h"

@interface SBRestartManager : NSObject
    - (void) lyzzRestartMediaserverd;
    - (void) lyzzStartMonitoring;
    - (void) lyzzCheckIfAudioExtRunning;
@end
