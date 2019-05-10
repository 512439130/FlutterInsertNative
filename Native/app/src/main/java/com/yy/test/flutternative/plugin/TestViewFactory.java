package com.yy.test.flutternative.plugin;

import android.content.Context;
import android.view.View;

import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

/**
 * @author SoMustYY
 * @create 2019/5/10 10:51 AM
 * @organize 卓世达科
 * @describe
 * @update
 */
public class TestViewFactory extends PlatformViewFactory {
    private View mView;

    public TestViewFactory(MessageCodec<Object> createArgsCodec,View view) {
        super(createArgsCodec);
        this.mView = view;
    }

    @Override
    public PlatformView create(Context context, int i, Object o) {
        return new PlatformView() {
            @Override
            public View getView() {
                return mView;
            }

            @Override
            public void dispose() {

            }
        };
    }
}
