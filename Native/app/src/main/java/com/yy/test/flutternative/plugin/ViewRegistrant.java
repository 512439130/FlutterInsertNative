package com.yy.test.flutternative.plugin;

import android.content.Context;
import android.util.Log;
import android.view.View;

import com.yy.test.flutternative.R;

import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.StandardMessageCodec;

/**
 * @author SoMustYY
 * @create 2019/5/10 12:34 PM
 * @organize 卓世达科
 * @describe
 * @update
 */
public class ViewRegistrant {
    private static final String TAG = "ViewRegistrant";
    public static void registerWith(PluginRegistry registry, Context context){
        final String key = ViewRegistrant.class.getCanonicalName();

        if(registry.hasPlugin(key)){
            Log.d(TAG,"return");
            return;
        }
        PluginRegistry.Registrar registrar = registry.registrarFor(key);

        View tab1View = View.inflate(context, R.layout.tab1_view,null);
        View tab2View = View.inflate(context,R.layout.tab2_view,null);
        View tab3View = View.inflate(context,R.layout.tab3_view,null);

        registrar.platformViewRegistry().registerViewFactory("AndroidViewTest1", new TestViewFactory(new StandardMessageCodec(),tab1View));
        registrar.platformViewRegistry().registerViewFactory("AndroidViewTest2", new TestViewFactory(new StandardMessageCodec(),tab2View));
        registrar.platformViewRegistry().registerViewFactory("AndroidViewTest3", new TestViewFactory(new StandardMessageCodec(),tab3View));

    }
}
