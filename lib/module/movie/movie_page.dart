import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/data/movie_api.dart';
import 'package:flutter_learn/generated/i18n.dart';
import 'package:flutter_learn/model/web_view_model.dart';
import 'package:flutter_learn/module/movie/model/movie_model.dart';
import 'package:flutter_learn/router_manger.dart';
import 'package:flutter_learn/util/log_util.dart';
import 'package:flutter_learn/util/toast_util.dart';
import 'package:flutter_learn/view_model/theme_model.dart';
import 'package:flutter_learn/widget/skeleton.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///豆瓣电影页面-tab页
class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage>
    with SingleTickerProviderStateMixin {
  var _listUrls = [
    MovieApi.API_TOP,
    MovieApi.API_IN_THEATERS,
    MovieApi.API_COMING_SOON
  ];
  var _listTab = ["", "", ""];
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController =
        TabController(initialIndex: 0, length: _listTab.length, vsync: this);
    LogUtil.e("_MoviePageState_initState");
  }

  @override
  Widget build(BuildContext context) {
    _listTab = [
      S.of(context).movieTop,
      S.of(context).movieInTheaters,
      S.of(context).movieComingSoon
    ];
    return DefaultTabController(
      length: _listTab.length,
      child: Scaffold(
        appBar: AppBar(
          ///包裹一层去掉水波纹效果-如果保留可不设置该属性
          title: Container(
            ///添加该属性去掉Tab按下水波纹效果
            color: Theme.of(context).appBarTheme.color,
            child: TabBarWidget(
              controller: _tabController,
              labels: _listTab,
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: List.generate(
              _listTab.length,
              (i) => MovieItemPage(
                    url: _listUrls[i],
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
  ///起始页码
  int _page = 0;

  ///每页数量
  int _pageSize = 20;

  ///返回列表数量
  List<Subjects> _listData;

  ///下拉刷新controller
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ///是否可加载更多
  bool _canLoadMore = true;

  ///是否加载成功
  bool _loadSucceed = true;
  ScrollController _scrollController;
  bool _isDispose = false;

  ///是否展示FloatingActionButton
  bool _isShowFloatBtn = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    ///设置滚动监听
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      bool show = offset > 600;
      if (show != _isShowFloatBtn) {
        LogUtil.e("offset:" +
            offset.toString() +
            ";show:" +
            show.toString() +
            ";_isShowFloatBtn:" +
            _isShowFloatBtn.toString());
        setState(() {
          _isShowFloatBtn = show;
        });
      }
    });
    getMovie();
  }

  @override
  void dispose() {
    _isDispose = true;
    _scrollController.dispose();
    super.dispose();
  }

  getMovie() async {
    try {
      List<Subjects> list =
          await MovieApi.getMovie(widget.url, _page * _pageSize, _pageSize);
      if (_page == 0 && _listData != null) {
        _listData.clear();
      }
      if (list.length > 0) {
        if (_listData == null) {
          _listData = list;
        } else {
          _listData.addAll(list);
        }
        if (_isDispose) {
          LogUtil.i("请求成功;页面已销毁");
        } else {
          setState(() {
            _loadSucceed = true;
            _canLoadMore = list.length >= _pageSize;
            _page++;
          });
        }
      }
    } catch (e, s) {
      if (_isDispose) {
        LogUtil.e("请求错误:" + s.toString() + ";页面已销毁");
      } else {
        ToastUtil.show(s.toString());
        setState(() {
          _loadSucceed = false;
        });
      }
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
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return _page == 0

        ///loading状态
        ? SkeletonList(
            builder: (context, index) => MovieSkeleton(),
          )

        ///加载列表
        : Scaffold(
            ///下拉刷新嵌套listView
            body: SmartRefresherWidget(
              page: _page,
              pageSize: _pageSize,
              scrollController: _scrollController,
              data: _listData,
              refreshController: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
            ),

            ///用于回到顶部
            floatingActionButton: !_isShowFloatBtn
                ? null
                : FloatingActionButton(
                    backgroundColor: Theme.of(context).appBarTheme.color,
                    child: Icon(
                      Icons.arrow_upward,
                      color:
                          Theme.of(context).appBarTheme.textTheme.title.color,
                    ),
                    onPressed: () {
                      _scrollController.animateTo(
                        0,
                        duration: new Duration(milliseconds: 300), // 300ms
                        curve: Curves.bounceIn, // 动画方式
                      );
                    },
                  ),
          );
  }

  @override
  bool get wantKeepAlive => true;
}

///嵌套下拉刷新
class SmartRefresherWidget extends StatelessWidget {
  ///起始页码
  final int page;

  ///每页数量
  final int pageSize;
  final ScrollController scrollController;

  ///返回列表数量
  final List<Subjects> data;

  ///下拉刷新controller
  final RefreshController refreshController;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;

  const SmartRefresherWidget(
      {Key key,
      this.page,
      this.pageSize,
      this.scrollController,
      this.data,
      this.refreshController,
      this.onRefresh,
      this.onLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: MaterialClassicHeader(
        backgroundColor: Theme.of(context).appBarTheme.color,
        color: Theme.of(context).appBarTheme.textTheme.title.color,
      ),
      footer: SmartLoadFooterWidget(),
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: ListView.builder(
        ///内容适配
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: data.length,
        controller: scrollController,
        itemBuilder: (context, index) {
          return MovieAdapter(
            data[index],
            page * pageSize + index,
          );
        },
      ),
    );
  }
}

///刷新脚
class SmartLoadFooterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      height: 50,
      builder: (BuildContext context, LoadStatus mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text(
            S.of(context).loadIdle,
            style: Theme.of(context).textTheme.caption,
          );
        } else if (mode == LoadStatus.loading) {
          body = CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = Text(
            S.of(context).loadFailed,
            style: Theme.of(context).textTheme.caption,
          );
        } else if (mode == LoadStatus.canLoading) {
          body = Text(
            S.of(context).loadIdle,
            style: Theme.of(context).textTheme.caption,
          );
        } else {
          body = Text(
            S.of(context).loadNoMore,
            style: Theme.of(context).textTheme.caption,
          );
        }
        return Container(
          height: 50,
          child: Center(child: body),
        );
      },
    );
  }
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
                borderRadius: BorderRadius.circular(1),
                child: CachedNetworkImage(
                  width: imgWidth,
                  height: imgHeight,
                  fit: BoxFit.fill,
                  imageUrl: item.images.small,

                  ///占位Widget
                  placeholder: (context, url) => Center(
                    child: Container(
                      color: Theme.of(context).hintColor.withOpacity(0.1),
                      width: imgWidth,
                      height: imgHeight,
                      child: CupertinoActivityIndicator(),
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
              SizedBox(
                width: 12,
              ),

              ///右边文字-设置flex=1宽度占用剩余部分全部以便其中文字自动换行
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ///右边文字描述
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      S.of(context).movieGenres + item.getGenres(),
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(
                      S.of(context).movieYear + item.year,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(
                      S.of(context).movieDirectors +
                          item.getDirectors(S.of(context).movieNobody),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(
                      S.of(context).movieActors +
                          item.getCasts(S.of(context).movieNobody),
                      overflow: TextOverflow.ellipsis,
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

///电影骨架屏效果
class MovieSkeleton extends StatelessWidget {
  final double imgWidth = 72;
  final double imgHeight = 100;

  MovieSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ///左边图片
          SkeletonBox(
            borderRadius: BorderRadius.circular(1),
            width: imgWidth,
            height: imgHeight,
          ),
          SizedBox(
            width: 12,
          ),

          ///右边文字-设置flex=1宽度占用剩余部分全部以便其中文字自动换行
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ///右边文字描述
                SkeletonBox(
                  margin: EdgeInsets.only(bottom: 7, top: 4),
                  width: 140,
                  height: 14,
                ),
                SkeletonBox(
                  margin: EdgeInsets.only(bottom: 7),
                  width: 100,
                  height: 12,
                ),
                SkeletonBox(
                  margin: EdgeInsets.only(bottom: 7),
                  width: 66,
                  height: 12,
                ),
                SkeletonBox(
                  margin: EdgeInsets.only(bottom: 7),
                  width: 160,
                  height: 12,
                ),
                SkeletonBox(
                  margin: EdgeInsets.only(bottom: 7),
                  width: 240,
                  height: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
