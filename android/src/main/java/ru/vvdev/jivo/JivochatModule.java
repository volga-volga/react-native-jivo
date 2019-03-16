package ru.vvdev.jivo;

import android.app.FragmentTransaction;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableNativeMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import java.util.HashMap;
import java.util.Map;

public class JivochatModule extends ReactContextBaseJavaModule implements Observer {
    private static final String REACT_CLASS = "jivochat";

    private JivoFragment jivo = null;

    private static ReactApplicationContext reactContext = null;

    JivochatModule(ReactApplicationContext context) {
        super(context);
        reactContext = context;
    }

    @Override
    public String getName() {
        return REACT_CLASS;
    }

    @Override
    public Map<String, Object> getConstants() {
        return new HashMap<>();
    }

    @ReactMethod
    public void callApiMethod(final String name, final String data) {
        if (this.jivo != null) {
            final JivochatModule self = this;
            reactContext.runOnUiQueueThread(new Runnable() {
                @Override
                public void run() {
                    try {
                        self.jivo.callApiMethod(name, data);
                    } catch (NullPointerException e) {
                    }
                }
            });
        }
    }

    @ReactMethod
    public void openChat(final String title, final int titleColor, final int toolbarColor) {
        final JivochatModule self = this;
        reactContext.runOnUiQueueThread(new Runnable() {
            @Override
            public void run() {
                FrameLayout frameLayout = new FrameLayout(reactContext);
                frameLayout.setId(R.id.jivo_fragment);
                frameLayout.setLayoutParams(new FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.MATCH_PARENT));
                ((ViewGroup) reactContext.getCurrentActivity().getWindow().getDecorView().findViewById(android.R.id.content)).addView(frameLayout);
                FragmentTransaction transaction = reactContext.getCurrentActivity().getFragmentManager().beginTransaction();
                self.jivo = new JivoFragment();
                Bundle bundle = new Bundle();
                bundle.putString("title", title);
                bundle.putInt("titleColor", titleColor);
                bundle.putInt("toolbarColor", toolbarColor);
                self.jivo.setArguments(bundle);
                self.jivo.addListener(self);
                transaction.add(R.id.jivo_fragment, self.jivo, JivoFragment.TAG);
                transaction.addToBackStack(JivoFragment.TAG);
                transaction.commit();
            }
        });
    }

    private static void emitDeviceEvent(String eventName, @Nullable WritableMap eventData) {
        Log.e("YUI", eventName);
        reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit(eventName, eventData);
    }

    @Override
    public void handleEvent(String event, String data) {
        WritableMap map = new WritableNativeMap();
        map.putString("data", data);
        emitDeviceEvent(event, map);
    }
}
