#import <Cordova/CDV.h>
#import <WatchConnectivity/WatchConnectivity.h>
@interface WatchOSApi : CDVPlugin <WCSessionDelegate>
{
    NSString *receiveCallbackId;
}
@property (nonatomic, copy) NSString *receiveCallbackId;

- (void) init:(CDVInvokedUrlCommand*)command;
- (void) getMessages:(CDVInvokedUrlCommand*)command;
- (void) sendMessage:(CDVInvokedUrlCommand*)command;
@end
