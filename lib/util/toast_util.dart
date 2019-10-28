import 'package:flutter/material.dart';
import 'package:flutter_learn/view_model/theme_model.dart';
import 'package:oktoast/oktoast.dart';

class ToastUtil {
  static BuildContext get context => null;

  static show(String text) {
    showToast(
      text,
      textStyle: TextStyle(
        fontSize: 16,
        fontFamily: ThemeModel.fontFamily(),
      ),
      backgroundColor: ThemeModel.themeColor.withOpacity(0.8),
      dismissOtherToast: true,
      radius: 6,
      textPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
    );
  }
}
