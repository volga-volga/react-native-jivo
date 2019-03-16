//
//  ViewController.m
//  ApiDemo
//
//  Created by Dimmetrius on 14.01.16.
//  Copyright © 2016 JivoSite. All rights reserved.
//

#import "ChatController.h"

@interface ChatController () {
    //***************
    JivoSdk *jivoSdk;

    NSString *langKey;
}
@property(weak, nonatomic) IBOutlet UIWebView *JivoView;
@property(nonatomic) id<Observer> observer;
@end

@implementation ChatController
- (void) callApiMehod: (NSString*) method data: (NSString*)data {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [jivoSdk callApiMethod:method :data];
    });
}

- (void)initFromRN:(NSDictionary *)options observer:(id<Observer>) _observer{
    self.observer = _observer;
    self.options = options;
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0 green:((rgbValue & 0xFF00)
            >> 8) / 255.0   blue:(rgbValue & 0xFF) / 255.0 alpha:1.0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    langKey = [[NSBundle mainBundle] localizedStringForKey:(@"LangKey") value:@"ru" table:nil];
    jivoSdk = [[JivoSdk alloc] initWith:_JivoView :langKey];
    self.title = self.options[@"title"];
    [self.navigationController.navigationBar setBarTintColor:[self colorFromHexString:self.options[@"toolbarColor"]]];
    [self.navigationController.navigationBar setTintColor:[self colorFromHexString:self.options[@"titleColor"]]];
    [self.navigationController.navigationBar setTitleTextAttributes:
            @{NSForegroundColorAttributeName:[self colorFromHexString:self.options[@"titleColor"]]}];

    self.navigationController.navigationBar.topItem.title = @" ";

    jivoSdk.delegate = self;

    [jivoSdk prepare];

}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
    [jivoSdk start];

    self.navigationController.navigationBar.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    self.navigationController.navigationBar.layer.shadowRadius = 4.0f;
    self.navigationController.navigationBar.layer.shadowOpacity = 0.3f;

    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
    //*************
    [jivoSdk stop];

}

- (void)dealloc {
    //*************
    [jivoSdk stop];
}

//************************************************
- (void)onEvent:(NSString *)name :(NSString *)data; {
    NSLog(@"JIVOCHAT___:%@, data:%@", name, data);
    if ([[name lowercaseString] isEqualToString:@"url.click"]) {
        if ([data length] > 2) {
            NSString *urlStr = [data substringWithRange:NSMakeRange(1, [data length] - 2)];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        }
    }
    if (self.observer) {
        [self.observer onEvent: name data:data];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
