import 'package:flutter/cupertino.dart';

class CupertinoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('中间文字'),
        backgroundColor: CupertinoColors.lightBackgroundGray,
      ),
      child: Center(
        child: CupertinoButton(
            color: CupertinoColors.destructiveRed,
            child: Text("Press"),
            onPressed: () {}),
      ),
    );
  }
}
