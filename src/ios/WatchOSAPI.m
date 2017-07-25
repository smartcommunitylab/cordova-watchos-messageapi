#import "WatchOSApi.h"

@implementation WatchOSApi
    @synthesize receiveCallbackId;
    
- (void)init:(CDVInvokedUrlCommand*)command
    {
        CDVPluginResult* init = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        if ([WCSession isSupported]) {
            WCSession *session = [WCSession defaultSession];
            session.delegate = self;
            [session activateSession];
        } else {
            init = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"WCSession not supported"];
        }
        [self.commandDelegate sendPluginResult:init callbackId:[command callbackId]];
    }
    
- (void)getMessages:(CDVInvokedUrlCommand*)command {
    self.receiveCallbackId = [command callbackId];
}
    
- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * replyMessage))replyHandler{
    CDVPluginResult *receive = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[NSString stringWithFormat:@"You got a message: %@", message]];
    [receive setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:receive callbackId:receiveCallbackId];
}
    
- (void)sendMessage:(CDVInvokedUrlCommand*)command {
    __block CDVPluginResult *send = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    NSDictionary *messageDictionary = [[NSDictionary alloc] initWithObjects:@[[[command arguments] objectAtIndex:0]] forKeys:@[@"wearmsg"]];
    [[WCSession defaultSession]sendMessage:messageDictionary
                              replyHandler:^(NSDictionary<NSString *,id> * replyMessage) {;}
                              errorHandler:^(NSError * error) {
                                  send = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Message not sent"];
                              }
     ];
    [send setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:send callbackId:[command callbackId]];
}
    
@end
