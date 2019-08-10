#import "jivochat.h"

@implementation jivochat

RCT_EXPORT_MODULE()

- (void)handleEvent:(NSString *)event withData:(NSString *)data {
    [self sendEventWithName:event body:data];
}

- (NSArray<NSString *> *)supportedEvents {
    return @[
            @"chat.force_offline",
            @"chat.ready",
            @"chat.accept",
            @"chat.transferred",
            @"chat.mode",
            @"connection.connecting",
            @"connection.disconnect",
            @"connection.connect",
            @"connection.error",
            @"agent.message",
            @"agent.chat_close",
            @"agent.info",
            @"contact_info",
            @"url.click",
            @"agent.name"
    ];
}

RCT_EXPORT_METHOD(callApiMethod:(NSDictionary *) options) {
  if (self.controller) {
    NSString* method = [options valueForKey:@"method"];
    NSString* data = [options valueForKey:@"data"];
    [self.controller callApiMehod: method data:data];
  }
}

RCT_EXPORT_METHOD(openChat:(NSDictionary *) options) {
  self.controller = [[ChatController alloc] init];
  [self.controller initFromRN:options withObserver:self];
  dispatch_async(dispatch_get_main_queue(), ^{
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    [rootViewController showViewController:self.controller sender:nil];
  });
}

@end
