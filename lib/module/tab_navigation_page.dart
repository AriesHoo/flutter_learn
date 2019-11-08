import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/generated/i18n.dart';
import 'package:flutter_learn/model/web_view_model.dart';
import 'package:flutter_learn/module/index/index_page.dart';
import 'package:flutter_learn/module/movie/movie_page.dart';
import 'package:flutter_learn/module/movie/movie_tab_page.dart';
import 'package:flutter_learn/module/start/login_page.dart';
import 'package:flutter_learn/module/web_view_page.dart';
import 'package:flutter_learn/util/log_util.dart';
import 'package:flutter_learn/util/platform_util.dart';
import 'package:flutter_learn/util/toast_util.dart';
import 'package:oktoast/oktoast.dart';


///BottomNavigationBar+PageView
class TabNavigationPage extends StatefulWidget {
  TabNavigationPage({Key key}) : super(key: key);

  @override
  _TabNavigationPageState createState() => _TabNavigationPageState();
}

class _TabNavigationPageState extends State<TabNavigationPage>
    with WidgetsBindingObserver {
  DateTime _lastPressedAt; //上次点击时间

  @override
  void initState() {
    super.initState();

    ///添加监听用于监控前后台转换
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didUpdateWidget(TabNavigationPage oldWidget) {
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

    ///移除监听
    WidgetsBinding.instance.removeObserver(this);
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    LogUtil.e(
        "didChangeAppLifecycleState:" +
            state.toString() +
            ";isAndroid:" +
            Platform.isAndroid.toString(),
        tag: "didChangeAppLifecycleState");
    if (state == AppLifecycleState.paused) {
      ///应用后台
    } else if (state == AppLifecycleState.resumed) {
      ///应用前台
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) >
                Duration(milliseconds: 1500)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          ToastUtil.show(S.of(context).quitApp,
              position: ToastPosition.bottom,
              duration: Duration(milliseconds: 1500));
          return false;
        }
        return true;
      },
      child: HomeWidget(),
    );
  }
}

///主干部分
class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with AutomaticKeepAliveClientMixin {
  var _pageController = PageController();
  int _selectedIndex = 0;
  List<Widget> _listPage = <Widget>[
    IndexPage(),
    MoviePage(),
    MovieTabPage(),
    LoginPage(),
  ];
  List<String> _listTitle = ["", "", "", ""];
  List<IconData> _listIcon = [
    Icons.home,
    Icons.movie,
    Icons.movie,
    Icons.assignment_ind,
  ];

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    _listTitle = [
      S.of(context).tab_index,
      S.of(context).tab_movie,
      S.of(context).tab_movie,
      S.of(context).tab_login,
    ];
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (ctx, index) => _listPage[index],
        itemCount: _listPage.length,
        controller: _pageController,

        ///控制是否可滚动
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        ///当前选中tab
        currentIndex: _selectedIndex,

        ///点击事件
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        elevation: 20,
        type: BottomNavigationBarType.fixed,

        ///背景色保持和appBar一致方便颜色主题统一
        backgroundColor: Theme.of(context).appBarTheme.color,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 28,
        items: List.generate(_listPage.length, (index) {
          return BottomNavigationBarItem(
            icon: Icon(_listIcon[index]),

            ///选中icon
            activeIcon: Icon(Icons.android),
            title: Text(_listTitle[index]),
          );
        }),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  bool get wantKeepAlive => true;
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
