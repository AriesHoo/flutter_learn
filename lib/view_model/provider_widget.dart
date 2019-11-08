import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/generated/i18n.dart';
import 'package:flutter_learn/view_model/view_state_refresh_list_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'view_state_list_model.dart';
import 'view_state_widget.dart';
import 'package:provider/provider.dart';

/// Provider封装类
///
/// 方便数据初始化
class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final ValueWidgetBuilder<T> builder;
  final T model;
  final Widget child;
  final Function(T) onModelReady;

  ProviderWidget({
    Key key,
    @required this.builder,
    @required this.model,
    this.child,
    this.onModelReady,
  }) : super(key: key);

  _ProviderWidgetState<T> createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  T model;

  @override
  void initState() {
    model = widget.model;
    widget.onModelReady?.call(model);
    super.initState();
  }

  @override
  void dispose() {
    if (model != null) {
      model.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}

///获取单个list列表
class ProviderListWidget<T extends ViewStateListModel>
    extends ProviderWidget<T> {
  ProviderListWidget({
    Key key,
    @required ValueWidgetBuilder<T> builder,
    @required T model,
    Widget child,
    Function(T) onModelReady,
  }) : super(
            key: key,
            model: model,
            child: child,
            onModelReady: (model) {
              model.initData();
              onModelReady?.call(model);
            },
            builder: (context, model, child) {
              if (model.loading) {
                return ViewStateBusyWidget();
              } else if (model.error && model.list.isEmpty) {
                return ViewStateErrorWidget(
                    error: model.viewStateError, onPressed: model.initData);
              }
              return builder(context, model, child);
            });
}

///配合下拉刷新功能
class ProviderRefreshListWidget<T extends ViewStateRefreshListModel> extends ProviderListWidget<T>{
  ProviderRefreshListWidget({
    Key key,
    @required ValueWidgetBuilder<T> builder,
    @required T model,
    Widget child,
    Function(T) onModelReady,
  }) : super(
      key: key,
      model: model,
      child: child,
      onModelReady: (model) {
        model.initData();
        onModelReady?.call(model);
      },
      builder: (context, model, child) {
        if (model.loading) {
          return ViewStateBusyWidget();
        } else if (model.error && model.list.isEmpty) {
          return ViewStateErrorWidget(
              error: model.viewStateError, onPressed: model.initData);
        }
        ///加载成功后
        return Scaffold(
          body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: MaterialClassicHeader(
              backgroundColor: Theme.of(context).appBarTheme.color,
              color: Theme.of(context).appBarTheme.textTheme.title.color,
            ),
            footer: SmartLoadFooterWidget(),
            controller: model.refreshController,
            onRefresh: model.refresh,
            onLoading: model.loadMore,
            child: builder(context, model, child),
          ),
        );
      });
}

class ProviderWidget2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(BuildContext context, A model1, B model2, Widget child)
      builder;
  final A model1;
  final B model2;
  final Widget child;
  final Function(A, B) onModelReady;

  ProviderWidget2({
    Key key,
    @required this.builder,
    @required this.model1,
    @required this.model2,
    this.child,
    this.onModelReady,
  }) : super(key: key);

  _ProviderWidgetState2<A, B> createState() => _ProviderWidgetState2<A, B>();
}

class _ProviderWidgetState2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends State<ProviderWidget2<A, B>> {
  A model1;
  B model2;

  @override
  void initState() {
    model1 = widget.model1;
    model2 = widget.model2;
    widget.onModelReady?.call(model1, model2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<A>.value(value: model1),
          ChangeNotifierProvider<B>.value(value: model2),
        ],
        child: Consumer2<A, B>(
          builder: widget.builder,
          child: widget.child,
        ));
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
