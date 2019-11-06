package com.aries.flutter.learn

import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.view.View
import android.view.WindowManager
import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.util.Log

class MainActivity : FlutterActivity() {
    var themeSet = false
    var darkModel = false
    var colorTheme = Color.BLACK
    var colorNavigationTheme = Color.BLACK

    companion object {
        const val FLUTTER_LOG_CHANNEL = "perform_log"
        const val FLUTTER_DARK_MODEL = "dark_model"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        MethodChannel(flutterView, FLUTTER_LOG_CHANNEL).setMethodCallHandler { call, result ->
            logPrint(call)
        }
        MethodChannel(flutterView, FLUTTER_DARK_MODEL).setMethodCallHandler { call, result ->
            setDarkModel(call)
        }
    }

    private fun setDarkModel(call: MethodCall) {
        darkModel = call.argument("darkMode")!!
        colorTheme = Color.BLACK;
        if (darkModel) {
            Color.TRANSPARENT
        }
        colorNavigationTheme = colorTheme
        onWindowFocusChanged(true)
    }

    private fun logPrint(call: MethodCall) {
        var tag: String = call.argument("tag")!!
        var message: String = call.argument("msg")!!
        when (call.method) {
            "logV" -> Log.v(tag, message)
            "logD" -> Log.d(tag, message)
            "logI" -> Log.i(tag, message)
            "logW" -> Log.w(tag, message)
            "logE" -> Log.e(tag, message)
        }
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus && Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            Log.e("onWindowFocusChanged11", "darkModel:" + darkModel+";colorNavigationTheme:"+colorNavigationTheme)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                colorTheme = Color.TRANSPARENT
                window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
                var now = window.decorView.systemUiVisibility
                var systemUi = now
                if (!darkModel) {
                    systemUi = systemUi or View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR
                }
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    if (!darkModel) {
                        systemUi = systemUi or View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR
                    }
                    colorNavigationTheme = Color.TRANSPARENT
                }
                window.decorView.systemUiVisibility = systemUi
            }
            window.statusBarColor = colorTheme
            window.navigationBarColor = colorNavigationTheme
        }
    }
}
