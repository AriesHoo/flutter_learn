import 'package:flutter/material.dart';
import 'package:flutter_learn/model/web_view_model.dart';
import 'package:flutter_learn/module/start/login_page.dart';
import 'package:flutter_learn/module/web_view_page.dart';
import 'package:flutter_learn/router_manger.dart';
import 'package:flutter_learn/util/platform_util.dart';

//主页面
class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    print('initState');
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactive");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  void _pushPage(Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  RaisedButton _getButtonWidget(String text, String router, Object arguments) {
    return RaisedButton(
      elevation: 10,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      onPressed: () {
        Navigator.of(context).pushNamed(router, arguments: arguments);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _getButtonWidget('登录页', RouteName.login,null),
            _getButtonWidget(
                "webView",
                RouteName.webView,
                WebViewModel.getModel(
                    "Aries Hoo's Github", "https://github.com/AriesHoo")),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
