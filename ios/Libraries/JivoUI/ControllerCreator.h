//
//  ControllerCreator.h
//  JivoUI
//
//  Created by Nikita Sirotkin on 02/12/2018.
//  Copyright © 2018 Nikita Sirotkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Observer.h"
#import "ChatController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ControllerCreator : NSObject
+(ChatController *) createController: (NSDictionary *)options observer:(id<Observer>) _observer;
@end

NS_ASSUME_NONNULL_END
