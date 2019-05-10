package com.yy.test.flutternative;

import android.os.Bundle;

import com.yy.test.flutternative.plugin.ViewRegistrant;

import io.flutter.app.FlutterActivity;

public class MainActivity extends FlutterActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        ViewRegistrant.registerWith(this,this);

    }
}
