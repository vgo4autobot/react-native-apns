
# react-native-apns

## Getting started

`$ npm install react-native-apns --save`

### Mostly automatic installation

`$ react-native link react-native-apns`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-apns` and add `RNApns.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNApns.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. In the AppDelegate.m add following:

#import "RNApns.h"

.....
......

// Required for the register event.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
[RNApns didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

// Required for the registrationError event.
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
[RNApns didFailToRegisterForRemoteNotificationsWithError:error];
}




5. Run your project (`Cmd+R`)< 




## Usage
```javascript
import RNApns from 'react-native-apns';

// TODO: What to do with the module?

RNApns.getToken().then((token) => 
{
    console.log(`token${token}`);
    console.log('apns_token_success');
},
(error) => 
{
console.log('apns_token_failed');
console.log(error);
});


```
  
