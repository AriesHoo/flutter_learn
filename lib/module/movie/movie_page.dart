import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/data/movie_api.dart';
import 'package:flutter_learn/generated/i18n.dart';
import 'package:flutter_learn/module/movie/model/movie_model.dart';
import 'package:flutter_learn/module/movie/movie_view_model_page.dart';
import 'package:flutter_learn/util/log_util.dart';
import 'package:flutter_learn/view_model/basis/basis_provider_widget.dart';
import 'package:flutter_learn/view_model/basis/basis_view_model.dart';
import 'package:flutter_learn/view_model/basis/view_state_widget.dart';
import 'package:flutter_learn/view_model/theme_model.dart';
import 'package:flutter_learn/view_model/basis/view_state.dart';
import 'package:flutter_learn/widget/skeleton.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///豆瓣电影-常规操作
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
  List<Subjects> _listData = [];

  ///下拉刷新controller
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ScrollController _scrollController;
  bool _isDispose = false;

  ///是否展示FloatingActionButton
  bool _isShowFloatBtn = false;

  BasisViewModel _model = BasisViewModel(viewState: ViewState.loading);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    ///设置滚动监听
    _scrollController.addListener(() {
      bool show = _scrollController.offset > 600;
      if (show != _isShowFloatBtn) {
        setState(() {
          _isShowFloatBtn = show;
        });
      }
    });
    refresh(init: true);
  }

  @override
  void dispose() {
    _isDispose = true;
    _scrollController.dispose();
    super.dispose();
  }

  Future getMovie(int page) async {
    return await MovieApi.getMovie(widget.url, page * _pageSize, _pageSize);
  }

  Future<List<Subjects>> refresh({bool init = false}) async {
    try {
      _page = 0;
      var data = await getMovie(0);
      if (data.isEmpty) {
        _refreshController.refreshCompleted(resetFooterState: true);
        _listData.clear();
        _model.setEmpty();
      } else {
        _listData.clear();
        _listData.addAll(data);
        _refreshController.refreshCompleted();

        /// 小于分页的数量,禁止上拉加载更多
        if (data.length < _pageSize) {
          _refreshController.loadNoData();
        } else {
          ///防止上次上拉加载更多失败,需要重置状态
          _refreshController.loadComplete();
        }
        _model.setSuccess();
      }
      refreshView();
      return data;
    } catch (e, s) {
      /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
      /// 而是显示之前的页面数据.给出错误提示
      if (init) _listData.clear();
      _refreshController.refreshFailed();
      refreshView();
      return null;
    }
  }

  /// 上拉加载更多
  Future<List<Subjects>> loadMore() async {
    try {
      var data = await getMovie(++_page);
      if (data.isEmpty) {
        _page--;
        _refreshController.loadNoData();
      } else {
        _listData.addAll(data);
        if (data.length < _pageSize) {
          _refreshController.loadNoData();
        } else {
          _refreshController.loadComplete();
        }
      }
      refreshView();
      return data;
    } catch (e, s) {
      _page--;
      _refreshController.loadFailed();
      refreshView();
      return null;
    }
  }

  refreshView() {
    if (!_isDispose) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_model.loading) {
      return SkeletonList(
        builder: (context, index) => MovieSkeleton(),
      );
    } else if (_model.empty) {
      return EmptyStateWidget();
    } else if (_model.error && _listData.isEmpty) {
      return ErrorStateWidget(onPressed: refresh);
    }
    return Scaffold(
      ///下拉刷新嵌套listView
      body: SmartRefresherWidget(
        page: _page,
        pageSize: _pageSize,
        scrollController: _scrollController,
        data: _listData,
        refreshController: _refreshController,
        onRefresh: refresh,
        onLoading: loadMore,
      ),

      ///用于回到顶部
      floatingActionButton: !_isShowFloatBtn
          ? null
          : FloatingActionButton(
              backgroundColor: Theme.of(context).appBarTheme.color,
              child: Icon(
                Icons.arrow_upward,
                color: Theme.of(context).appBarTheme.textTheme.title.color,
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
      physics: ClampingScrollPhysics(),
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
          );
        },
      ),
    );
  }
}
