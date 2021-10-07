package ru.vvdev.jivo;

import android.app.Fragment;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.webkit.WebView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.jivosite.sdk.JivoDelegate;
import com.jivosite.sdk.JivoSdk;

public class JivoFragment extends Fragment implements JivoDelegate, Observable {
    public static final String TAG = "JivoFragment";
    JivoSdk jivoSdk;
    Observer observer;

    TextView title;
    ImageView back;
    LinearLayout toolbar;
    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.activity_jivo, container, false);
    }
    @Override
    public void onDestroyView() {
        super.onDestroyView();
        getActivity().getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN);
    }
    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        getActivity().getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE);
        int toolbarColor = getArguments().getInt("toolbarColor", 0xFFFFFF);
        int titleColor = getArguments().getInt("titleColor", 0);
        String titleText = getArguments().getString("title", "Поддержка");
        title = getActivity().findViewById(R.id.title);
        toolbar = getActivity().findViewById(R.id.toolbar);
        back = getActivity().findViewById(R.id.back);
        title.setTextColor(titleColor + (0xFF << 56));
        toolbar.setBackgroundColor(toolbarColor + (0xFF << 56));
        back.setColorFilter(titleColor + (0xFF << 56));
        title.setText(titleText);
        back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().onBackPressed();
            }
        });
        String lang = "ru";

        jivoSdk = new JivoSdk((WebView) getActivity().findViewById(R.id.webview), lang);
        jivoSdk.delegate = this;
        jivoSdk.prepare();
    }

    public void callApiMethod(String name, String data) {
        jivoSdk.callApiMethod(name, data);
    }

    @Override
    public void onEvent(String name, String data) {
        if(name.equals("url.click")){
            if(data.length() > 2){
                String url = data.substring(1, data.length() - 1);
                Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
                startActivity(browserIntent);
            }
        }
        observer.handleEvent(name, data);
    }


    @Override
    public void addListener(Observer obs) {
        observer = obs;
    }
}
