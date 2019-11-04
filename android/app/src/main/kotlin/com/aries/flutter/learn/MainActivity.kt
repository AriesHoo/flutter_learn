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
    var colorTheme = Color.parseColor("#66000000")
    var colorNavigationTheme = Color.parseColor("#66000000")

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
        colorTheme = if (darkModel) {
            Color.TRANSPARENT
        }else{
            Color.RED
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
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            colorTheme = Color.TRANSPARENT
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                window.statusBarColor = colorTheme
                window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
                var now = window.decorView.systemUiVisibility
                var systemUi = if (darkModel) {
                    now
                } else {
                    now or View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR
                }
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    if (!darkModel) {
                        systemUi or View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR
                    }
                    colorNavigationTheme = Color.TRANSPARENT
                    window.navigationBarColor = colorNavigationTheme
                }
                window.decorView.systemUiVisibility = systemUi
            }
        }
    }
}
