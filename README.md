# react-native-jivo

jivo sdk for react-native

## Installation

1. install library
```
yarn add react-native-jivo
```
2. link
```bash
react-native link
```

3. copy html directory to your project - see [official Jivo sdk repo](https://github.com/JivoSite/MobileSdk?_ga=2.72152790.471740219.1527007511-1234002791.1527007511)

4. ios - add JivoUI.framework to "Linked Frameworks and Libraries"

5. Change AppDelegate.m
replace
```bash
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;

```
with
```
  UINavigationController *rootViewController = [UINavigationController new];
  UIViewController *ReactViewController = [UIViewController new];
  ReactViewController.view = rootView;
  [rootViewController pushViewController:ReactViewController animated:YES];
  self.window.rootViewController = rootViewController;
  rootViewController.navigationBar.layer.hidden = YES;
```

## Usage
```
import JivoChat from 'react-native-jivo';

JivoChat.openChat();
JivoChat.emitter.addListener(JivoChat.Events.client_info, listener);
JivoChat.callApiMethod(JivoChat.Methods.getUserInfo);
JivoChat.emitter.removeListener(JivoChat.Events.client_info, listener);
```

# TODO
- [ ] npm publish
- [ ] example
