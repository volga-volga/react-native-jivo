#import <UIKit/UIKit.h>
#import "JivoSdk.h"
#import "Observer.h"

@interface ChatController : UIViewController<JivoDelegate>
@property (strong, nonatomic) NSDictionary *options;
- (void) callApiMehod: (NSString*) method data: (NSString*)data;
- (void) initFromRN: (NSDictionary *)options observer:(id<Observer>) observer;
- (UIColor *)colorFromHexString:(NSString *)hexString;
@end
