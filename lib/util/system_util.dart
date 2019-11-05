import 'dart:io';

import 'package:flutter/services.dart';

///系统操作相关
class SystemUtil {
  static const performSystem = const MethodChannel("dark_model");

  static setDarkModel(bool darkMode) {
    if (Platform.isAndroid) {
      performSystem.invokeMethod('setDarkModel', {'darkMode': darkMode});
      return;
    }
  }
}
