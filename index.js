import color2array from 'color2array';
import { NativeModules, Platform, NativeEventEmitter } from 'react-native';

const { jivochat } = NativeModules;
const jivoEmitter = new NativeEventEmitter(jivochat);

function parseHexColor(color) {
  const [r, g, b] = color2array(color);
  return (r << 16) + (g << 8) + b;
}

class JivoChat {
  static Events = {
    force_offline: "chat.force_offline",
    ready: "chat.ready",
    accept: "chat.accept",
    transferred: "chat.transferred",
    mode: "chat.mode",
    connecting: "connection.connecting",
    disconnect: "connection.disconnect",
    connect: "connection.connect",
    error: "connection.error",
    message: "agent.message",
    chat_close: "agent.chat_close",
    info: "agent.info",
    contact_info: "contact_info",
    name: "agent.name"
  };

  static Methods = {
    setContactInfo: 'setContactInfo',
    setChatInfo: 'setChatInfo',
    setCustomData: 'setCustomData',
    setUserToken: 'setUserToken',
    sendMessage: 'sendMessage',
    getContactInfo: 'getContactInfo',
    getAgentInfo: 'getAgentInfo',
    getAgentName: 'getAgentName',
    chatMode: 'chatMode',
  };

  static emitter = jivoEmitter;

  static openChat(title = 'support', titleColor = '#ffffff', toolbarColor = '#000000') {
    const parsedTitleColor = parseHexColor(titleColor);
    const parsedToolbarColor = parseHexColor(toolbarColor);
    if (Platform.OS === 'ios') {
      jivochat.openChat({
        title, titleColor: '#'+parsedTitleColor.toString(16), toolbarColor: '#'+parsedToolbarColor.toString(16)
      });
    } else {
      jivochat.openChat(title, parsedTitleColor, parsedToolbarColor);
    }
  }

  static callApiMethod(method = '', data = '') {
    if (method) {
      if (Platform.OS === 'ios') {
        jivochat.callApiMethod({ method, data });
      } else {
        jivochat.callApiMethod(method, data);
      }
    }
  }
}

export default JivoChat;
