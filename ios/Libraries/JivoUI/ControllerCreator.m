//
//  ControllerCreator.m
//  JivoUI
//
//  Created by Nikita Sirotkin on 02/12/2018.
//  Copyright © 2018 Nikita Sirotkin. All rights reserved.
//

#import "ControllerCreator.h"
#import "ChatController.h"
#import <UIKit/UIKit.h>

@implementation ControllerCreator

+(ChatController*) createController: (NSDictionary *)options observer:(id<Observer>) _observer {
    NSBundle *assetBundle = [NSBundle bundleForClass:[self class]];
    NSString *bundlePath = [assetBundle pathForResource:@"JivoUI" ofType:@"bundle"];
    if (bundlePath) {
        assetBundle = [NSBundle bundleWithPath:bundlePath];
    }
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:assetBundle];
    ChatController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"chat"];
    [navigationController initFromRN:options observer: _observer];
    return navigationController;
}

@end
