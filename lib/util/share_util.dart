import 'package:share/share.dart';

///分享工具类
class ShareUtil {
  ///分享
  static share() async {
    Share.share("https://www.baidu.com/");
  }
}
