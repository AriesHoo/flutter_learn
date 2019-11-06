

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/generated/i18n.dart';
import 'package:flutter_learn/model/web_view_model.dart';
import 'package:flutter_learn/util/toast_util.dart';
import 'package:flutter_learn/view_model/locale_model.dart';
import 'package:flutter_learn/view_model/theme_model.dart';
import 'package:provider/provider.dart';

import '../../router_manger.dart';

///主页面
class IndexPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
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
                placeholder: "assets/image/start/ic_launcher.png",
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
      body: IndexContainerWidget(),
    );
  }
}


class IndexContainerWidget extends StatelessWidget{
  Color iconColor;
  void switchDarkMode(BuildContext context) {
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      ToastUtil.show("检测到系统为暗黑模式,已为你自动切换");
    } else {
      Provider.of<ThemeModel>(context).switchTheme(
          userDarkMode: Theme.of(context).brightness == Brightness.light);
    }
  }
  @override
  Widget build(BuildContext context) {
    iconColor = Theme.of(context).iconTheme.color;
    return SingleChildScrollView(
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
                  color: iconColor,
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
          ],
        ),
      ),
    );
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