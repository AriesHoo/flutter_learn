import 'package:flutter/services.dart';
import 'package:flutter_learn/util/platform_util.dart';

///调用Android原生log
class LogUtil {
  static const String tag = "LogUtil";
  static const performLog = const MethodChannel("perform_log");

  ///
  static i(String msg, {String tag}) {
    if (Platform.isAndroid) {
      performLog.invokeMethod('logI', {'tag': tag ?? LogUtil.tag, 'msg': msg});
      return;
    }
    print(msg);
  }

  static d(String msg, {String tag}) {
    if (Platform.isAndroid) {
      performLog.invokeMethod('logD', {'tag': tag ?? LogUtil.tag, 'msg': msg});
      return;
    }
    print(msg);
  }

  static v(String msg, {String tag}) {
    if (Platform.isAndroid) {
      performLog.invokeMethod('logV', {'tag': tag ?? LogUtil.tag, 'msg': msg});
      return;
    }
    print(msg);
  }

  static w(String msg, {String tag}) {
    if (Platform.isAndroid) {
      performLog.invokeMethod('logW', {'tag': tag ?? LogUtil.tag, 'msg': msg});
      return;
    }
    print(msg);
  }

  static e(String msg, {String tag}) {
    if (Platform.isAndroid) {
      performLog.invokeMethod('logE', {'tag': tag ?? LogUtil.tag, 'msg': msg});
      return;
    }
    print(msg);
  }
}
