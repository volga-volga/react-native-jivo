#import <Foundation/Foundation.h>

@protocol Observer <NSObject>
@required
- (void)handleEvent: (NSString*) event withData: (NSString*) data;
@end
