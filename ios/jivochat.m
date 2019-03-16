#import "jivochat.h"
#import <UIKit/UIKit.h>
#import "Libraries/JivoUI/JivoUI.h"
#import "Libraries/JivoUI/ChatController.h"

@implementation jivochat

- (void) onEvent: (NSString*) event data: (NSString*) data {
//  [self emitMessage:event params:@{ @"data": data}];
  [self sendEventWithName: event body:@{ @"data": data}];
}

- (NSArray<NSString *> *)supportedEvents
{
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
           @"agent.name"
       ];
}

RCT_EXPORT_MODULE()
RCT_EXPORT_METHOD(callApiMethod:(NSDictionary *)options)
{
  if (self.controller) {
    NSString* method = [options valueForKey:@"method"];
    NSString* data = [options valueForKey:@"data"];
    [self.controller callApiMehod: method data:data];
  }
}

RCT_EXPORT_METHOD(openChat:(NSDictionary *)options)
{
  ChatController* controller = [ControllerCreator createController: options observer: self];
  self.controller = controller;
  dispatch_async(dispatch_get_main_queue(), ^{
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    [rootViewController showViewController:controller sender:nil];
  });
}

- (void) emitMessage: (NSString*) event :(NSDictionary*) params {
  [self sendEventWithName: event body:params];
}
@end
