# cordova-watchos-messageapi
A Cordova plugin for the communication with a WatchOS device. 
It allows you to send and receive messages from the nodes to which the device is connected.
The plugin works also if the application gets killed.

## Installation
With Cordova CLI, from npm:
```
$ cordova plugin add https://github.com/smartcommunitylab/cordova-watchos-messageapi
```

## Platform

* iOS

## Using

```javascript
WatchOSApi.init(success, error)
```
```javascript
WatchOSApi.getMessages(success, error)
```
```javascript
WatchOSApi.sendMessage(msg, success, error)
```

### Example
  ```javascript
  var app = {
initialize: function () {
    document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
},
    
    
onDeviceReady: function () {
    this.receivedEvent('deviceready');
    
    var listener = function () {
        WatchOSApi.getMessages(function (msg) {alert(msg);}, function (msg){alert("Error" + msg);});
    }
    
    document.getElementById("btnsend").addEventListener("click", function () { send('hello from Cordova'); }, false);
    WatchOSApi.init(listener, function (msg){alert("Error" + msg);});
},
    
receivedEvent: function (id) {
    var parentElement = document.getElementById(id);
    var listeningElement = parentElement.querySelector('.listening');
    var receivedElement = parentElement.querySelector('.received');
    
    listeningElement.setAttribute('style', 'display:none;');
    receivedElement.setAttribute('style', 'display:block;');
},
};
app.initialize();

function send(msg, success) {
    WatchOSApi.sendMessage(msg, function (){alert("Message send success");}, function (msg){alert("Error" + msg);});
}
  ```
### Apple Watch Application
```objective-c
#import "InterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>
@interface InterfaceController ()<WCSessionDelegate>
@end

@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    if([WCSession isSupported]){
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
}

- (void)willActivate {
    [super willActivate];
}

- (void)didDeactivate {
    [super didDeactivate];
}
- (IBAction)wearButtonTouched {
    NSString *message = @"Hello from Wearable";
    NSDictionary *messageDictionary = [[NSDictionary alloc] initWithObjects:@[message] forKeys:@[@"wearmsg"]];
    [[WCSession defaultSession] sendMessage:messageDictionary replyHandler:^(NSDictionary *reply){
        NSLog(@"Send success");
    } errorHandler:^(NSError *error) {
        NSLog(@"Send failed");
    }];}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler
{
    NSLog(@"watchOS received");
    WKAlertAction *act = [WKAlertAction actionWithTitle:@"OK" style:WKAlertActionStyleCancel handler:^(void){;}];
    NSArray *testing = @[act];    
    [self presentAlertControllerWithTitle:@"Received" message:[NSString stringWithFormat:@"You got a message: %@", message] preferredStyle:WKAlertControllerStyleAlert actions:testing];
}
@end
```
