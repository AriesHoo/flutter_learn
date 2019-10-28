import 'package:flutter/material.dart';
import 'package:flutter_learn/generated/i18n.dart';
import 'package:flutter_learn/model/web_view_model.dart';
import 'package:flutter_learn/router_manger.dart';
import 'package:flutter_learn/view_model/locale_model.dart';
import 'package:flutter_learn/view_model/theme_model.dart';
import 'package:provider/provider.dart';

///主页面
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
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

  RaisedButton _getButtonWidget(String text, String router, Object arguments) {
    return RaisedButton(
      elevation: 10,
      color: Theme.of(context).accentColor,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      onPressed: () {
        Navigator.of(context).pushNamed(router, arguments: arguments);
      },
    );
  }

  ///切换语言
  Future<void> _changeLanguage() async {
    int i = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(S.of(context).choiceLanguage),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  // 返回1
                  Navigator.pop(context, 0);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text(S.of(context).autoBySystem),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // 返回1
                  Navigator.pop(context, 1);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text(S.of(context).chinese),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // 返回2
                  Navigator.pop(context, 2);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text(S.of(context).english),
                ),
              ),
            ],
          );
        });

    if (i != null) {
      var model = Provider.of<LocaleModel>(context);
      model.switchLocale(i);
    }
  }

  ///切换主题色
  _changeColor() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(S.of(context).choiceTheme),
            content: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: <Widget>[
                ...Colors.primaries.map((color) {
                  return Material(
                    color: color,
                    child: InkWell(
                      onTap: () {
                        var model = Provider.of<ThemeModel>(context);
                        model.switchTheme(color: color);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appName),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.language),
            tooltip: S.of(context).choiceLanguage,
            onPressed: _changeLanguage,
          ),
          IconButton(
            icon: Icon(Icons.color_lens),
            tooltip: S.of(context).choiceTheme,
            onPressed: _changeColor,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _getButtonWidget(S.of(context).loginPage, RouteName.login, null),
            _getButtonWidget(
                S.of(context).webViewPage,
                RouteName.webView,
                WebViewModel.getModel(
                    "Aries Hoo's Github", "https://github.com/AriesHoo")),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
