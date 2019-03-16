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

3. copy html directory to your project- see [official Jivo sdk repo](https://github.com/JivoSite/MobileSdk?_ga=2.72152790.471740219.1527007511-1234002791.1527007511)

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
