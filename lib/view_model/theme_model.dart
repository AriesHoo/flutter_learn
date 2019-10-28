import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/generated/i18n.dart';

///主题管理
class ThemeModel with ChangeNotifier {
  ///字体列表
  static const fontValueList = ['system', 'StarCandy', 'RunningHand'];
  static const kThemeColorIndex = 'kThemeColorIndex';

  /// 当前主题颜色
  MaterialColor _themeColor = Colors.blue;

  /// 用户选择的明暗模式
  bool _userDarkMode = false;

  /// 当前字体索引
  static int _fontIndex = 1;

  int get fontIndex => _fontIndex;

  /// 切换字体
  switchFont(int index) {
    _fontIndex = index;
    switchTheme();
  }

  static String fontFamily() {
    return fontValueList[_fontIndex];
  }

   String fontFamilyIndex({int index}) {
    return fontValueList[index ?? _fontIndex];
  }

  /// 切换指定色彩
  ///
  /// 没有传[brightness]就不改变brightness,color同理
  void switchTheme({bool userDarkMode, MaterialColor color}) {
    _themeColor = color ?? _themeColor;
    notifyListeners();
  }

  /// 随机一个主题色彩
  ///
  /// 可以指定明暗模式,不指定则保持不变
  void switchRandomTheme({Brightness brightness}) {
    int colorIndex = Random().nextInt(Colors.primaries.length - 1);
    switchTheme(
      userDarkMode: Random().nextBool(),
      color: Colors.primaries[colorIndex],
    );
  }

  /// 根据主题 明暗 和 颜色 生成对应的主题
  /// [dark]系统的Dark Mode
  themeData({bool platformDarkMode: false}) {
    var themeColor = _themeColor;
    var isDark = platformDarkMode || _userDarkMode;
    var accentColor = isDark ? themeColor[700] : _themeColor;
    var themeData = ThemeData(
      primarySwatch: accentColor,
      accentColor: accentColor,
      primaryColor: accentColor,

      ///类苹果跟随滑动返回-修改后返回箭头及主标题iOS风格
      platform: TargetPlatform.iOS,
      errorColor: Colors.red,
      toggleableActiveColor: accentColor,

      ///输入框光标
      cursorColor: accentColor,

      ///字体
      fontFamily: fontValueList[_fontIndex],
    );

    themeData = themeData.copyWith(
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: themeColor,
      ),
      appBarTheme: themeData.appBarTheme.copyWith(
        brightness: Brightness.light,
        color: Colors.white,
        elevation: 0,
        textTheme: TextTheme(
          title: TextStyle(
            color: _themeColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,

            ///字体
            fontFamily: fontValueList[_fontIndex],
          ),
        ),
        iconTheme: IconThemeData(color: _themeColor),
      ),
      iconTheme: themeData.iconTheme.copyWith(
        color: _themeColor,
      ),
      splashColor: themeColor.withAlpha(50),
      hintColor: themeData.hintColor.withAlpha(90),
      textTheme: themeData.textTheme.copyWith(
          subhead: themeData.textTheme.subhead
              .copyWith(textBaseline: TextBaseline.alphabetic)),
      textSelectionColor: accentColor.withAlpha(60),
      textSelectionHandleColor: accentColor.withAlpha(60),
      chipTheme: themeData.chipTheme.copyWith(
        pressElevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 10),
        labelStyle: themeData.textTheme.caption,
        backgroundColor: themeData.chipTheme.backgroundColor.withOpacity(0.1),
      ),
    );
    return themeData;
  }

  /// 数据持久化到shared preferences
  saveTheme2Storage(bool userDarkMode, MaterialColor themeColor) async {
    var index = Colors.primaries.indexOf(themeColor);
  }




  /// 根据索引获取字体名称,这里牵涉到国际化
  static String fontName(index, context) {
    switch (index) {
      case 0:
        return S.of(context).autoBySystem;
      case 1:
        return S.of(context).starCandy;
      case 2:
        return S.of(context).runningHand;
      default:
        return '';
    }
  }
}