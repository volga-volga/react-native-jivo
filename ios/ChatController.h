#import <UIKit/UIKit.h>
#import "JivoSdk.h"
#import "Observer.h"

@interface ChatController : UIViewController<JivoDelegate>

@property (strong, nonatomic) NSDictionary *options;
@property (nonatomic) id<Observer> observer;
-(void) initFromRN: (NSDictionary *)options withObserver: (id<Observer>) obs;
- (UIColor *)colorFromHexString:(NSString *)hexString;
- (void)callApiMethod: (NSString*) name withData: (NSString*) data;

@end
