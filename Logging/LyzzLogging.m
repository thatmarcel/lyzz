#import "LyzzLogging.h"
#include <stdlib.h>

@implementation LyzzLogging

+ (void) logString:(NSString*)string {

    NSString *LOGGING_HOST_IP = @"192.168.178.82";
    BOOL LOGGING_ENABLED = true;

    if (!LOGGING_ENABLED) {
        return;
    }

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
        NSString *query = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
        // Add random cachebypass parameter to make sure it is actually making the request and not ignoring
        // it because a previous request was cached
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"http://%@:7070/log?string=%@&cachebypass=%iu", LOGGING_HOST_IP, query, arc4random_uniform(9999999)]];
        NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithURL: url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { }];
        [dataTask resume];
    });
}

@end
