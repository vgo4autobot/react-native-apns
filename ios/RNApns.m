
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
   if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 13) {
        if (![deviceToken isKindOfClass:[NSData class]]) {
            //记录获取token失败的描述
            return;
        }
        const unsigned *tokenBytes = (const unsigned *)[deviceToken bytes];
        NSString *strToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                              ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                              ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                              ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
        [[NSUserDefaults standardUserDefaults] setObject:strToken forKey:@"apnsToken"];
                  [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"deviceToken1:%@", strToken);
    }else {
        NSString *deviceTokenStr = [[[[deviceToken description]
                                         stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                        stringByReplacingOccurrencesOfString: @">" withString: @""]
                                       stringByReplacingOccurrencesOfString: @" " withString: @""];
           
           [[NSUserDefaults standardUserDefaults] setObject:deviceTokenStr forKey:@"apnsToken"];
           [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"Device Token: %@", deviceTokenStr);
    }
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
  
