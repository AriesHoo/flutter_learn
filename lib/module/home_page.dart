import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/data/movie_api.dart';
import 'package:flutter_learn/generated/i18n.dart';
import 'package:flutter_learn/model/web_view_model.dart';
import 'package:flutter_learn/router_manger.dart';
import 'package:flutter_learn/util/toast_util.dart';
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
  Color _iconCorlor;

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
      elevation: 1,
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

  @override
  Widget build(BuildContext context) {
    _iconCorlor = Theme.of(context).iconTheme.color;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appName),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: FadeInImage.assetNetwork(
                width: 32,
                placeholder: "assets/image/start/ic_launcher_round.png",
                image:
                    "https://avatars0.githubusercontent.com/u/19605922?s=460&v=4",
                fit: BoxFit.cover,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(RouteName.webView,
                  arguments: WebViewModel.getModel("Aries Hoo's jian shu",
                      "https://www.jianshu.com/u/a229eee96115"));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        primary: true,
        child: ListTileTheme(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ///选择字体
              ChoiceFontWidget(),

              ///选择语言
              ChoiceLanguageWidget(),

              ///黑夜模式
              Material(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  title: Text(S.of(context).darkMode),
                  leading: Icon(
                    Theme.of(context).brightness == Brightness.light
                        ? Icons.brightness_5
                        : Icons.brightness_2,
                    color: _iconCorlor,
                  ),
                  trailing: CupertinoSwitch(
                    activeColor: Theme.of(context).accentColor,
                    value: Theme.of(context).brightness == Brightness.dark,
                    onChanged: (bool checked) => switchDarkMode(context),
                  ),
                  onTap: () => switchDarkMode(context),
                ),
              ),

              ///选择颜色主题
              ChoiceThemeWidget(),
              FlatButton(
                child: Text("top250"),
                onPressed: (){
                  MovieAPi.getMovie("v2/movie/top250");
                },
              ),
              _getButtonWidget(S.of(context).loginPage, RouteName.login, null),
              _getButtonWidget(
                  S.of(context).webViewPage,
                  RouteName.webView,
                  WebViewModel.getModel(
                      "Aries Hoo's Github", "https://github.com/AriesHoo")),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void switchDarkMode(BuildContext context) {
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      ToastUtil.show("检测到系统为暗黑模式,已为你自动切换");
    } else {
      Provider.of<ThemeModel>(context).switchTheme(
          userDarkMode: Theme.of(context).brightness == Brightness.light);
    }
  }
}

///字体选择
class ChoiceFontWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(S.of(context).choiceFont),
            Text(
              ThemeModel.fontName(context),
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
        leading: Icon(
          Icons.font_download,
          color: Theme.of(context).iconTheme.color,
        ),
        children: <Widget>[
          ListView.builder(
              shrinkWrap: true,
              itemCount: ThemeModel.fontValueList.length,
              itemBuilder: (context, index) {
                var model = Provider.of<ThemeModel>(context);
                return RadioListTile(
                  value: index,
                  onChanged: (index) {
                    model.switchFont(index);
                  },
                  groupValue: model.fontIndex,
                  title: Text(
                    ThemeModel.fontName(context, i: index),
                    style: TextStyle(
                      fontFamily: model.fontFamilyIndex(index: index),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}

///系统语言选择
class ChoiceLanguageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              S.of(context).choiceLanguage,
              style: TextStyle(),
            ),
            Text(
              LocaleModel.localeName(
                  Provider.of<LocaleModel>(context).localeIndex, context),
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
        leading: Icon(
          Icons.public,
          color: Theme.of(context).iconTheme.color,
        ),
        children: <Widget>[
          ListView.builder(
              shrinkWrap: true,
              itemCount: LocaleModel.localeValueList.length,
              itemBuilder: (context, index) {
                var model = Provider.of<LocaleModel>(context);
                return RadioListTile(
                  value: index,
                  onChanged: (index) {
                    model.switchLocale(index);
                  },
                  groupValue: model.localeIndex,
                  title: Text(LocaleModel.localeName(index, context)),
                );
              })
        ],
      ),
    );
  }
}

///颜色主题选择
class ChoiceThemeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: ExpansionTile(
        initiallyExpanded: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              S.of(context).choiceTheme,
            ),
            Text(
              ThemeModel.themeName(context),
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
        leading: Icon(
          Icons.color_lens,
          color: Theme.of(context).iconTheme.color,
        ),
        children: <Widget>[
          ListView.builder(
              shrinkWrap: true,
              itemCount: ThemeModel.themeValueList.length,
              itemBuilder: (context, index) {
                var model = Provider.of<ThemeModel>(context);
                return RadioListTile(
                  value: index,
                  onChanged: (index) {
                    model.switchTheme(themeIndex: index);
                  },
                  groupValue: model.themeIndex,
                  title: Text(
                    ThemeModel.themeName(context, i: index),
                    style: TextStyle(
                      color: ThemeModel.themeValueList[index],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}

///抽屉栏
class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.network(
            "https://avatars0.githubusercontent.com/u/19605922?s=460&v=4",
            width: 100.0,
          ),
        ],
      ),
    );
  }
}
