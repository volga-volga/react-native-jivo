#import "ChatController.h"
#import "Observer.h"

@interface ChatController () {
  //***************
  JivoSdk *jivoSdk;

  NSString *langKey;
  UIWebView *JivoView;
}

@end

@implementation ChatController
-(void) initFromRN: (NSDictionary *)options withObserver: (id<Observer>) obs {
  self.options = options;
  self.observer = obs;
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
  unsigned rgbValue = 0;
  NSScanner *scanner = [NSScanner scannerWithString:hexString];
  [scanner setScanLocation:1];
  [scanner scanHexInt:&rgbValue];
  return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0 green:((rgbValue & 0xFF00) >> 8) / 255.0   blue:(rgbValue & 0xFF) / 255.0 alpha:1.0];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  langKey = [[NSBundle mainBundle] localizedStringForKey:(@"LangKey") value:@"ru" table:nil];
  JivoView = [[UIWebView alloc] initWithFrame:self.view.frame];
  [self.view addSubview:JivoView];
  jivoSdk = [[JivoSdk alloc] initWith:JivoView :langKey];
  self.title = self.options[@"title"];
  [self.navigationController.navigationBar setBarTintColor:[self colorFromHexString:self.options[@"toolbarColor"]]];
  [self.navigationController.navigationBar setBackgroundColor:[self colorFromHexString:self.options[@"toolbarColor"]]];
  [self.navigationController.navigationBar setTintColor:[self colorFromHexString:self.options[@"titleColor"]]];
  [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[self colorFromHexString:self.options[@"titleColor"]]}];
  self.navigationController.navigationBar.topItem.title = @"";
  jivoSdk.delegate = self;
  [jivoSdk prepare];
}

- (void)viewWillAppear:(BOOL)animated {
  [self.navigationController setNavigationBarHidden:NO animated:animated];
  [super viewWillAppear:animated];
  [jivoSdk start];
  self.navigationController.navigationItem.backBarButtonItem.title = @" ";
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
  [jivoSdk stop];
}

- (void)dealloc {
  [jivoSdk stop];
}

- (void)onEvent:(NSString *)name :(NSString *)data; {
  if (self.observer) {
    [self.observer handleEvent:name withData:data];
  }
  if ([[name lowercaseString] isEqualToString:@"url.click"]) {
    if ([data length] > 2) {
      NSString *urlStr = [data substringWithRange:NSMakeRange(1, [data length] - 2)];
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    }
  }
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)callApiMethod: (NSString*) name withData: (NSString*) data {
  [jivoSdk callApiMethod:name :data];
}

@end
