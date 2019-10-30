import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/data/movie_api.dart';
import 'package:flutter_learn/model/web_view_model.dart';
import 'package:flutter_learn/module/movie/model/movie_model.dart';
import 'package:flutter_learn/router_manger.dart';
import 'package:flutter_learn/util/toast_util.dart';
import 'package:oktoast/oktoast.dart';

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
    debugPrint("_MoviePageState_initState");
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

class _MovieItemPageState extends State<MovieItemPage>
    with AutomaticKeepAliveClientMixin {
  int _start = 0;
  int _pageSize = 10;
  List<Subjects> _listData;

  @override
  void initState() {
    super.initState();
    getMovie();
  }

  getMovie() async {
    List<Subjects> list =
        await MovieAPi.getMovie(widget.url, _start * _pageSize, _pageSize);
    if (list.length > 0) {
      if (_listData == null) {
        _listData = list;
      } else {
        _listData.addAll(list);
      }
      setState(() {
        _start++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("_start:" + (_start == 0).toString());
    return _start == 0
        ? Center(
            child: CupertinoActivityIndicator(
              animating: true,
              radius: 16,
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: _listData.length,
            itemBuilder: (context, index) {
              return Container(
                child: MovieAdapter(_listData[index]),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  width: 0.3,
                  color: Theme.of(context).hintColor.withOpacity(0.2),
                ))),
              );
            },
          );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

///电影适配器
class MovieAdapter extends StatelessWidget {
  const MovieAdapter(this.item, {Key key}) : super(key: key);
  final Subjects item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: ListTile(
        onTap: () => Navigator.of(context).pushNamed(RouteName.webView,
            arguments: WebViewModel.getModel(item.title,
                item.alt + "?apikey=0b2bdeda43b5688921839c8ecb20399b")),
        contentPadding: EdgeInsets.all(12),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///图片
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: FadeInImage.assetNetwork(
                width: 72,
                height: 100,
                placeholder: "assets/image/start/ic_launcher.png",
                image: item.images.large,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 12),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ///右边文字描述
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.subtitle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  "题材:" + item.getGenres(),
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  "年份:" + item.year,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
