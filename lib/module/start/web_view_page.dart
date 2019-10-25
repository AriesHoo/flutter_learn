import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

///加载网页
class WebViewPage extends StatefulWidget {
  const WebViewPage({
    Key key,
    this.url,
    this.title,
  }) : super(key: key);

  ///目标url
  final String url;

  ///标题
  final String title;

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? "网页测试"),
      ),
      body: SafeArea(
        bottom: false,
        child: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController web) {
            // webview 创建调用，
            web.loadUrl(widget.url);
            web.canGoBack().then((res) {
              print(res); // 是否能返回上一级
            });
            web.currentUrl().then((url) {
              print(url); // 返回当前url
            });
            web.canGoForward().then((res) {
              print(res); //是否能前进
            });
          },
          onPageFinished: (String value) {
            // webview 页面加载调用
          },
        ),
      ),
    );
  }
}
