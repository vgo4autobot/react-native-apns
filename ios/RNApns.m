
#import "RNApns.h"

@implementation RNApns

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(works)
{
   NSLog(@"Hello Native");
}

+ (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *deviceTokenStr = [[[[deviceToken description]
                                  stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                 stringByReplacingOccurrencesOfString: @">" withString: @""]
                                stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    [[NSUserDefaults standardUserDefaults] setObject:deviceTokenStr forKey:@"apnsToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
     NSLog(@"Device Token: %@", deviceTokenStr);
}

+ (void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
    NSLog(@"Device Token: ERROR");
}

//RCT_EXPORT_METHOD(getToken:(RCTResponseSenderBlock)callback)
//{
//    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
//                            stringForKey:@"apnsToken"];
//     NSLog(@"Retrieved Device Token: %@", savedValue);
//    callback(@[[NSNull null], savedValue]);
//}

RCT_REMAP_METHOD(getToken,
                 getTokenWithResolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"apnsToken"];
    NSLog(@"Retrieved Device Token: %@", savedValue);
    
    if (savedValue) {
        resolve(savedValue);
    } else {
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"null value returned" forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"RNApns" code:404 userInfo:details];
        reject(@"error", @"Null token returned.", error);
    }
}

@end
  
