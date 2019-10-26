import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_learn/model/web_view_model.dart';
import 'package:flutter_learn/util/share_util.dart';
import 'package:flutter_learn/util/toast_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

///加载网页
class WebViewPage extends StatefulWidget {
  const WebViewPage(
    this.model, {
    Key key,
  }) : super(key: key);

  final WebViewModel model;

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController _webViewController;
  Completer<bool> _finishedCompleter = Completer();
  ValueNotifier canGoBack = ValueNotifier(false);
  ValueNotifier canGoForward = ValueNotifier(false);
  bool _loading = true;
  String currentUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model.title),
      ),
      body: Column(
        children: <Widget>[
          // 模糊进度条(会执行一个动画)
          _loading
              ? LinearProgressIndicator(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).accentColor),
                )
              : Container(),
          Expanded(
            flex: 1,
            child: SafeArea(
              child: WebView(
                initialUrl: widget.model.url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController web) {
                  print("onWebViewCreated");
                  _webViewController = web;

                  ///webView 创建调用，
                  web.canGoBack().then((value) {
                    ///是否能返回上一级
                    canGoBack.value(value);
                  });
                  web.currentUrl().then((url) {
                    ///返回当前url
                    currentUrl = url;
                  });
                  web.canGoForward().then((value) {
                    ///是否能前进
                    canGoForward.value(value);
                  });
                },
                onPageFinished: (String value) async {
                  print("onPageFinished:" + value);
                  ///webView页面加载调用
                  setState(() {
                    _loading = false;
                  });
                  refreshNavigator();
                },
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: IconTheme(
        data: Theme.of(context).iconTheme.copyWith(
              color: Theme.of(context).accentColor,
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ValueListenableBuilder(
              valueListenable: canGoBack,
              builder: (context, value, child) => IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: !value
                      ? null
                      : () {
                          _webViewController.goBack();
                          refreshNavigator();
                        }),
            ),
            ValueListenableBuilder(
              valueListenable: canGoForward,
              builder: (context, value, child) => IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: !value
                      ? null
                      : () {
                          _webViewController.goForward();
                          refreshNavigator();
                        }),
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _webViewController.reload();
              },
            ),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                ShareUtil.share(
                    widget.model.title + currentUrl ?? widget.model.url);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 刷新导航按钮
  ///
  /// 目前主要用来控制 '前进','后退'按钮是否可以点击
  /// 但是目前该方法没有合适的调用时机.
  /// 在[onPageFinished]中,会遗漏正在加载中的状态
  /// 在[navigationDelegate]中,会存在页面还没有加载就已经判断过了.
  void refreshNavigator() {
    /// 是否可以后退
    _webViewController.canGoBack().then((value) {
      debugPrint('canGoBack--->$value');
      return canGoBack.value = value;
    });

    /// 是否可以前进
    _webViewController.canGoForward().then((value) {
      debugPrint('canGoForward--->$value');
      return canGoForward.value = value;
    });
  }
}
