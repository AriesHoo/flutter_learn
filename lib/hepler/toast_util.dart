import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class ToastUtil {
  static show(String text) {
    showToast(text,
        backgroundColor: Colors.black.withOpacity(0.7),
        dismissOtherToast: true,
        textPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
        textStyle: TextStyle(fontSize: 18, color: Colors.white));
  }
}
