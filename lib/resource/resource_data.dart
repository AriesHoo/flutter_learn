import 'dart:ui';

import 'package:flutter/material.dart';

//颜色配置
class ColorData {
  //主色调
  static const Color accentColor = Color(0xFFF5AA0F);

  //背景颜色
  static const Color backgroundColor = Color(0xFFFAFAFA);

  //标题栏-AppBar背景色
  static const Color titleBackgroundColor = Colors.white;

  //标题栏-AppBar文本
  static const Color titleTextColor = Colors.black;

  //主黑色
  static const Color accentBlackColor = Colors.black;

  //边框线-分割线颜色
  static const Color lineColor = Color(0xFFDDDDDD);

  //不可操作颜色
  static const Color disabledColor = Color(0xFFDDDDDD);

  //输入框提示颜色
  static const Color hintColor = Color(0xFFCCCCCC);
}

class AppTheme {
  //应用主题
  static ThemeData themeData() {
    return ThemeData(
        //类苹果跟随滑动返回-修改后返回箭头及主标题iOS风格
        platform: TargetPlatform.iOS,
        primaryColor: ColorData.accentColor,
        primaryColorDark: ColorData.accentColor,
        //按钮水波纹
        splashColor: Color(0x66C8C8C8),
        accentColor: ColorData.accentColor,
        //Scaffold(脚手架)背景色
        scaffoldBackgroundColor: ColorData.backgroundColor,
        //禁止操作颜色
        disabledColor: ColorData.disabledColor,
        hintColor: ColorData.hintColor,
        //标题栏(AppBar)样式
        appBarTheme: AppBarTheme(
          //状态栏文字颜色
          brightness: Brightness.light,
          //文字相关配置
          textTheme: TextTheme(
            title: TextStyle(
              fontSize: 18,
              color: ColorData.titleTextColor,
            ),
            subtitle: TextStyle(
              fontSize: 14,
              color: ColorData.titleTextColor,
            ),
          ),
          iconTheme: IconThemeData(
            color: ColorData.titleTextColor,
          ),
          color: ColorData.titleBackgroundColor,
          elevation: 0.5,
        ));
  }
}
