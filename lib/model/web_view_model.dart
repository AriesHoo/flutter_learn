/// WebViewPage 加载网页参数实体
class WebViewModel {
  ///网页url--例http://www.baidu.com
  String url;

  ///标题
  String title;

  ///快速生成WebViewModel
  static WebViewModel getModel(String title, String url) {
    WebViewModel model = WebViewModel();
    model.title = title;
    model.url = url;
    return model;
  }
}
