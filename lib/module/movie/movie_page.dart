import 'package:flutter/material.dart';

///豆瓣电影页面-tab页
class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage>
    with SingleTickerProviderStateMixin {
  var urls = [
    "v2/movie/top250",
    "v2/movie/in_theaters",
    "v2/movie/coming_soon"
  ];
  var labels = ["top250", "正在热映", '即将上映'];
  List<Widget> listWidget;
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller =
        TabController(initialIndex: 0, length: labels.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
//    return Container(
//      child: RaisedButton(
//        child: Text("豆瓣top250"),
//        onPressed: () async {
//          List<Subjects> list = await MovieAPi.getMovie("v2/movie/top250");
//          ToastUtil.show("model:" + list.length.toString());
//        },
//      ),
//    );
    return DefaultTabController(
      length: labels.length,
      child: Scaffold(
        appBar: AppBar(
          title: TabBarWidget(
            controller: controller,
            labels: labels,
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: List.generate(
              labels.length,
              (i) => MovieItemPage(
                    url: urls[i],
                  )),
        ),
      ),
    );
  }
}

///TabBar效果
class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    Key key,
    this.labels,
    this.controller,
  }) : super(key: key);
  final List labels;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      tabs: List.generate(
          labels.length,
          (i) => Tab(
                text: labels[i],
              )),

      ///超过长度自动滚动
      isScrollable: true,

      ///指示器高度
      indicatorWeight: 4,

      ///指示器y颜色
      indicatorColor: Theme.of(context).accentColor,

      ///指示器样式-根据label宽度
      indicatorSize: TabBarIndicatorSize.label,

      ///选中label颜色
      labelColor: Theme.of(context).accentColor,

      ///未选择label颜色
      unselectedLabelColor: Theme.of(context).hintColor,
    );
  }
}

///电影item页--最终展示效果
class MovieItemPage extends StatefulWidget {
  final String url;

  const MovieItemPage({Key key, this.url}) : super(key: key);

  @override
  _MovieItemPageState createState() => _MovieItemPageState();
}

class _MovieItemPageState extends State<MovieItemPage> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.url);
  }
}
