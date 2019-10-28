import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/manager/resource_manager.dart';

///主题管理
class ThemeModel with ChangeNotifier {
  static const kThemeColorIndex = 'kThemeColorIndex';

  /// 当前主题颜色
  MaterialColor _themeColor = Colors.blue;

  /// 用户选择的明暗模式
  bool _userDarkMode = false;

  /// 当前字体索引
  int _fontIndex;

  int get fontIndex => _fontIndex;

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
      primarySwatch: themeColor,
      accentColor: accentColor,
      platform: TargetPlatform.iOS,
      errorColor: Colors.red,
      toggleableActiveColor: accentColor,
      cursorColor: accentColor,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    );

    themeData = themeData.copyWith(
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: themeColor,
      ),
      appBarTheme: themeData.appBarTheme.copyWith(elevation: 0),
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
}
