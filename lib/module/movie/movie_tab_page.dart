import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/data/movie_api.dart';
import 'package:flutter_learn/generated/i18n.dart';
import 'package:flutter_learn/model/web_view_model.dart';
import 'package:flutter_learn/util/log_util.dart';
import 'package:flutter_learn/util/toast_util.dart';
import 'package:flutter_learn/view_model/movie_model.dart';
import 'package:flutter_learn/view_model/provider_widget.dart';
import 'package:flutter_learn/view_model/theme_model.dart';
import 'package:flutter_learn/widget/skeleton.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../router_manger.dart';
import 'model/movie_model.dart';

///ViewModel方式
class MovieTabPage extends StatefulWidget {
  @override
  _MovieTabPageState createState() => _MovieTabPageState();
}

class _MovieTabPageState extends State<MovieTabPage>
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
    return ProviderListWidget<MovieTabModel>(
      model: MovieTabModel(_listTab, _listUrls),
      builder: (context, model, child) {
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
                  model.list.length,
                  (i) => MovieItemPage(
                        url: model.list[i],
                      )),
            ),
          ),
        );
      },
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
  ScrollController _scrollController;

  ///是否展示FloatingActionButton
  bool _isShowFloatBtn = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderRefreshListWidget<MovieListModel>(
      model: MovieListModel(widget.url),
      builder: (context, model, child) {
        return ListView.builder(
          ///内容适配
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: model.list.length,
          controller: _scrollController,
          itemBuilder: (context, index) {
            return MovieAdapter(model.list[index]);
          },
        );
      },
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
          return MovieAdapter(data[index]);
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
  const MovieAdapter(this.item, {Key key}) : super(key: key);
  final Subjects item;
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
