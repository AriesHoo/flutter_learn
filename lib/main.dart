import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/module/tab_navigation_page.dart';
import 'package:flutter_learn/router_manger.dart';
import 'package:flutter_learn/util/sp_util.dart';
import 'package:flutter_learn/view_model/locale_model.dart';
import 'package:flutter_learn/view_model/theme_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'generated/i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

Future main() async {
  ///初始化SP
//  await SPUtil.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPrint("mainPage");

    ///Toast配置
    return OKToast(
      ///Provider
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeModel>.value(value: ThemeModel()),
          ChangeNotifierProvider<LocaleModel>.value(value: LocaleModel()),
        ],
        child: Consumer2<ThemeModel, LocaleModel>(
          builder: (context, themeModel, localeModel, child) {
            return AppWidget(
              themeModel: themeModel,
              localeModel: localeModel,
            );
          },
        ),
      ),
    );
  }
}

///App
class AppWidget extends StatelessWidget {
  final ThemeModel themeModel;
  final LocaleModel localeModel;

  const AppWidget({
    Key key,
    this.themeModel,
    this.localeModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///全局主题配置
      theme: themeModel.themeData(),
      darkTheme: themeModel.themeData(platformDarkMode: true),

      ///去掉右上顶部debug标签
      debugShowCheckedModeBanner: false,

      ///国际化语言
      locale: localeModel.locale,
      localizationsDelegates: const [
        S.delegate,

        ///下拉刷新库国际化配置
        RefreshLocalizations.delegate,

        ///不配置该项会在EditField点击弹出复制粘贴工具时抛异常 The getter 'cutButtonLabel' was called on null.
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,

      ///配置页面路由
      onGenerateRoute: Router.generateRoute,

      ///主页
      home: TabNavigationPage(),
    );
  }
}
