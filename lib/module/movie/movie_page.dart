import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/data/movie_api.dart';
import 'package:flutter_learn/model/web_view_model.dart';
import 'package:flutter_learn/module/movie/model/movie_model.dart';
import 'package:flutter_learn/router_manger.dart';
import 'package:flutter_learn/util/toast_util.dart';
import 'package:flutter_learn/view_model/theme_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
    return DefaultTabController(
      length: labels.length,
      child: Scaffold(
        appBar: AppBar(
          ///包裹一层去掉水波纹效果-如果保留可不设置该属性
          title: Container(
            height: double.infinity,

            ///添加该属性去掉Tab按下水波纹效果
            color: Theme.of(context).appBarTheme.color,
            child: TabBarWidget(
              controller: controller,
              labels: labels,
            ),
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
      indicatorWeight: 2.5,

      ///指示器y颜色
      indicatorColor:
          ThemeModel.darkMode ? Colors.white : Theme.of(context).accentColor,

      ///指示器样式-根据label宽度
      indicatorSize: TabBarIndicatorSize.label,

      ///选中label颜色
      labelColor:
          ThemeModel.darkMode ? Colors.white : Theme.of(context).accentColor,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w600,
      ),

      ///未选择label颜色
      unselectedLabelColor: Theme.of(context).hintColor,
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.normal,
      ),
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
  ///起始页码
  int _page = 0;

  ///每页数量
  int _pageSize = 10;

  ///返回列表数量
  List<Subjects> _listData;

  ///下拉刷新controller
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ///是否可加载更多
  bool _canLoadMore = true;

  ///是否加载成功
  bool _loadSucceed = true;

  @override
  void initState() {
    super.initState();
    getMovie();
  }

  getMovie() async {
    try {
      List<Subjects> list =
          await MovieAPi.getMovie(widget.url, _page * _pageSize, _pageSize);
      if (_page == 0 && _listData != null) {
        _listData.clear();
      }
      if (list.length > 0) {
        if (_listData == null) {
          _listData = list;
        } else {
          _listData.addAll(list);
        }
        setState(() {
          _loadSucceed = true;
          _canLoadMore = list.length >= _pageSize;
          _page++;
        });
      }
    } catch (e, s) {
      ToastUtil.show(e.toString());
      setState(() {
        _loadSucceed = false;
      });
    }
  }

  void _onRefresh() async {
    _page = 0;
    getMovie();
  }

  void _onLoading() async {
    getMovie();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    debugPrint("_page:" +
        (_page == 0).toString() +
        ";canLoadMore:" +
        _canLoadMore.toString());
    _refreshController.loadComplete();
    _refreshController.refreshCompleted();
    if (_canLoadMore) {
      _refreshController.resetNoData();
    } else {
      _refreshController.loadNoData();
    }
    return _page == 0

        ///loading状态
        ? Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                color: Theme.of(context).hintColor.withOpacity(0.5),
                padding: EdgeInsets.all(20),
                child: CupertinoActivityIndicator(
                  radius: 12,
                ),
              ),
            ),
          )

        ///加载列表
//        : ListView.builder(
//            ///内容适配
//            shrinkWrap: true,
//            itemCount: _listData.length,
//            itemBuilder: (context, index) {
//              return MovieAdapter(_listData[index]);
//            },
//          );
        : SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = Text("pull up load");
                } else if (mode == LoadStatus.loading) {
                  body = CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = Text("Load Failed!Click retry!");
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("release to load more");
                } else {
                  body = Text("No more Data");
                }
                return Container(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.builder(
              ///内容适配
              shrinkWrap: true,
              itemCount: _listData.length,
              itemBuilder: (context, index) {
                return MovieAdapter(
                  _listData[index],
                  _page * _pageSize + index,
                );
              },
            ),
          );
  }

  @override
  bool get wantKeepAlive => true;
}

///电影适配器
class MovieAdapter extends StatelessWidget {
  const MovieAdapter(this.item, this.position, {Key key}) : super(key: key);
  final Subjects item;
  final int position;
  final double imgWidth = 72;
  final double imgHeight = 100;

  @override
  Widget build(BuildContext context) {
    ///外层Material包裹以便按下水波纹效果
    return Material(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(RouteName.webView,
            arguments: WebViewModel.getModel(item.title,
                item.alt + "?apikey=0b2bdeda43b5688921839c8ecb20399b")),

        ///Container 包裹以便设置padding margin及边界线
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          margin: EdgeInsets.symmetric(horizontal: 12),

          ///分割线
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.5,
                color: Theme.of(context).hintColor.withOpacity(0.2),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ///左边图片
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: CachedNetworkImage(
                  width: imgWidth,
                  height: imgHeight,
                  fit: BoxFit.fill,
                  imageUrl: item.images.small,
                  placeholder: (context, url) => Center(
                    child: Container(
                      color: Theme.of(context).hintColor.withOpacity(0.1),
                      width: imgWidth,
                      height: imgHeight,
                      child: CupertinoActivityIndicator(
                        radius: 12,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Container(
                      color: Theme.of(context).hintColor.withOpacity(0.1),
                      width: imgWidth,
                      height: imgHeight,
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
              ),

              ///右边文字
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
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
                    Text(
                      "导演:" + item.getDirectors(),
                      maxLines: 1,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(
                      "主演:" + item.getCasts(),
                      maxLines: 1,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
