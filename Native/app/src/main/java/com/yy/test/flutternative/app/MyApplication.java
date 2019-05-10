package com.yy.test.flutternative.app;

import android.app.Application;

import io.flutter.view.FlutterMain;

/**
 * @author SoMustYY
 * @create 2019/5/10 12:49 PM
 * @organize 卓世达科
 * @describe
 * @update
 */
public class MyApplication extends Application {
    private static MyApplication app;

    public static MyApplication getInstance() {
        return app;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        app = this;

        FlutterMain.startInitialization(getApplicationContext());
    }
}
