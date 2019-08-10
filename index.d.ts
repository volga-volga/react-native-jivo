declare module 'react-native-jivo';

import { NativeEventEmitter } from 'react-native';

export type JivoEvents = 'force_offline' | 'ready' | 'accept' | 'transferred' | 'mode' | 'connecting' | 'disconnect' | 'connect' | 'error' | 'message' | 'chat_close' | 'info' | 'contact_info' | 'name';

export type JivoMethods = 'setContactInfo' | 'setChatInfo' | 'setCustomData' | 'setUserToken' | 'sendMessage' | 'getContactInfo' | 'getAgentInfo' | 'getAgentName' | 'chatMode';

export default class JivoChat {
  static Events: { [K in JivoEvents]: string };

  static Methods: { [K in JivoMethods]: string };

  static emitter: NativeEventEmitter;

  static openChat(title?: string, titleColor?: string, toolbarColor?: string);

  static callApiMethod(method: JivoMethods, data?: string);
}
