#import "AudioExtMonitoring.h"

NSTimer *timer;

double lastHeartbeat;

%hook SBRestartManager

    // Run on respring
    - (void) initializeAndRunStartupTransition:(/*^block*/id)arg1 {
        %orig;

        if (![[[SavedPrefs alloc] init] isEnabled]) {
            return;
        }

        [self lyzzRestartMediaserverd];
        [self lyzzStartMonitoring];
    }

    %new
    - (void) lyzzRestartMediaserverd {
        [LyzzLogging logString: @"[AudioExtMonitoring] Restarting mediaserverd"];

        pid_t pid;
    	const char *args[] = { "killall", "-9", "mediaserverd", NULL };
    	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char *const *) args, NULL);
    }

    %new
    - (void) lyzzStartMonitoring {
        lastHeartbeat = [[NSDate date] timeIntervalSince1970];

        timer = [NSTimer scheduledTimerWithTimeInterval: 5
            target:   self
            selector: @selector(lyzzCheckIfAudioExtRunning)
            userInfo: nil
            repeats:  true];

        [[NSDistributedNotificationCenter defaultCenter] addObserverForName: @"com.thatmarcel.tweaks.lyzz/heartbeat"
            object: nil
            queue: [NSOperationQueue mainQueue]
            usingBlock: ^(NSNotification *notification)
        {
            lastHeartbeat = [[NSDate date] timeIntervalSince1970];
        }];
    }

    %new
    - (void) lyzzCheckIfAudioExtRunning {
        if (!lastHeartbeat) {
            return;
        }

        double timeSinceLastHeartbeat = [[NSDate date] timeIntervalSince1970] - lastHeartbeat;

        if (timeSinceLastHeartbeat < 0) {
            return;
        }

        if (timeSinceLastHeartbeat > 5) {
            [self lyzzRestartMediaserverd];
        }
    }

%end
