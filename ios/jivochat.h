#if __has_include(<React/RCTBridgeModule.h>)
#import <React/RCTBridgeModule.h>
#elif __has_include(“RCTBridgeModule.h”)
#import “RCTBridgeModule.h”
#else
#import “React/RCTBridgeModule.h” // Required when used as a Pod in a Swift project
#endif

// import RCTEventEmitter
#if __has_include(<React/RCTEventEmitter.h>)
#import <React/RCTEventEmitter.h>
#elif __has_include(“RCTEventEmitter.h”)
#import “RCTEventEmitter.h”
#else
#import “React/RCTEventEmitter.h” // Required when used as a Pod in a Swift project
#endif

#import "Libraries/JivoUI/Observer.h"
#import "Libraries/JivoUI/ChatController.h"

@interface jivochat : RCTEventEmitter <RCTBridgeModule, Observer>
@property (nonatomic) ChatController* controller;
- (void) onEvent: (NSString*) event data: (NSString*) data;
- (void) emitMessage: (NSString*) event :(NSDictionary*) params;
@end
